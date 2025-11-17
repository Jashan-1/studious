"""
RabbitMQ Publisher Utility
"""
import pika
import json
import os

# Get RabbitMQ connection string from environment variables
RABBITMQ_URL = os.environ.get("RABBITMQ_URL", "amqp://guest:guest@localhost:5672/")
GRADING_QUEUE = "grading_queue"

def publish_grading_job(job_data: dict):
    """
    Publishes a grading job to the RabbitMQ queue.
    
    :param job_data: A dictionary containing all info needed for the worker
                     (e.g., submission_id, file_paths, mime_types)
    """
    try:
        connection = pika.BlockingConnection(pika.URLParameters(RABBITMQ_URL))
        channel = connection.channel()
        
        # Ensure the queue exists
        channel.queue_declare(queue=GRADING_QUEUE, durable=True)
        
        # Publish the message
        channel.basic_publish(
            exchange='',
            routing_key=GRADING_QUEUE,
            body=json.dumps(job_data),
            properties=pika.BasicProperties(
                delivery_mode=2,  # Make message persistent
            ))
        
        connection.close()
        print(f"[MQ Publisher]: Successfully sent job for submission {job_data.get('submission_id')}")
        return True
    
    except Exception as e:
        print(f"[MQ Publisher ERROR]: Failed to publish job. Error: {e}")
        # In production, you'd have a retry or error-logging policy
        return False