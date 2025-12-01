# import os
# import time
# import uuid
# import requests
# import sys
# from io import BytesIO
# from typing import List, Dict, Any
# from supabase import create_client, Client
# import pymupdf4llm  # Using this for parsing
# import pymupdf as fitz  # PyMuPDF for opening PDFs
# from langchain_text_splitters import RecursiveCharacterTextSplitter
# from urllib.parse import quote

# # Add backend directory to path
# backend_dir = os.path.dirname(os.path.abspath(__file__))
# if backend_dir not in sys.path:
#     sys.path.insert(0, backend_dir)

# # Import our three services
# from app.services.grading_service_utils.embedding_service import (
#     initialize_embedding_service as init_bge_service,
#     get_embeddings
# )
# from app.services.multimodal_service import (
#     initialize_multimodal_service as init_vlm_service,
#     get_description_for_image_bytes
# )

# # --- 1. CONFIGURATION ---
# PROCESSING_LOOP_DELAY = 10
# SUPABASE_URL = os.environ.get("SUPABASE_URL")
# SUPABASE_KEY = os.environ.get("SUPABASE_SERVICE_KEY")
# supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

# PDF_BUCKET_NAME = "NCERT Books"
# IMAGE_BUCKET_NAME = "NCERT Images" 

# # --- 2. DATABASE INTERACTION ---

# def fetch_pending_chapters() -> List[Dict]:
#     """Fetches NCERT chapters to embed."""
#     try:
#         response = supabase.table('chapters').select('id, metadata, book_id').eq('embedding_status', 'not_started').limit(1).execute()
#         return response.data
#     except Exception as e:
#         print(f"Error fetching chapters: {e}")
#         return []

# def update_db_status(table_name: str, item_id: uuid.UUID, status: str):
#     """Updates the status in the public.chapters table."""
#     try:
#         supabase.table(table_name).update({'embedding_status': status}).eq('id', item_id).execute()
#         print(f"DB Action: Updated {table_name} {item_id} status to '{status}'")
#     except Exception as e:
#         print(f"Error updating status for {item_id}: {e}")

# # --- 3. Main Worker Loop ---
# def main_worker_loop():
#     """The main loop that processes content."""
    
#     try:
#         print("Initializing services...")
#         init_bge_service()  # Load bge-m3
#         init_vlm_service() # Load MiniCPM-V
#         print("All services initialized.")
#     except Exception as e:
#         print(f"Initialization Failed: {e}")
#         return

#     while True:
#         try:
#             pending_chapters = fetch_pending_chapters()
#             for chapter in pending_chapters:
#                 item_id = chapter['id']
#                 book_id = chapter.get('book_id')
#                 metadata = chapter.get('metadata', {})
                
#                 update_db_status('chapters', item_id, 'processing')
                
#                 try:
#                     pdf_path = metadata.get('supabase_storage_path')
                    
#                     if not pdf_path:
#                         print(f"Skipping chapter {item_id}: 'supabase_storage_path' not found in metadata.")
#                         update_db_status('chapters', item_id, 'error')
#                         continue
                        
#                     pdf_url = f"{SUPABASE_URL}/storage/v1/object/public/{quote(PDF_BUCKET_NAME)}/{quote(pdf_path)}"
                    
#                     print(f"Downloading {pdf_url}...")
#                     response = requests.get(pdf_url, stream=True)
#                     response.raise_for_status() 
#                     pdf_bytes = response.content

#                     embeddings_to_insert = []

#                     # --- 2. TEXT PIPELINE ---
#                     print("Running text pipeline...")
                    
#                     # Open PDF from bytes
#                     doc = fitz.open(stream=pdf_bytes, filetype="pdf")
                    
#                     # Extract text using pymupdf4llm (converts to markdown with better structure)
#                     markdown_result = pymupdf4llm.to_markdown(
#                         doc,
#                         write_images=False,  # We'll handle images separately
#                         page_chunks=True,  # Get page-by-page chunks
#                         table_strategy='lines_strict'  # Better table handling
#                     )
                    
#                     # to_markdown with page_chunks=True returns a list of strings (one per page)
#                     # If it returns a single string, convert to list
#                     if isinstance(markdown_result, str):
#                         # Split by page separators if it's a single string
#                         page_texts = markdown_result.split('\n\n---\n\n')  # Common page separator
#                         if len(page_texts) == 1:
#                             # If no separators, treat as single page
#                             page_texts = [markdown_result]
#                     else:
#                         page_texts = markdown_result if isinstance(markdown_result, list) else [str(markdown_result)]
                    
