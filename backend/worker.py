"""
RabbitMQ Worker for Studious Grading

This script runs as a separate, long-running process to consume
grading jobs from the queue and execute the AI pipeline.
"""
import pika
import json
import os
import sys
from pathlib import Path
import uuid

# --- Add the 'backend' directory to the Python path ---
# This allows the worker to import 'app' modules
SCRIPT_DIR = Path(__file__).parent
sys.path.append(str(SCRIPT_DIR))

# --- Import all necessary services and models ---
# These are the same imports the background task would have needed
from app.services.grading_service import GradingService
from app.models.assignment import AssignmentSubmission
from app.models.assessment import AssessmentItem

# --- Mock DB (Same as in assignments.py) ---
# In production, this would be a real DB connection pool
class MockDB:
    def __init__(self):
        self.submissions = {}
        self.items = {
            1: AssessmentItem(id=1, question_type="short_answer", points=10, correct_answer="The mitochondria is the powerhouse of the cell."),
            2: AssessmentItem(id=2, question_type="multiple_choice", points=5, correct_answer="A"),
            3: AssessmentItem(id=3, question_type="long_answer", points=25, correct_answer="A detailed explanation of photosynthesis..."),
        }
        self.texts = {
            3: ["This is another student's answer about photosynthesis..."]
        }

    def get_submission(self, sub_id):
        # We create a submission object on-the-fly for the worker
        # In a real app, you'd fetch this from the DB
        if sub_id not in self.submissions:
             self.submissions[sub_id] = AssignmentSubmission(id=sub_id, student_id=None, assignment_id=None, status="PROCESSING")
        return self.submissions.get(sub_id)

    def get_items_for_assignment(self, ass_id): return list(self.items.values())
    def get_other_student_texts(self, ass_id, student_id): return self.texts
    
    def save_grading_result(self, sub_id, result):
        print("------------------------------------------")
        print(f"--- SAVING TO DB (Submission {sub_id}) ---")
        print(json.dumps(result, indent=2))
        print("------------------------------------------")
        if sub_id in self.submissions:
            self.submissions[sub_id].status = "GRADED"
            self.submissions[sub_id].score = result['total_points']

    def update_submission_status(self, sub_id, status, error=None):
        print(f"--- UPDATING STATUS (Submission {sub_id}) ---")
        print(f"New Status: {status}")
        if error:
            print(f"Error: {error}")
        if sub_id in self.submissions:
            self.submissions[sub_id].status = status

# Initialize services (these will be loaded once per worker)
print("Initializing GradingService...")
grading_service = GradingService()
db = MockDB()
print("Services initialized.")

def run_grading_pipeline(job_data: dict):
    """
    The main logic for processing a grading job.
    """
    submission_id = job_data['submission_id']
    assignment_id = job_data['assignment_id']
    student_id = job_data['student_id']
    saved_files_info = job_data['saved_files_info']
    
    print(f"\n[Worker]: Starting grading for submission {submission_id}...")
    try:
        db.update_submission_status(submission_id, "PROCESSING")

        # 1. Fetch data
        submission = db.get_submission(submission_id)
        assessment_items = db.get_items_for_assignment(assignment_id)
        other_texts_map = db.get_other_student_texts(assignment_id, student_id)
        
        # 2. Format inputs for grading_service
        answers_map = {info['item_id']: str(info['path']) for info in saved_files_info}
        mime_types_map = {info['item_id']: info['mime'] for info in saved_files_info}

        # 3. --- RUN THE FULL PIPELINE ---
        grading_result = grading_service.grade_submission(
            submission=submission,
            assessment_items=assessment_items,
            answers=answers_map,
            file_mime_types=mime_types_map,
            all_submission_texts_map=other_texts_map
        )
        
        # 4. Save results to DB
        db.save_grading_result(submission_id, grading_result)
        print(f"[Worker]: Successfully graded submission {submission_id}.")

    except Exception as e:
        print(f"[Worker ERROR]: Grading failed for {submission_id}: {e}")
        db.update_submission_status(submission_id, "FAILED", error=str(e))
        # Note: We re-raise the exception to 'nack' the message
        raise e


def main():
    RABBITMQ_URL = os.environ.get("RABBITMQ_URL", "amqp://guest:guest@localhost:5672/")
    GRADING_QUEUE = "grading_queue"
    
    connection = pika.BlockingConnection(pika.URLParameters(RABBITMQ_URL))
    channel = connection.channel()
    
    channel.queue_declare(queue=GRADING_QUEUE, durable=True)
    print(f"[*] Worker waiting for messages in '{GRADING_QUEUE}'. To exit press CTRL+C")

    def callback(ch, method, properties, body):
        print(f"\n[Worker]: Received job... (Delivery Tag: {method.delivery_tag})")
        try:
            job_data = json.loads(body.decode('utf-8'))
            
            # --- This is where the work happens ---
            run_grading_pipeline(job_data)
            # ---
            
            # Acknowledge the message (it's done)
            ch.basic_ack(delivery_tag=method.delivery_tag)
            print(f"[Worker]: Job finished. Acknowledged message.")

        except Exception as e:
            # Reject the message
            print(f"[Worker]: Job FAILED. Rejecting message. Error: {e}")
            # 'requeue=False' sends it to a dead-letter-exchange (if configured)
            # or just drops it. This prevents poison-pill messages from
            # crashing the worker in a loop.
            ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)

    # Only fetch one message at a time (prefetch_count=1)
    # This ensures a slow job doesn't cause other jobs to pile up on this worker
    channel.basic_qos(prefetch_count=1)
    channel.basic_consume(queue=GRADING_QUEUE, on_message_callback=callback)
    
    channel.start_consuming()

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('Interrupted')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)