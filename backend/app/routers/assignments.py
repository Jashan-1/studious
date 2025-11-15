"""
API Router for Assignments and Submissions
"""
from fastapi import (
    APIRouter, Depends, UploadFile, File, Form, 
    BackgroundTasks, HTTPException, status
)
from typing import List, Dict, Any
from pathlib import Path
import aiofiles  # For async file operations
import uuid
import os

# Import your services
from app.services.grading_service import GradingService

# --- Mock DB Models & Session (Replace with your actual DB) ---
# This is just to make the example runnable and show the logic
from app.models.assignment import AssignmentSubmission
from app.models.assessment import AssessmentItem

class MockDBSession:
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

    def get_submission(self, sub_id): return self.submissions.get(sub_id)
    def get_items_for_assignment(self, ass_id): return list(self.items.values())
    def get_other_student_texts(self, ass_id, student_id): return self.texts
    def create_submission(self, student_id, ass_id):
        sub = AssignmentSubmission(id=uuid.uuid4(), student_id=student_id, assignment_id=ass_id, status="PROCESSING")
        self.submissions[sub.id] = sub
        return sub
    def save_grading_result(self, sub_id, result):
        print(f"--- SAVING TO DB (Submission {sub_id}) ---")
        print(result)
        self.submissions[sub_id].status = "GRADED"
        self.submissions[sub_id].score = result['total_points']
    def update_submission_status(self, sub_id, status, error=None):
        if sub_id in self.submissions:
            self.submissions[sub_id].status = status
            print(f"Submission {sub_id} status updated to: {status}")
            if error: print(f"Error: {error}")

def get_db_session(): yield MockDBSession()
def get_grading_service():
    # This single dependency will init all sub-services
    return GradingService()
# --- End Mock DB ---


router = APIRouter()
TEMP_UPLOADS_DIR = Path("temp_uploads")
TEMP_UPLOADS_DIR.mkdir(exist_ok=True)

# --- The Background Task Function ---

async def run_grading_pipeline(
    submission_id: str,
    assignment_id: int,
    student_id: int,
    saved_files_info: List[Dict[str, Any]],
    grading_service: GradingService,
    db: MockDBSession
):
    """
    This function runs in the background.
    It calls all your services in order.
    """
    print(f"\n[Background Task]: Starting grading for submission {submission_id}...")
    try:
        # 1. Fetch data needed for grading
        submission = db.get_submission(submission_id)
        assessment_items = db.get_items_for_assignment(assignment_id)
        
        # 2. Get other students' texts for Module B (plagiarism)
        # In a real app, this queries your DB for extracted text from other submissions
        other_texts_map = db.get_other_student_texts(assignment_id, student_id)
        
        # 3. Format answers for the grading service
        # {item_id: "path/to/file.pdf"}
        answers_map = {
            info['item_id']: str(info['path']) 
            for info in saved_files_info
        }
        
        # 4. Format mime_types for the vision service
        # {item_id: "application/pdf"}
        mime_types_map = {
            info['item_id']: info['mime'] 
            for info in saved_files_info
        }

        # 5. --- RUN THE FULL PIPELINE ---
        grading_result = grading_service.grade_submission(
            submission=submission,
            assessment_items=assessment_items,
            answers=answers_map,
            file_mime_types=mime_types_map, # Pass mime types
            all_submission_texts_map=other_texts_map # Pass other texts
        )
        
        # 6. Save results to DB
        db.save_grading_result(submission_id, grading_result)
        print(f"[Background Task]: Successfully graded submission {submission_id}.")

    except Exception as e:
        print(f"[Background Task ERROR]: Grading failed for {submission_id}: {e}")
        db.update_submission_status(submission_id, "FAILED", error=str(e))
    
    finally:
        # 7. Cleanup: Delete temporary files
        print(f"[Background Task]: Cleaning up files for {submission_id}...")
        try:
            for info in saved_files_info:
                os.remove(info['path'])
            # Remove the submission-specific directory
            submission_dir = TEMP_UPLOADS_DIR / str(submission_id)
            if submission_dir.exists():
                os.rmdir(submission_dir)
        except Exception as e:
            print(f"[Cleanup Error]: {e}")


# --- The API Endpoint ---

@router.post(
    "/{assignment_id}/submit",
    status_code=status.HTTP_202_ACCEPTED,
    tags=["assignments"]
)
async def submit_assignment_for_grading(
    assignment_id: int,
    background_tasks: BackgroundTasks,
    student_id: int = Form(...),
    item_ids: str = Form(..., description="Comma-separated list of item IDs, matching the order of files. e.g., '1,3,2'"),
    files: List[UploadFile] = File(..., description="List of PDF or image files."),
    db: MockDBSession = Depends(get_db_session),
    grading_service: GradingService = Depends(get_grading_service)
):
    """
    Submit multiple files for an assignment.
    
    This endpoint accepts files, saves them, and schedules a background
    task for grading. It returns an immediate 202 response.
    """
    
    # 1. Validate input
    item_id_list = item_ids.split(',')
    if len(item_id_list) != len(files):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Mismatch: {len(item_id_list)} item IDs provided for {len(files)} files."
        )

    # 2. Create a preliminary Submission record in the DB
    submission = db.create_submission(
        student_id=student_id, 
        ass_id=assignment_id
    )
    submission_id = submission.id
    
    # 3. Save all files asynchronously
    save_dir = TEMP_UPLOADS_DIR / str(submission_id)
    save_dir.mkdir(exist_ok=True)
    saved_files_info = []

    try:
        for i, file in enumerate(files):
            item_id = int(item_id_list[i].strip())
            # Use a unique, simple name
            file_ext = Path(file.filename).suffix
            save_path = save_dir / f"item_{item_id}{file_ext}"

            # Asynchronously write file to disk
            async with aiofiles.open(save_path, 'wb') as f:
                while content := await file.read(1024 * 1024):  # Read in 1MB chunks
                    await f.write(content)
            
            saved_files_info.append({
                "path": save_path,
                "mime": file.content_type,
                "item_id": item_id
            })
            
    except Exception as e:
        # If file saving fails, mark submission as FAILED
        db.update_submission_status(submission_id, "FAILED", error=f"File upload error: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Could not save file: {e}"
        )

    # 4. Add the heavy-lifting to the background queue
    background_tasks.add_task(
        run_grading_pipeline,
        submission_id=submission_id,
        assignment_id=assignment_id,
        student_id=student_id,
        saved_files_info=saved_files_info,
        grading_service=grading_service,
        db=db
    )
    
    # 5. Return immediate response
    return {
        "message": "Submission accepted. Grading is in progress.",
        "submission_id": submission_id,
        "status": "PROCESSING"
    }