#                     # Split into chunks using langchain's text splitter
#                     text_splitter = RecursiveCharacterTextSplitter(
#                         chunk_size=1000,
#                         chunk_overlap=100,
#                         length_function=len,
#                     )
                    
#                     # Process each page's markdown
#                     text_chunks = []
#                     for page_num, page_markdown in enumerate(page_texts, start=1):
#                         if not page_markdown or not str(page_markdown).strip():
#                             continue
                        
#                         # Split this page's content into chunks
#                         page_chunks = text_splitter.split_text(str(page_markdown))
                        
#                         for chunk_text in page_chunks:
#                             if chunk_text.strip():  # Only add non-empty chunks
#                                 text_chunks.append({
#                                     'text': chunk_text,
#                                     'page': page_num
#                                 })
                    
#                     doc.close()
                    
#                     if text_chunks:
#                         chunk_list = [chunk['text'] for chunk in text_chunks]
#                         vectors = get_embeddings(chunk_list)
                        
#                         for i, chunk_data in enumerate(text_chunks):
#                             embeddings_to_insert.append({
#                                 'chapter_id': item_id,
#                                 'book_id': book_id,
#                                 'content': chunk_data['text'],
#                                 'page_number': chunk_data['page'],
#                                 'content_type': 'text',
#                                 'embedding': vectors[i],
#                                 'storage_path': None
#                             })
#                     print(f"Text pipeline complete. {len(embeddings_to_insert)} text vectors generated.")

#                     # --- 3. IMAGE/TABLE PIPELINE ---
#                     print("Running image/table pipeline...")
                    
#                     # Reopen PDF for image extraction
#                     doc = fitz.open(stream=pdf_bytes, filetype="pdf")
                    
#                     # Extract images using PyMuPDF
#                     images_data = []
#                     for page_num in range(len(doc)):
#                         page = doc[page_num]
#                         image_list = page.get_images()
                        
#                         for img_index, img in enumerate(image_list):
#                             xref = img[0]
#                             try:
#                                 base_image = doc.extract_image(xref)
#                                 image_bytes = base_image["image"]
#                                 images_data.append({
#                                     'page': page_num + 1,
#                                     'bytes': image_bytes,
#                                     'index': img_index
#                                 })
#                             except Exception as e:
#                                 print(f"Warning: Could not extract image {img_index} from page {page_num + 1}: {e}")
#                                 continue
                    
#                     doc.close()
                    
#                     image_captions = []
#                     image_metadata_list = []

#                     for i, image in enumerate(images_data):
#                         page_num = image['page']
#                         image_bytes = image['bytes']
                        
#                         image_name = f"{item_id}_page_{page_num}_img_{i}.png"
#                         upload_path = f"class-10/{book_id}/{image_name}"
#                         print(f"Uploading {image_name} to {IMAGE_BUCKET_NAME}...")
#                         supabase.storage.from_(IMAGE_BUCKET_NAME).upload(
#                             path=upload_path,
#                             file=image_bytes,
#                             file_options={"content-type": "image/png", "upsert": "true"}
#                         )
                        
#                         print(f"Captioning image {i} on page {page_num}...")
#                         caption = get_description_for_image_bytes(image_bytes)
                        
#                         if not caption.startswith("[Error:"):
#                             image_captions.append(caption)
#                             image_metadata_list.append({
#                                 'page_number': page_num,
#                                 'content_type': 'image_description',
#                                 'storage_path': upload_path
#                             })

#                     if image_captions:
#                         image_vectors = get_embeddings(image_captions)
                        
#                         for i, caption in enumerate(image_captions):
#                             meta = image_metadata_list[i]
#                             embeddings_to_insert.append({
#                                 'chapter_id': item_id,
#                                 'book_id': book_id,
#                                 'content': caption,
#                                 'page_number': meta['page_number'],
#                                 'content_type': meta['content_type'],
#                                 'embedding': image_vectors[i],
#                                 'storage_path': meta['storage_path']
#                             })
#                     print(f"Image pipeline complete. {len(image_captions)} image vectors generated.")

#                     # --- 4. BATCH INSERT to Supabase ---
#                     if embeddings_to_insert:
#                         print(f"Inserting {len(embeddings_to_insert)} total vectors into Supabase...")
#                         supabase.table('chapter_embeddings').insert(embeddings_to_insert).execute()
#                         update_db_status('chapters', item_id, 'completed')
#                     else:
#                         print(f"No content found for chapter {item_id}.")
#                         update_db_status('chapters', item_id, 'error')
                
#                 except Exception as e:
#                     print(f"Fatal error processing chapter {item_id}: {e}")
#                     update_db_status('chapters', item_id, 'error')

#         except Exception as e:
#             print(f"Worker Loop Error: {e}")
        
