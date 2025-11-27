import os
import time
import uuid
import requests
import sys
from io import BytesIO
from typing import List, Dict, Any
from supabase import create_client, Client
import pymupdf4llm # <-- NEW: Using this for parsing

# Add backend directory to path
backend_dir = os.path.dirname(os.path.abspath(__file__))
if backend_dir not in sys.path:
    sys.path.insert(0, backend_dir)

# Import our three services
from app.services.grading_service_utils.embedding_service import (
    initialize_embedding_service as init_bge_service,
    get_embeddings
)
from app.services.multimodal_service import (
    initialize_multimodal_service as init_vlm_service,
    get_description_for_image_bytes
)

# --- 1. CONFIGURATION ---
PROCESSING_LOOP_DELAY = 10
SUPABASE_URL = os.environ.get("SUPABASE_URL")
SUPABASE_KEY = os.environ.get("SUPABASE_SERVICE_KEY")
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

# NEW: Bucket for storing extracted images
IMAGE_BUCKET_NAME = "NCERT Images" 

# --- 2. DATABASE INTERACTION ---

# def fetch_pending_chapters() -> List[Dict]:
#     """Fetches NCERT chapters to embed."""
#     try:
#         response = supabase.table('chapters').select('id, storage_path, book_id').eq('embedding_status', 'not_started').limit(5).execute()
#         return response.data
#     except Exception as e:
#         print(f"Error fetching chapters: {e}")
#         return []


def fetch_pending_chapters() -> List[Dict]:
    """Fetches NCERT chapters to embed."""
    try:
        # --- THIS IS THE CHANGE ---
        # Change limit(5) to limit(1) for our test
        response = supabase.table('chapters').select('id, storage_path, book_id').eq('embedding_status', 'not_started').limit(1).execute()
        # --- END OF CHANGE ---
        
        return response.data
    except Exception as e:
        print(f"Error fetching chapters: {e}")
        return []
        

def update_db_status(table_name: str, item_id: uuid.UUID, status: str):
    """Updates the status in the public.chapters table."""
    try:
        supabase.table(table_name).update({'embedding_status': status}).eq('id', item_id).execute()
        print(f"DB Action: Updated {table_name} {item_id} status to '{status}'")
    except Exception as e:
        print(f"Error updating status for {item_id}: {e}")

# --- 3. Main Worker Loop ---
def main_worker_loop():
    """The main loop that processes content."""
    
    try:
        print("Initializing services...")
        init_bge_service()  # Load bge-m3
        init_vlm_service() # Load MiniCPM-V
        print("All services initialized.")
    except Exception as e:
        print(f"Initialization Failed: {e}")
        return

    while True:
        try:
            pending_chapters = fetch_pending_chapters()
            for chapter in pending_chapters:
                item_id = chapter['id']
                book_id = chapter.get('book_id')
                update_db_status('chapters', item_id, 'processing')
                
                try:
                    # 1. Download PDF once
                    print(f"Downloading {chapter['storage_path']}...")
                    response = requests.get(chapter['storage_path'], stream=True)
                    response.raise_for_status() 
                    pdf_bytes = response.content

                    # This will hold all data to be batch-inserted
                    embeddings_to_insert = []

                    # --- 2. TEXT PIPELINE ---
                    print("Running text pipeline...")
                    # Use pymupdf4llm to extract text and chunk it
                    text_chunks = pymupdf4llm.helpers.extract_text_chunks_from_pdf(
                        pdf_bytes,
                        chunk_size=1000,
                        chunk_overlap=100,
                        parse_tables=True # It can convert tables to markdown!
                    )
                    
                    if text_chunks:
                        # Convert chunk objects to a simple list of strings
                        chunk_list = [chunk['text'] for chunk in text_chunks]
                        vectors = get_embeddings(chunk_list)
                        
                        for i, chunk_data in enumerate(text_chunks):
                            embeddings_to_insert.append({
                                'chapter_id': item_id,
                                'book_id': book_id,
                                'content': chunk_data['text'],
                                'page_number': chunk_data['page'],
                                'content_type': 'text',
                                'embedding': vectors[i],
                                'storage_path': None # No image URL for text chunks
                            })
                    print(f"Text pipeline complete. {len(embeddings_to_insert)} text vectors generated.")

                    # --- 3. IMAGE/TABLE PIPELINE ---
                    print("Running image/table pipeline...")
                    # Use pymupdf4llm to extract images
                    images_data = pymupdf4llm.helpers.extract_images_from_pdf(pdf_bytes)
                    
                    image_captions = []
                    image_metadata_list = []

                    for i, image in enumerate(images_data):
                        page_num = image['page']
                        image_bytes = image['bytes']
                        
                        # A. Upload to Supabase Storage
                        image_name = f"{item_id}_page_{page_num}_img_{i}.png"
                        upload_path = f"class-10/{book_id}/{image_name}"
                        print(f"Uploading {image_name} to {IMAGE_BUCKET_NAME}...")
                        supabase.storage.from_(IMAGE_BUCKET_NAME).upload(
                            path=upload_path,
                            file=image_bytes,
                            file_options={"content-type": "image/png", "upsert": "true"}
                        )
                        
                        # B. Caption with MiniCPM-V
                        print(f"Captioning image {i} on page {page_num}...")
                        caption = get_description_for_image_bytes(image_bytes)
                        
                        if not caption.startswith("[Error:"):
                            image_captions.append(caption)
                            image_metadata_list.append({
                                'page_number': page_num,
                                'content_type': 'image_description',
                                'storage_path': upload_path # Store the new path
                            })

                    # C. Embed all captions in one batch
                    if image_captions:
                        image_vectors = get_embeddings(image_captions)
                        
                        for i, caption in enumerate(image_captions):
                            meta = image_metadata_list[i]
                            embeddings_to_insert.append({
                                'chapter_id': item_id,
                                'book_id': book_id,
                                'content': caption, # Store the caption as content
                                'page_number': meta['page_number'],
                                'content_type': meta['content_type'],
                                'embedding': image_vectors[i],
                                'storage_path': meta['storage_path'] # Store the image path
                            })
                    print(f"Image pipeline complete. {len(image_captions)} image vectors generated.")

                    # --- 4. BATCH INSERT to Supabase ---
                    if embeddings_to_insert:
                        print(f"Inserting {len(embeddings_to_insert)} total vectors into Supabase...")
                        supabase.table('chapter_embeddings').insert(embeddings_to_insert).execute()
                        update_db_status('chapters', item_id, 'completed')
                    else:
                        print(f"No content found for chapter {item_id}.")
                        update_db_status('chapters', item_id, 'failed')
                
                except Exception as e:
                    print(f"Fatal error processing chapter {item_id}: {e}")
                    update_db_status('chapters', item_id, 'failed')

        except Exception as e:
            print(f"Worker Loop Error: {e}")
        
        print(f"Cycle complete. Sleeping for {PROCESSING_LOOP_DELAY}s.")
        time.sleep(PROCESSING_LOOP_DELAY)

if __name__ == '__main__':
    main_worker_loop()