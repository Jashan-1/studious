import os
import time
import uuid
import requests
import sys
from io import BytesIO
from pypdf import PdfReader
from typing import List, Dict, Any
from supabase import create_client, Client

# Add backend directory to path for imports
backend_dir = os.path.dirname(os.path.abspath(__file__))
if backend_dir not in sys.path:
    sys.path.insert(0, backend_dir)

from app.services.grading_service_utils.embedding_service import (
    initialize_embedding_service,
    generate_and_upsert_embeddings
)

# --- 1. CONFIGURATION ---
PROCESSING_LOOP_DELAY = 10 

try:
    SUPABASE_URL = os.environ.get("SUPABASE_URL")
    SUPABASE_KEY = os.environ.get("SUPABASE_SERVICE_KEY") # Use Service Key for worker
    supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)
except Exception as e:
    print(f"FATAL: Failed to initialize Supabase client. Check ENV variables. Error: {e}")
    exit()

# --- 2. HELPER FUNCTIONS (PDF, Chunking) ---

def extract_text_from_pdf_url(url: str) -> str:
    """Downloads PDF binary data and extracts text from the stream."""
    try:
        # This will now download from the Supabase Storage URL
        response = requests.get(url, stream=True)
        response.raise_for_status() 
        pdf_stream = BytesIO(response.content)
        reader = PdfReader(pdf_stream)
        raw_text = ""
        for page in reader.pages:
            raw_text += page.extract_text()
        return raw_text
    except Exception as e:
        print(f"Failed to download/parse PDF from {url}: {e}")
        return ""

def chunk_text(text: str, chunk_size: int = 1000, overlap: int = 100) -> List[str]:
    """Simple text chunker."""
    chunks = []
    start = 0
    while start < len(text):
        end = start + chunk_size
        chunks.append(text[start:end])
        start += chunk_size - overlap
    return chunks

# --- 3. DATABASE INTERACTION ---

def fetch_pending_chapters() -> List[Dict]:
    """Fetches NCERT chapters to embed."""
    try:
        response = supabase.table('chapters').select('id, storage_path, book_id').eq('embedding_status', 'not_started').limit(5).execute()
        return response.data
    except Exception as e:
        print(f"Error fetching chapters: {e}")
        return []

def fetch_pending_uploads() -> List[Dict]:
    """Fetches private teacher/student uploads to embed."""
    try:
        response = supabase.table('uploads').select('id, storage_path, org_id, uploaded_by').eq('embedding_status', 'not_started').limit(5).execute()
        return response.data
    except Exception as e:
        print(f"Error fetching uploads: {e}")
        return []

def update_db_status(table_name: str, item_id: uuid.UUID, status: str):
    """Updates the status in the public.chapters or public.uploads table."""
    try:
        supabase.table(table_name).update({'embedding_status': status}).eq('id', item_id).execute()
        print(f"DB Action: Updated {table_name} {item_id} status to '{status}'")
    except Exception as e:
        print(f"Error updating status for {item_id}: {e}")

def log_embeddings_to_db(metadata_log: List[Dict]):
    """Inserts the pinecone_id and metadata into the public.embeddings table."""
    try:
        supabase.table('embeddings').insert(metadata_log).execute()
        print(f"DB Action: Logged {len(metadata_log)} embeddings to public.embeddings.")
    except Exception as e:
        print(f"Error logging embeddings: {e}")

# --- 4. NEW: STORAGE CLEANUP FUNCTION ---
def cleanup_storage(bucket_name: str, item_id: uuid.UUID):
    """Deletes the temporary PDF from Supabase Storage."""
    try:
        file_path = f"public/{item_id}.pdf"
        supabase.storage.from_(bucket_name).remove([file_path])
        print(f"Storage Action: Cleaned up {file_path} from {bucket_name}")
    except Exception as e:
        # Don't fail the whole job, just log the error
        print(f"Warning: Failed to cleanup storage for {item_id}.pdf: {e}")

# --- 5. Main Worker Loop ---
def main_worker_loop():
    """The main loop that checks for and processes both global and private content."""
    
    try:
        initialize_embedding_service()
    except Exception as e:
        print(f"Initialization Failed: {e}")
        return

    while True:
        try:
            # --- A. Process Global NCERT Chapters ---
            pending_chapters = fetch_pending_chapters()
            for chapter in pending_chapters:
                item_id = chapter['id']
                update_db_status('chapters', item_id, 'processing')
                
                try:
                    raw_text = extract_text_from_pdf_url(chapter['storage_path'])
                    if not raw_text:
                        update_db_status('chapters', item_id, 'failed')
                        continue
                    
                    text_chunks = chunk_text(raw_text)
                    
                    base_metadata = {
                        'org_id': 'NULL', 
                        'source': 'ncert',
                        'chapter_id': str(chapter['id']),
                        'book_id': str(chapter.get('book_id', 'NULL'))
                    }
                    
                    db_log = generate_and_upsert_embeddings(
                        item_id=item_id,
                        text_chunks=text_chunks,
                        base_metadata=base_metadata,
                        namespace='ncert-global',
                        log_key='chapter_id' 
                    )
                    
                    log_embeddings_to_db(db_log)
                    update_db_status('chapters', item_id, 'completed')
                    
                    # --- NEW CLEANUP STEP ---
                    cleanup_storage("ncert-pdfs", item_id)

                except Exception as e:
                    print(f"Fatal error processing chapter {item_id}: {e}")
                    update_db_status('chapters', item_id, 'failed')

            # --- B. Process Private Tenant Uploads ---
            pending_uploads = fetch_pending_uploads()
            for upload in pending_uploads:
                item_id = upload['id']
                update_db_status('uploads', item_id, 'processing')
                
                try:
                    raw_text = extract_text_from_pdf_url(upload['storage_path'])
                    if not raw_text:
                        update_db_status('uploads', item_id, 'failed')
                        continue
                    
                    text_chunks = chunk_text(raw_text)
                    
                    base_metadata = {
                        'org_id': str(upload['org_id']), 
                        'source': 'upload',
                        'upload_id': str(upload['id']),
                        'uploaded_by': str(upload.get('uploaded_by', 'NULL'))
                    }
                    
                    db_log = generate_and_upsert_embeddings(
                        item_id=item_id,
                        text_chunks=text_chunks,
                        base_metadata=base_metadata,
                        namespace='tenant-private',
                        log_key='upload_id'
                    )
                    
                    log_embeddings_to_db(db_log)
                    update_db_status('uploads', item_id, 'completed')

                    # --- NEW CLEANUP STEP ---
                    # You'll need a different bucket for private uploads
                    cleanup_storage("tenant-uploads", item_id) 

                except Exception as e:
                    print(f"Fatal error processing upload {item_id}: {e}")
                    update_db_status('uploads', item_id, 'failed')

        except Exception as e:
            print(f"Worker Loop Error: {e}")
        
        print(f"Cycle complete. Sleeping for {PROCESSING_LOOP_DELAY}s.")
        time.sleep(PROCESSING_LOOP_DELAY)

if __name__ == '__main__':
    main_worker_loop()