#         print(f"Cycle complete. Sleeping for {PROCESSING_LOOP_DELAY}s.")
#         time.sleep(PROCESSING_LOOP_DELAY)

# if __name__ == '__main__':
#     main_worker_loop()


import os
import time
import uuid
import requests
import sys
import re
from io import BytesIO
from typing import List, Dict, Any
from supabase import create_client, Client
import pymupdf4llm
import pymupdf as fitz
from langchain_text_splitters import RecursiveCharacterTextSplitter
from urllib.parse import quote
from collections import deque
import numpy as np
from PIL import Image

# Add backend directory to path
backend_dir = os.path.dirname(os.path.abspath(__file__))
if backend_dir not in sys.path:
    sys.path.insert(0, backend_dir)

# Import services
from app.services.grading_service_utils.embedding_service import (
    initialize_embedding_service as init_bge_service,
    get_embeddings
)
from app.services.multimodal_service import (
    initialize_multimodal_service as init_vlm_service,
    get_descriptions_for_batch
)

# --- CONFIGURATION ---
PROCESSING_LOOP_DELAY = 10
SUPABASE_URL = os.environ.get("SUPABASE_URL")
SUPABASE_KEY = os.environ.get("SUPABASE_SERVICE_KEY")
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

PDF_BUCKET_NAME = "NCERT Books"
IMAGE_BUCKET_NAME = "NCERT Images" 

REQUEST_TIMESTAMPS = deque()
MAX_REQUESTS_PER_MINUTE = 15
RATE_LIMIT_WINDOW = 60
GEMINI_BATCH_SIZE = 16

# --- HELPER FUNCTIONS FOR METADATA ENRICHMENT ---

def extract_figure_references_from_text(text: str, page_num: int) -> List[str]:
    """
    Extract figure/activity/table references from surrounding text.
    Returns list like ["Figure 7.1", "Activity 7.2"]
    """
    patterns = [
        r'(Figure|Fig\.|फिगर)\s*(\d+)\.(\d+)',
        r'(Activity|गतिविधि)\s*(\d+)\.(\d+)',
        r'(Table|तालिका)\s*(\d+)\.(\d+)',
        r'(Diagram|आरेख)\s*(\d+)\.(\d+)',
        r'(Example|उदाहरण)\s*(\d+)\.(\d+)'
    ]
    
    references = []
    for pattern in patterns:
        matches = re.finditer(pattern, text, re.IGNORECASE)
        for match in matches:
            ref_type = match.group(1)
            chapter_num = match.group(2)
            fig_num = match.group(3)
            references.append(f"{ref_type} {chapter_num}.{fig_num}")
    
    return references

def create_searchable_image_content(
    gemini_description: str,
    page_number: int,
    image_index: int,
    nearby_text: str = ""
) -> str:
    """
    Creates a metadata-rich description that's searchable in multiple ways.
    
    Format:
    [METADATA: Page X, Image Y]
    [REFERENCES: Figure A.B, Activity C.D]
    
    [DESCRIPTION]
    Gemini's detailed description here...
    
    [CONTEXT]
    Nearby text from the page...
    """
    
    # Extract any figure references from nearby text
    references = extract_figure_references_from_text(nearby_text, page_number)
    
    # Build the enriched content
    parts = []
    
    # 1. Metadata header (always searchable)
    parts.append(f"[METADATA: Page {page_number}, Image {image_index}]")
    
    # 2. References (if found)
    if references:
        refs_str = ", ".join(set(references))  # Remove duplicates
        parts.append(f"[REFERENCES: {refs_str}]")
    
    # 3. Main description from Gemini
    parts.append(f"\n[DESCRIPTION]\n{gemini_description}")
    
    # 4. Context from nearby text (if available)
    if nearby_text.strip():
        # Limit context to 300 chars to avoid bloat
        context_preview = nearby_text.strip()[:300]
        if len(nearby_text) > 300:
            context_preview += "..."
        parts.append(f"\n[CONTEXT]\n{context_preview}")
    
    return "\n".join(parts)

def extract_text_near_image(doc: fitz.Document, page_num: int) -> str:
    """
    Extract text from the page for context.
    This helps capture figure captions and references.
    """
    try:
        page = doc[page_num]
        text = page.get_text()
        return text
    except Exception as e:
        print(f"Warning: Could not extract text from page {page_num}: {e}")
        return ""

# --- DATABASE FUNCTIONS ---

def fetch_pending_chapters() -> List[Dict]:
    """Fetches NCERT chapters to embed."""
    try:
        response = supabase.table('chapters').select('id, metadata, book_id').eq('embedding_status', 'not_started').limit(1).execute()
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

def wait_for_rate_limit():
    """Checks and enforces the 15 req/min rate limit."""
    global REQUEST_TIMESTAMPS
    now = time.time()
    
    while REQUEST_TIMESTAMPS and REQUEST_TIMESTAMPS[0] <= now - RATE_LIMIT_WINDOW:
        REQUEST_TIMESTAMPS.popleft()
        
    if len(REQUEST_TIMESTAMPS) >= MAX_REQUESTS_PER_MINUTE:
        oldest_request_time = REQUEST_TIMESTAMPS[0]
        time_to_wait = (oldest_request_time + RATE_LIMIT_WINDOW) - now
        
        if time_to_wait > 0:
            print(f"RATE LIMITER: Sleeping for {time_to_wait:.2f}s")
            time.sleep(time_to_wait)
        
        REQUEST_TIMESTAMPS.popleft()
    
    REQUEST_TIMESTAMPS.append(time.time())

# --- MAIN WORKER ---

def main_worker_loop():
    """The main loop that processes content."""
    
    try:
        print("Initializing services...")
        init_bge_service()
        init_vlm_service()
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
                metadata = chapter.get('metadata', {})
                
                update_db_status('chapters', item_id, 'processing')
                
                try:
                    pdf_path = metadata.get('supabase_storage_path')
                    if not pdf_path:
                        print(f"Skipping chapter {item_id}: no path found.")
                        update_db_status('chapters', item_id, 'error')
                        continue
                        
                    pdf_url = f"{SUPABASE_URL}/storage/v1/object/public/{quote(PDF_BUCKET_NAME)}/{quote(pdf_path)}"
                    
                    print(f"Downloading {pdf_url}...")
                    response = requests.get(pdf_url, stream=True)
                    response.raise_for_status() 
                    pdf_bytes = response.content

                    embeddings_to_insert = []

                    # --- TEXT PIPELINE ---
                    print("Running text pipeline...")
                    doc = fitz.open(stream=pdf_bytes, filetype="pdf")
                    markdown_result = pymupdf4llm.to_markdown(
                        doc, write_images=False, page_chunks=True, 
                        table_strategy='lines_strict'
                    )
                    
                    if isinstance(markdown_result, str):
                        page_texts = markdown_result.split('\n\n---\n\n')
                        if len(page_texts) == 1: 
                            page_texts = [markdown_result]
                    else:
                        page_texts = markdown_result if isinstance(markdown_result, list) else [str(markdown_result)]
                    
                    text_splitter = RecursiveCharacterTextSplitter(
                        chunk_size=1000, chunk_overlap=100, length_function=len
                    )
                    
                    text_chunks_data = []
                    for page_num, page_markdown in enumerate(page_texts, start=1):
                        if not page_markdown or not str(page_markdown).strip(): 
                            continue
                        page_chunks = text_splitter.split_text(str(page_markdown))
                        for chunk_text in page_chunks:
                            if chunk_text.strip():
                                text_chunks_data.append({
                                    'text': chunk_text, 
                                    'page': page_num
                                })
                    doc.close()
                    
                    if text_chunks_data:
                        chunk_list = [chunk['text'] for chunk in text_chunks_data]
                        vectors = get_embeddings(chunk_list)
                        for i, chunk_data in enumerate(text_chunks_data):
                            embeddings_to_insert.append({
                                'chapter_id': item_id,
                                'book_id': book_id,
                                'content': chunk_data['text'],
                                'page_number': chunk_data['page'],
                                'content_type': 'text',
                                'embedding': vectors[i],
                                'storage_path': None
                            })
                    print(f"Text pipeline: {len(embeddings_to_insert)} text vectors")

                    # --- IMAGE PIPELINE WITH METADATA ENRICHMENT ---
                    print("Running image pipeline with metadata extraction...")
                    
                    doc = fitz.open(stream=pdf_bytes, filetype="pdf")
                    uploaded_images_info = []
                    
                    for page_num in range(len(doc)):
                        page = doc[page_num]
                        image_list = page.get_images()
                        
                        # Extract page text for context
                        page_text = extract_text_near_image(doc, page_num)
                        
                        for img_index, img in enumerate(image_list):
                            xref = img[0]
                            try:
                                base_image = doc.extract_image(xref)
                                image_bytes = base_image["image"]
                                
                                # IMAGE FILTERING
                                image_pil = Image.open(BytesIO(image_bytes))
                                width, height = image_pil.size
                                
                                if width < 100 or height < 100:
                                    continue
                                
                                if len(image_bytes) < 5000:
                                    continue
                                
                                grayscale = image_pil.convert('L')
                                img_array = np.array(grayscale)
                                variance = np.var(img_array)
                                
                                if variance < 100:
                                    continue
                                
                                # Upload image
                                image_name = f"{item_id}_page_{page_num+1}_img_{img_index}.png"
                                upload_path = f"class-10/{book_id}/{image_name}"
                                print(f"Uploading {image_name}...")
                                supabase.storage.from_(IMAGE_BUCKET_NAME).upload(
                                    path=upload_path,
                                    file=image_bytes,
                                    file_options={"content-type": "image/png", "upsert": "true"}
                                )
                                
                                # Store with context for enrichment
                                uploaded_images_info.append({
                                    'page_number': page_num + 1,
                                    'image_index': img_index,
                                    'image_bytes': image_bytes,
                                    'storage_path': upload_path,
                                    'nearby_text': page_text
                                })
                            except Exception as e:
                                print(f"Warning: Image error: {e}")
                                continue
                    doc.close()
                    
                    # Batch images
                    image_batches = [
                        uploaded_images_info[i:i + GEMINI_BATCH_SIZE]
                        for i in range(0, len(uploaded_images_info), GEMINI_BATCH_SIZE)
                    ]
                    
                    print(f"Filtered {len(uploaded_images_info)} images → {len(image_batches)} batches")
                    
                    all_valid_captions = []
                    
                    # Process each batch
                    for batch_idx, batch in enumerate(image_batches):
                        wait_for_rate_limit()
                        
                        image_bytes_batch = [img['image_bytes'] for img in batch]
                        storage_path_batch = [img['storage_path'] for img in batch]
                        
                        print(f"Processing batch {batch_idx+1}/{len(image_batches)}...")
                        analysis_results = get_descriptions_for_batch(
                            image_bytes_batch, 
                            storage_path_batch
                        )
                        
                        batch_info_map = {img['storage_path']: img for img in batch}
                        
                        for result in analysis_results:
                            caption = result.get('analysis', 'IGNORE')
                            image_id = result.get('image_id')
                            
                            if image_id and caption.upper() != 'IGNORE':
                                original_info = batch_info_map.get(image_id)
                                if original_info:
                                    # CREATE ENRICHED CONTENT WITH METADATA
                                    enriched_content = create_searchable_image_content(
                                        gemini_description=caption,
                                        page_number=original_info['page_number'],
                                        image_index=original_info['image_index'],
                                        nearby_text=original_info['nearby_text']
                                    )
                                    
                                    all_valid_captions.append({
                                        'caption': enriched_content,
                                        'page_number': original_info['page_number'],
                                        'storage_path': image_id
                                    })
                                    print(f"  ✓ Enriched: Page {original_info['page_number']}, Img {original_info['image_index']}")
                                else:
                                    print(f"  ⚠ Unknown image_id: {image_id}")
                            elif image_id:
                                print(f"  ✓ Ignored (text/QR/logo)")

                    # Embed enriched captions
                    if all_valid_captions:
                        captions_list = [c['caption'] for c in all_valid_captions]
                        print(f"Embedding {len(captions_list)} enriched descriptions...")
                        image_vectors = get_embeddings(captions_list)
                        
                        for i, caption_data in enumerate(all_valid_captions):
                            embeddings_to_insert.append({
                                'chapter_id': item_id,
                                'book_id': book_id,
                                'content': caption_data['caption'],
                                'page_number': caption_data['page_number'],
                                'content_type': 'image_description',
                                'embedding': image_vectors[i],
                                'storage_path': caption_data['storage_path']
                            })
                    print(f"Image pipeline: {len(all_valid_captions)} enriched vectors")

                    # BATCH INSERT
                    if embeddings_to_insert:
                        print(f"Inserting {len(embeddings_to_insert)} total vectors...")
                        supabase.table('chapter_embeddings').insert(embeddings_to_insert).execute()
                        update_db_status('chapters', item_id, 'completed')
                        print(f"✅ Chapter {item_id} completed!")
                    else:
                        print(f"No content found for chapter {item_id}")
                        update_db_status('chapters', item_id, 'error')
                
                except Exception as e:
                    print(f"Fatal error processing chapter {item_id}: {e}")
                    import traceback
                    traceback.print_exc()
                    update_db_status('chapters', item_id, 'error')

        except Exception as e:
            print(f"Worker Loop Error: {e}")
            import traceback
            traceback.print_exc()
        
        print(f"Cycle complete. Sleeping {PROCESSING_LOOP_DELAY}s.\n{'='*60}\n")
        time.sleep(PROCESSING_LOOP_DELAY)

if __name__ == '__main__':
    main_worker_loop()