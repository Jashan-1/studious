
# import os
# import time
# import uuid
# import requests
# import sys
# import re
# from io import BytesIO
# from typing import List, Dict, Any
# from supabase import create_client, Client
# import pymupdf4llm
# import pymupdf as fitz
# from langchain_text_splitters import RecursiveCharacterTextSplitter
# from urllib.parse import quote
# from collections import deque
# import numpy as np
# from PIL import Image

# # Add backend directory to path
# backend_dir = os.path.dirname(os.path.abspath(__file__))
# if backend_dir not in sys.path:
#     sys.path.insert(0, backend_dir)

# # Import services
# from app.services.grading_service_utils.embedding_service import (
#     initialize_embedding_service as init_bge_service,
#     get_embeddings
# )
# from app.services.multimodal_service import (
#     initialize_multimodal_service as init_vlm_service,
#     get_descriptions_for_batch
# )

# # --- CONFIGURATION ---
# PROCESSING_LOOP_DELAY = 10
# SUPABASE_URL = os.environ.get("SUPABASE_URL")
# SUPABASE_KEY = os.environ.get("SUPABASE_SERVICE_KEY")
# supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

# PDF_BUCKET_NAME = "NCERT Books"
# IMAGE_BUCKET_NAME = "NCERT Images" 

# REQUEST_TIMESTAMPS = deque()
# MAX_REQUESTS_PER_MINUTE = 15
# RATE_LIMIT_WINDOW = 60
# GEMINI_BATCH_SIZE = 16

# # --- HELPER FUNCTIONS FOR METADATA ENRICHMENT ---

# # def extract_figure_references_from_text(text: str, page_num: int) -> List[str]:
# #     """
# #     Extract figure/activity/table references from surrounding text.
# #     Returns list like ["Figure 7.1", "Activity 7.2"]
# #     """
# #     patterns = [
# #         r'(Figure|Fig\.|फिगर)\s*(\d+)\.(\d+)',
# #         r'(Activity|गतिविधि)\s*(\d+)\.(\d+)',
# #         r'(Table|तालिका)\s*(\d+)\.(\d+)',
# #         r'(Diagram|आरेख)\s*(\d+)\.(\d+)',
# #         r'(Example|उदाहरण)\s*(\d+)\.(\d+)'
# #     ]
    
# #     references = []
# #     for pattern in patterns:
# #         matches = re.finditer(pattern, text, re.IGNORECASE)
# #         for match in matches:
# #             ref_type = match.group(1)
# #             chapter_num = match.group(2)
# #             fig_num = match.group(3)
# #             references.append(f"{ref_type} {chapter_num}.{fig_num}")
    
# #     return references

# # def create_searchable_image_content(
# #     gemini_description: str,
# #     page_number: int,
# #     image_index: int,
# #     nearby_text: str = ""
# # ) -> str:
# #     """
# #     Creates a metadata-rich description that's searchable in multiple ways.
    
# #     Format:
# #     [METADATA: Page X, Image Y]
# #     [REFERENCES: Figure A.B, Activity C.D]
    
# #     [DESCRIPTION]
# #     Gemini's detailed description here...
    
# #     [CONTEXT]
# #     Nearby text from the page...
# #     """
    
# #     # Extract any figure references from nearby text
# #     references = extract_figure_references_from_text(nearby_text, page_number)
    
# #     # Build the enriched content
# #     parts = []
    
# #     # 1. Metadata header (always searchable)
# #     parts.append(f"[METADATA: Page {page_number}, Image {image_index}]")
    
# #     # 2. References (if found)
# #     if references:
# #         refs_str = ", ".join(set(references))  # Remove duplicates
# #         parts.append(f"[REFERENCES: {refs_str}]")
    
# #     # 3. Main description from Gemini
# #     parts.append(f"\n[DESCRIPTION]\n{gemini_description}")
    
# #     # 4. Context from nearby text (if available)
# #     if nearby_text.strip():
# #         # Limit context to 300 chars to avoid bloat
# #         context_preview = nearby_text.strip()[:300]
# #         if len(nearby_text) > 300:
# #             context_preview += "..."
# #         parts.append(f"\n[CONTEXT]\n{context_preview}")
    
# #     return "\n".join(parts)







# def extract_text_near_image(doc: fitz.Document, page_num: int) -> str:
#     """
#     Extract text from the page for context.
#     This helps capture figure captions and references.
#     """
#     try:
#         page = doc[page_num]
#         text = page.get_text()
#         return text
#     except Exception as e:
#         print(f"Warning: Could not extract text from page {page_num}: {e}")
#         return ""

# # --- DATABASE FUNCTIONS ---

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

# def wait_for_rate_limit():
#     """Checks and enforces the 15 req/min rate limit."""
#     global REQUEST_TIMESTAMPS
#     now = time.time()
    
#     while REQUEST_TIMESTAMPS and REQUEST_TIMESTAMPS[0] <= now - RATE_LIMIT_WINDOW:
#         REQUEST_TIMESTAMPS.popleft()
        
#     if len(REQUEST_TIMESTAMPS) >= MAX_REQUESTS_PER_MINUTE:
#         oldest_request_time = REQUEST_TIMESTAMPS[0]
#         time_to_wait = (oldest_request_time + RATE_LIMIT_WINDOW) - now
        
#         if time_to_wait > 0:
#             print(f"RATE LIMITER: Sleeping for {time_to_wait:.2f}s")
#             time.sleep(time_to_wait)
        
#         REQUEST_TIMESTAMPS.popleft()
    
#     REQUEST_TIMESTAMPS.append(time.time())

# # --- MAIN WORKER ---

# def main_worker_loop():
#     """The main loop that processes content."""
    
#     try:
#         print("Initializing services...")
#         init_bge_service()
#         init_vlm_service()
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
#                         print(f"Skipping chapter {item_id}: no path found.")
#                         update_db_status('chapters', item_id, 'error')
#                         continue
                        
#                     pdf_url = f"{SUPABASE_URL}/storage/v1/object/public/{quote(PDF_BUCKET_NAME)}/{quote(pdf_path)}"
                    
#                     print(f"Downloading {pdf_url}...")
#                     response = requests.get(pdf_url, stream=True)
#                     response.raise_for_status() 
#                     pdf_bytes = response.content

#                     embeddings_to_insert = []

#                     # --- TEXT PIPELINE ---
#                     print("Running text pipeline...")
#                     doc = fitz.open(stream=pdf_bytes, filetype="pdf")
#                     markdown_result = pymupdf4llm.to_markdown(
#                         doc, write_images=False, page_chunks=True, 
#                         table_strategy='lines_strict'
#                     )
                    
#                     if isinstance(markdown_result, str):
#                         page_texts = markdown_result.split('\n\n---\n\n')
#                         if len(page_texts) == 1: 
#                             page_texts = [markdown_result]
#                     else:
#                         page_texts = markdown_result if isinstance(markdown_result, list) else [str(markdown_result)]
                    
#                     text_splitter = RecursiveCharacterTextSplitter(
#                         chunk_size=1000, chunk_overlap=100, length_function=len
#                     )
                    
#                     text_chunks_data = []
#                     for page_num, page_markdown in enumerate(page_texts, start=1):
#                         if not page_markdown or not str(page_markdown).strip(): 
#                             continue
#                         page_chunks = text_splitter.split_text(str(page_markdown))
#                         for chunk_text in page_chunks:
#                             if chunk_text.strip():
#                                 text_chunks_data.append({
#                                     'text': chunk_text, 
#                                     'page': page_num
#                                 })
#                     doc.close()
                    
#                     if text_chunks_data:
#                         chunk_list = [chunk['text'] for chunk in text_chunks_data]
#                         vectors = get_embeddings(chunk_list)
#                         for i, chunk_data in enumerate(text_chunks_data):
#                             embeddings_to_insert.append({
#                                 'chapter_id': item_id,
#                                 'book_id': book_id,
#                                 'content': chunk_data['text'],
#                                 'page_number': chunk_data['page'],
#                                 'content_type': 'text',
#                                 'embedding': vectors[i],
#                                 'storage_path': None
#                             })
#                     print(f"Text pipeline: {len(embeddings_to_insert)} text vectors")

#                     # --- IMAGE PIPELINE WITH METADATA ENRICHMENT ---
#                     print("Running image pipeline with metadata extraction...")
                    
#                     doc = fitz.open(stream=pdf_bytes, filetype="pdf")
#                     uploaded_images_info = []
                    
#                     for page_num in range(len(doc)):
#                         page = doc[page_num]
#                         image_list = page.get_images()
                        
#                         # Extract page text for context
#                         page_text = extract_text_near_image(doc, page_num)
                        
#                         for img_index, img in enumerate(image_list):
#                             xref = img[0]
#                             try:
#                                 base_image = doc.extract_image(xref)
#                                 image_bytes = base_image["image"]
                                
#                                 # IMAGE FILTERING
#                                 image_pil = Image.open(BytesIO(image_bytes))
#                                 width, height = image_pil.size
                                
#                                 if width < 100 or height < 100:
#                                     continue
                                
#                                 if len(image_bytes) < 5000:
#                                     continue
                                
#                                 grayscale = image_pil.convert('L')
#                                 img_array = np.array(grayscale)
#                                 variance = np.var(img_array)
                                
#                                 if variance < 100:
#                                     continue
                                
#                                 # Upload image
#                                 image_name = f"{item_id}_page_{page_num+1}_img_{img_index}.png"
#                                 upload_path = f"class-10/{book_id}/{image_name}"
#                                 print(f"Uploading {image_name}...")
#                                 supabase.storage.from_(IMAGE_BUCKET_NAME).upload(
#                                     path=upload_path,
#                                     file=image_bytes,
#                                     file_options={"content-type": "image/png", "upsert": "true"}
#                                 )
                                
#                                 # Store with context for enrichment
#                                 uploaded_images_info.append({
#                                     'page_number': page_num + 1,
#                                     'image_index': img_index,
#                                     'image_bytes': image_bytes,
#                                     'storage_path': upload_path,
#                                     'nearby_text': page_text
#                                 })
#                             except Exception as e:
#                                 print(f"Warning: Image error: {e}")
#                                 continue
#                     doc.close()
                    
#                     # Batch images
#                     image_batches = [
#                         uploaded_images_info[i:i + GEMINI_BATCH_SIZE]
#                         for i in range(0, len(uploaded_images_info), GEMINI_BATCH_SIZE)
#                     ]
                    
#                     print(f"Filtered {len(uploaded_images_info)} images → {len(image_batches)} batches")
                    
#                     all_valid_captions = []
                    
#                     # Process each batch
#                     for batch_idx, batch in enumerate(image_batches):
#                         wait_for_rate_limit()
                        
#                         image_bytes_batch = [img['image_bytes'] for img in batch]
#                         storage_path_batch = [img['storage_path'] for img in batch]
                        
#                         print(f"Processing batch {batch_idx+1}/{len(image_batches)}...")
#                         analysis_results = get_descriptions_for_batch(
#                             image_bytes_batch, 
#                             storage_path_batch
#                         )
                        
#                         batch_info_map = {img['storage_path']: img for img in batch}
                        
#                         for result in analysis_results:
#                             caption = result.get('analysis', 'IGNORE')
#                             image_id = result.get('image_id')
                            
#                             if image_id and caption.upper() != 'IGNORE':
#                                 original_info = batch_info_map.get(image_id)
#                                 if original_info:
#                                     # CREATE ENRICHED CONTENT WITH METADATA
#                                     enriched_content = create_searchable_image_content(
#                                         gemini_description=caption,
#                                         page_number=original_info['page_number'],
#                                         image_index=original_info['image_index'],
#                                         nearby_text=original_info['nearby_text']
#                                     )
                                    
#                                     all_valid_captions.append({
#                                         'caption': enriched_content,
#                                         'page_number': original_info['page_number'],
#                                         'storage_path': image_id
#                                     })
#                                     print(f"  ✓ Enriched: Page {original_info['page_number']}, Img {original_info['image_index']}")
#                                 else:
#                                     print(f"  ⚠ Unknown image_id: {image_id}")
#                             elif image_id:
#                                 print(f"  ✓ Ignored (text/QR/logo)")

#                     # Embed enriched captions
#                     if all_valid_captions:
#                         captions_list = [c['caption'] for c in all_valid_captions]
#                         print(f"Embedding {len(captions_list)} enriched descriptions...")
#                         image_vectors = get_embeddings(captions_list)
                        
#                         for i, caption_data in enumerate(all_valid_captions):
#                             embeddings_to_insert.append({
#                                 'chapter_id': item_id,
#                                 'book_id': book_id,
#                                 'content': caption_data['caption'],
#                                 'page_number': caption_data['page_number'],
#                                 'content_type': 'image_description',
#                                 'embedding': image_vectors[i],
#                                 'storage_path': caption_data['storage_path']
#                             })
#                     print(f"Image pipeline: {len(all_valid_captions)} enriched vectors")

#                     # BATCH INSERT
#                     if embeddings_to_insert:
#                         print(f"Inserting {len(embeddings_to_insert)} total vectors...")
#                         supabase.table('chapter_embeddings').insert(embeddings_to_insert).execute()
#                         update_db_status('chapters', item_id, 'completed')
#                         print(f"✅ Chapter {item_id} completed!")
#                     else:
#                         print(f"No content found for chapter {item_id}")
#                         update_db_status('chapters', item_id, 'error')
                
#                 except Exception as e:
#                     print(f"Fatal error processing chapter {item_id}: {e}")
#                     import traceback
#                     traceback.print_exc()
#                     update_db_status('chapters', item_id, 'error')

#         except Exception as e:
#             print(f"Worker Loop Error: {e}")
#             import traceback
#             traceback.print_exc()
        
#         print(f"Cycle complete. Sleeping {PROCESSING_LOOP_DELAY}s.\n{'='*60}\n")
#         time.sleep(PROCESSING_LOOP_DELAY)

# if __name__ == '__main__':
#     main_worker_loop()






# import os
# import time
# import uuid
# import requests
# import sys
# import re
# from io import BytesIO
# from typing import List, Dict, Any, Tuple
# from supabase import create_client, Client
# import pymupdf as fitz
# import pymupdf4llm  # <-- Import the markdown converter
# from langchain_text_splitters import RecursiveCharacterTextSplitter
# from urllib.parse import quote
# from collections import deque
# import numpy as np
# from PIL import Image

# # Import services
# backend_dir = os.path.dirname(os.path.abspath(__file__))
# if backend_dir not in sys.path:
#     sys.path.insert(0, backend_dir)

# from app.services.grading_service_utils.embedding_service import (
#     initialize_embedding_service as init_bge_service,
#     get_embeddings
# )
# from app.services.multimodal_service import (
#     initialize_multimodal_service as init_vlm_service,
#     get_descriptions_for_batch
# )

# # Configuration
# PROCESSING_LOOP_DELAY = 10
# SUPABASE_URL = os.environ.get("SUPABASE_URL")
# SUPABASE_KEY = os.environ.get("SUPABASE_SERVICE_KEY")
# supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

# PDF_BUCKET_NAME = "NCERT Books"
# IMAGE_BUCKET_NAME = "NCERT Images"

# REQUEST_TIMESTAMPS = deque()
# MAX_REQUESTS_PER_MINUTE = 15
# RATE_LIMIT_WINDOW = 60
# GEMINI_BATCH_SIZE = 16

# # --- ALL HELPER FUNCTIONS (UNCHANGED) ---

# # Add this function to your worker.py (after the imports section)

# def detect_section_headers(text: str) -> List[Dict]:
#     """Detect section headers in markdown text."""
#     headers = []
    
#     # Markdown headers
#     markdown_pattern = r'^(#{1,6})\s+(.+)$'
#     for match in re.finditer(markdown_pattern, text, re.MULTILINE):
#         level = len(match.group(1))
#         header_text = match.group(2).strip()
#         headers.append({
#             'text': header_text,
#             'position': match.start(),
#             'level': level,
#             'type': 'markdown'
#         })
    
#     # Common NCERT section patterns
#     section_patterns = [
#         r'(?i)^(What you have learnt?)\s*$',
#         r'(?i)^(E\s*X\s*E\s*R\s*C\s*I\s*S\s*E\s*S?)\s*$',
#         r'(?i)^(Q\s*U\s*E\s*S\s*T\s*I\s*O\s*N\s*S?)\s*$',
#         r'(?i)^(Think it over)\s*$',
#         r'(?i)^(Do you know\??)\s*$',
#         r'(?i)^(Summary)\s*$',
#         r'(?i)^(Introduction)\s*$',
#         r'(?i)^(\d+\.\d+\s+[A-Z][a-zA-Z\s]+)$',  # "8.2.1 Inherited Traits"
#     ]
    
#     for pattern in section_patterns:
#         for match in re.finditer(pattern, text, re.MULTILINE):
#             header_text = match.group(1).strip()
#             header_text = re.sub(r'\s+', ' ', header_text)  # Normalize spacing
#             headers.append({
#                 'text': header_text,
#                 'position': match.start(),
#                 'level': 2,
#                 'type': 'section'
#             })
    
#     headers.sort(key=lambda x: x['position'])
#     return headers


# def create_section_aware_chunks(text: str, page_num: int, chunk_size: int = 1000, overlap: int = 100) -> List[Dict]:
#     """Split text into chunks while preserving section context."""
    
#     headers = detect_section_headers(text)
    
#     if not headers:
#         # No headers, use standard chunking
#         splitter = RecursiveCharacterTextSplitter(chunk_size=chunk_size, chunk_overlap=overlap)
#         chunks = splitter.split_text(text)
#         return [{'content': chunk, 'page': page_num, 'section': None} for chunk in chunks if chunk.strip()]
    
#     # Create sections
#     sections = []
#     for i, header in enumerate(headers):
#         start_pos = header['position']
#         end_pos = headers[i + 1]['position'] if i + 1 < len(headers) else len(text)
#         section_content = text[start_pos:end_pos].strip()
#         sections.append({
#             'header': header['text'],
#             'content': section_content,
#             'level': header['level']
#         })
    
#     # Chunk each section
#     splitter = RecursiveCharacterTextSplitter(chunk_size=chunk_size, chunk_overlap=overlap)
#     enriched_chunks = []
    
#     for section in sections:
#         section_header = section['header']
#         section_content = section['content']
#         content_chunks = splitter.split_text(section_content)
        
#         for chunk_text in content_chunks:
#             if not chunk_text.strip():
#                 continue
            
#             # CRITICAL: Add section header as metadata
#             enriched_content = f"[SECTION: {section_header}]\n\n{chunk_text}"
            
#             enriched_chunks.append({
#                 'content': enriched_content,
#                 'page': page_num,
#                 'section': section_header
#             })
    
#     return enriched_chunks


# def extract_figure_references_from_text(text: str) -> List[str]:
#     """Extracts ALL figure/activity/table references from a block of text."""
#     patterns = [
#         r'(Figure|Fig\.|फिगर)\s*(\d+)\.(\d+)',
#         r'(Activity|गतिविधि)\s*(\d+)\.(\d+)',
#         r'(Table|तालिका)\s*(\d+)\.(\d+)',
#         r'(Diagram|आरेख)\s*(\d+)\.(\d+)',
#         r'(Example|उदाहरण)\s*(\d+)\.(\d+)'
#     ]
#     references = []
#     for pattern in patterns:
#         matches = re.finditer(pattern, text, re.IGNORECASE | re.UNICODE)
#         for match in matches:
#             ref_type = match.group(1).capitalize()
#             type_mapping = {
#                 'फिगर': 'Figure', 'गतिविधि': 'Activity', 'तालिका': 'Table',
#                 'आरेख': 'Diagram', 'उदाहरण': 'Example', 'Fig.': 'Figure'
#             }
#             ref_type = type_mapping.get(ref_type, ref_type)
#             references.append(f"{ref_type} {match.group(2)}.{match.group(3)}")
#     return list(set(references))

# def extract_page_with_layout(doc: fitz.Document, page: fitz.Page, page_num: int) -> Dict:
#     """Extracts layout-aware content (images and text blocks)."""
#     text_blocks = page.get_text("dict")["blocks"]
#     full_page_text = page.get_text()
#     image_list = page.get_images(full=True)
#     images_with_context = []
#     for img_index, img in enumerate(image_list):
#         xref = img[0]
#         try:
#             img_rects = page.get_image_rects(xref)
#             if not img_rects: continue
#             img_bbox = img_rects[0]
#             base_image = doc.extract_image(xref)
#             image_bytes = base_image["image"]
#             nearby_text = extract_text_near_bbox(text_blocks, img_bbox, proximity=50)
#             box_context = detect_special_box(text_blocks, img_bbox)
#             images_with_context.append({
#                 'index': img_index, 'bytes': image_bytes, 'bbox': img_bbox,
#                 'nearby_text': nearby_text,
#                 'box_type': box_context['type'] if box_context else None,
#                 'box_title': box_context['title'] if box_context else None,
#                 'box_content': box_context['content'] if box_context else None
#             })
#         except Exception as e:
#             print(f"Error extracting image {img_index}: {e}")
#             continue
#     return {
#         'page_number': page_num, 'text_blocks': text_blocks,
#         'images': images_with_context, 'full_text': full_page_text
#     }

# def extract_text_near_bbox(text_blocks: List[Dict], img_bbox: fitz.Rect, proximity: int = 50) -> str:
#     """Extracts text spatially near an image's bounding box."""
#     nearby_texts = []
#     for block in text_blocks:
#         if block['type'] != 0: continue
#         block_bbox = fitz.Rect(block['bbox'])
#         vertical_overlap = not (block_bbox.y1 < img_bbox.y0 - proximity or block_bbox.y0 > img_bbox.y1 + proximity)
#         horizontal_overlap = not (block_bbox.x1 < img_bbox.x0 - proximity or block_bbox.x0 > img_bbox.x1 + proximity)
#         if vertical_overlap or horizontal_overlap:
#             for line in block.get('lines', []):
#                 for span in line.get('spans', []):
#                     text = span.get('text', '').strip()
#                     if text: nearby_texts.append(text)
#     return ' '.join(nearby_texts)

# def detect_special_box(text_blocks: List[Dict], img_bbox: fitz.Rect) -> Dict:
#     """Detects if an image is inside a special colored box."""
#     box_title, box_type = None, None
#     box_content = []
#     for block in text_blocks:
#         if block['type'] != 0: continue
#         block_bbox = fitz.Rect(block['bbox'])
#         if (abs(block_bbox.x0 - img_bbox.x0) < 20 or abs(block_bbox.y0 - img_bbox.y0) < 100):
#             for line in block.get('lines', []):
#                 line_text = ' '.join([span.get('text', '') for span in line.get('spans', [])]).strip()
#                 if not line_text: continue
#                 if re.search(r'Activity\s+\d+\.\d+', line_text, re.IGNORECASE):
#                     box_type, box_title = 'Activity', line_text
#                 elif re.search(r'(Biography|Profile):', line_text, re.IGNORECASE):
#                     box_type = 'Biography'
#                 elif re.search(r'\d{4}[-–]\d{4}', line_text):
#                     if not box_title: box_title = line_text
#                     box_type = 'Biography'
#                 elif re.search(r'Q\s*U\s*E\s*S\s*T\s*I\s*O\s*N\s*S?', line_text, re.IGNORECASE):
#                     box_type, box_title = 'Questions', 'QUESTIONS'
#                 elif re.search(r'^Questions?\s*$', line_text, re.IGNORECASE):
#                     box_type, box_title = 'Questions', 'Questions'
#                 elif re.search(r'^\d+\.\s+', line_text):
#                     if not box_type: box_type, box_title = 'Questions', 'Questions'
#                 box_content.append(line_text)
#     if box_type:
#         return {'type': box_type, 'title': box_title, 'content': ' '.join(box_content)}
#     return None

# def extract_special_text_boxes(text_blocks: List[Dict], page_num: int) -> List[Dict]:
#     """Finds text-only special boxes (like 'Questions') that are not image-based."""
#     special_chunks = []
#     title_patterns = {
#         'Questions': re.compile(r'Q\s*U\s*E\s*S\s*T\s*I\s*O\s*N\s*S?|^\s*Questions\s*$', re.IGNORECASE),
#         'Activity': re.compile(r'^Activity\s+\d+\.\d+', re.IGNORECASE),
#         'Think it over': re.compile(r'Think\s+it\s+over', re.IGNORECASE),
#         'Do you know?': re.compile(r'Do\s+you\s+know\?', re.IGNORECASE),
#         'Exercises': re.compile(r'E\s*X\s*E\s*R\s*C\s*I\s*S\s*E\s*S|^\s*Exercises\s*$', re.IGNORECASE),
#     }
#     i = 0
#     while i < len(text_blocks):
#         block = text_blocks[i]
#         if block['type'] != 0: i += 1; continue
#         block_text = " ".join(
#             span['text'] for line in block.get('lines', []) for span in line.get('spans', [])
#         ).strip()
#         box_type = None
#         for b_type, pattern in title_patterns.items():
#             if pattern.search(block_text):
#                 box_type = b_type; break
#         if box_type:
#             box_content_lines = [block_text]
#             j = i + 1
#             while j < len(text_blocks):
#                 content_block = text_blocks[j]
#                 if content_block['type'] != 0: j += 1; continue
#                 content_text = " ".join(
#                     span['text'] for line in content_block.get('lines', []) for span in line.get('spans', [])
#                 ).strip()
#                 is_new_title = False
#                 for pattern in title_patterns.values():
#                     if pattern.search(content_text): is_new_title = True; break
#                 if is_new_title: break
#                 if content_text: box_content_lines.append(content_text)
#                 j += 1
#             full_box_content = "\n".join(box_content_lines)
#             enriched_content = (
#                 f"[METADATA: Page {page_num}]\n"
#                 f"[BOX_TYPE: {box_type}]\n"
#                 f"[CONTENT]\n{full_box_content}"
#             )
#             special_chunks.append({
#                 'type': 'text_box', 'content': enriched_content, 'page': page_num
#             })
#             i = j
#         else:
#             i += 1
#     return special_chunks

# def create_enriched_image_content(image_info: Dict, gemini_description: str, page_number: int) -> str:
#     """Creates the ultra-enriched metadata chunk for an image."""
#     parts = [f"[METADATA: Page {page_number}, Image {image_info['index']}]"]
#     all_page_references = extract_figure_references_from_text(image_info.get('full_page_text', ''))
#     if all_page_references:
#         parts.append(f"[REFERENCES: {', '.join(all_page_references)}]")
#         searchable_tags = []
#         for ref in all_page_references:
#             match = re.match(r'(\w+)\s*(\d+)\.(\d+)', ref, re.IGNORECASE)
#             if match:
#                 ref_type, chapter, fig = match.group(1).lower(), match.group(2), match.group(3)
#                 searchable_tags.extend([
#                     f"{ref_type} {chapter}.{fig}", f"{ref_type}{chapter}.{fig}", f"{chapter}.{fig}"
#                 ])
#                 if ref_type == 'figure':
#                     searchable_tags.extend([
#                         f"fig {chapter}.{fig}", f"fig.{chapter}.{fig}", f"fig{chapter}.{fig}"
#                     ])
#         if searchable_tags:
#             parts.append(f"[SEARCHABLE_TAGS: {', '.join(set(searchable_tags))}]")
    
#     if image_info.get('box_type'):
#         parts.append(f"[BOX_TYPE: {image_info['box_type']}]")
#         if image_info.get('box_title'):
#             parts.append(f"[BOX_TITLE: {image_info['box_title']}]")
#         parts.append(f"[VISUAL_POSITION: Colored information box]")
    
#     if image_info.get('nearby_text'):
#         parts.append(f"\n[NEARBY_TEXT]\n{image_info['nearby_text'][:500]}")
#     if image_info.get('box_content'):
#         parts.append(f"\n[BOX_CONTENT]\n{image_info['box_content'][:500]}")
    
#     parts.append(f"\n[IMAGE_DESCRIPTION]\n{gemini_description}")
    
#     tags = []
#     if image_info.get('box_title'):
#         name = re.sub(r'\(?\d{4}[-–]\d{4}\)?', '', image_info['box_title']).strip()
#         if name: tags.append(name.lower())
#     if image_info.get('box_type'):
#         tags.extend([f"{image_info['box_type'].lower()} box", "colored box"])
#     bbox = image_info.get('bbox')
#     if bbox:
#         tags.append("top of page" if bbox.y0 < 400 else "bottom of page")
#         tags.append("right side" if bbox.x0 > 400 else "left side")
#     tags.append(f"page {page_number}")
#     parts.append(f"\n[LOCATION_TAGS: {', '.join(set(tags))}]")
    
#     return "\n".join(parts)

# # --- DATABASE / RATE LIMIT (UNCHANGED) ---

# def fetch_pending_chapters() -> List[Dict]:
#     try:
#         response = supabase.table('chapters').select('id, metadata, book_id').eq('embedding_status', 'not_started').limit(1).execute()
#         return response.data
#     except Exception as e:
#         print(f"Error fetching chapters: {e}")
#         return []

# def update_db_status(table_name: str, item_id: uuid.UUID, status: str):
#     try:
#         supabase.table(table_name).update({'embedding_status': status}).eq('id', item_id).execute()
#         print(f"✅ Updated {table_name} {item_id} → {status}")
#     except Exception as e:
#         print(f"Error updating status: {e}")

# def wait_for_rate_limit():
#     global REQUEST_TIMESTAMPS
#     now = time.time()
#     while REQUEST_TIMESTAMPS and REQUEST_TIMESTAMPS[0] <= now - RATE_LIMIT_WINDOW:
#         REQUEST_TIMESTAMPS.popleft()
#     if len(REQUEST_TIMESTAMPS) >= MAX_REQUESTS_PER_MINUTE:
#         oldest = REQUEST_TIMESTAMPS[0]
#         sleep_time = (oldest + RATE_LIMIT_WINDOW) - now
#         if sleep_time > 0:
#             print(f"⏳ Rate limit: sleeping {sleep_time:.1f}s")
#             time.sleep(sleep_time)
#         REQUEST_TIMESTAMPS.popleft()
#     REQUEST_TIMESTAMPS.append(time.time())

# # --- NEW: MAIN WORKER LOOP ---

# def main_worker_loop():
#     """
#     Main worker loop with a NEW DUAL-PIPELINE approach.
#     1. Runs a Markdown pipeline for high-quality text extraction.
#     2. Runs a Layout-Aware pipeline for images and special text-only boxes.
#     """
    
#     try:
#         print("🚀 Initializing services...")
#         init_bge_service()
#         init_vlm_service()
#         print("✅ All services ready (DUAL PIPELINE MODE)\n")
#     except Exception as e:
#         print(f"❌ Initialization failed: {e}")
#         return

#     while True:
#         try:
#             pending = fetch_pending_chapters()
            
#             for chapter in pending:
#                 item_id = chapter['id']
#                 book_id = chapter.get('book_id')
#                 metadata = chapter.get('metadata', {})
                
#                 update_db_status('chapters', item_id, 'processing')
                
#                 try:
#                     pdf_path = metadata.get('supabase_storage_path')
#                     if not pdf_path:
#                         print(f"⚠️ No PDF path for {item_id}")
#                         update_db_status('chapters', item_id, 'error')
#                         continue
                    
#                     pdf_url = f"{SUPABASE_URL}/storage/v1/object/public/{quote(PDF_BUCKET_NAME)}/{quote(pdf_path)}"
#                     print(f"📥 Downloading: {pdf_path}")
#                     response = requests.get(pdf_url, stream=True)
#                     response.raise_for_status()
#                     pdf_bytes = response.content
                    
#                     embeddings_to_insert = []
                    
#                     # --- PIPELINE 1: ADVANCED MARKDOWN TEXT EXTRACTION ---
#                     # This is better at reading text from complex layouts
#                     # like "Q U E S T I O N S" and "E X E R C I S E S"
                    
#                     print("🚀 Running Pipeline 1: Advanced Markdown (Text-First)...")
#                     doc = fitz.open(stream=pdf_bytes, filetype="pdf")
#                     markdown_result = pymupdf4llm.to_markdown(
#                         doc, 
#                         write_images=False, 
#                         page_chunks=True, 
#                         table_strategy='lines_strict'
#                     )
                    
#                     # --- THIS IS THE FIX ---
#                     # When page_chunks=True, pymupdf4llm may return a LIST of strings or dicts
#                     # Handle both cases properly
#                     if isinstance(markdown_result, list):
#                         # Convert list items to strings if they're dicts
#                         page_texts = []
#                         for item in markdown_result:
#                             if isinstance(item, str):
#                                 page_texts.append(item)
#                             elif isinstance(item, dict):
#                                 # Try common keys for markdown content
#                                 text = item.get('text') or item.get('content') or item.get('markdown') or str(item)
#                                 page_texts.append(text)
#                             else:
#                                 page_texts.append(str(item))
#                     elif isinstance(markdown_result, str):
#                         # Fallback just in case the API changes or page_chunks=False
#                         page_texts = markdown_result.split('\n\n---\n\n')
#                     else:
#                         # Ensure it's always a list for the loop below
#                         page_texts = [str(markdown_result)]
#                     # --- END FIX ---
#                     text_splitter = RecursiveCharacterTextSplitter(
#                         chunk_size=1000, 
#                         chunk_overlap=100
#                     )


#                     text_items = []
#                     for page_num, page_md in enumerate(page_texts, 1):
#                         if isinstance(page_md, dict):
#                             page_md = page_md.get('text') or page_md.get('content') or str(page_md)
#                         if not page_md or not str(page_md).strip():
#                             continue
                        
#                         # Use section-aware chunking instead of basic chunking
#                         section_chunks = create_section_aware_chunks(str(page_md), page_num)
#                         text_items.extend(section_chunks)

#                     # The rest of the pipeline remains the same
#                     if text_items:
#                         print(f"📝 Embedding {len(text_items)} section-aware text chunks...")
#                         text_contents = [item['content'] for item in text_items]
#                         text_vectors = get_embeddings(text_contents)
                        
#                         for i, item in enumerate(text_items):
#                             embeddings_to_insert.append({
#                                 'chapter_id': item_id,
#                                 'book_id': book_id,
#                                 'content': item['content'],  # Already includes [SECTION: ...] tag
#                                 'page_number': item['page'],
#                                 'content_type': 'text',
#                                 'embedding': text_vectors[i],
#                                 'storage_path': None
#                             })
                    
#                     # text_items = []
#                     # for page_num, page_md in enumerate(page_texts, 1):
#                     #     # Ensure page_md is a string
#                     #     if isinstance(page_md, dict):
#                     #         page_md = page_md.get('text') or page_md.get('content') or page_md.get('markdown') or str(page_md)
#                     #     if not page_md or not str(page_md).strip():
#                     #         continue
#                     #     chunks = text_splitter.split_text(str(page_md))
#                     #     for chunk_text in chunks:
#                     #         if chunk_text.strip():
#                     #             text_items.append({
#                     #                 'content': chunk_text,
#                     #                 'page': page_num
#                     #             })
                    
#                     # if text_items:
#                     #     print(f"📝 Embedding {len(text_items)} markdown text chunks...")
#                     #     text_contents = [item['content'] for item in text_items]
#                     #     text_vectors = get_embeddings(text_contents)
                        
#                     #     for i, item in enumerate(text_items):
#                     #         embeddings_to_insert.append({
#                     #             'chapter_id': item_id,
#                     #             'book_id': book_id,
#                     #             'content': item['content'],
#                     #             'page_number': item['page'],
#                     #             'content_type': 'text', # This is our base text
#                     #             'embedding': text_vectors[i],
#                     #             'storage_path': None
#                     #         })

#                     # --- PIPELINE 2: LAYOUT-AWARE (IMAGE + TEXT-BOX) ---
#                     # This pipeline now focuses on what it does best:
#                     # 1. Finding all images and enriching them.
#                     # 2. Finding text-only boxes (like "Activity") that
#                     #    the markdown converter might format poorly.
                    
#                     print("🚀 Running Pipeline 2: Layout-Aware (Image + Text-Box)...")
                    
#                     all_layout_items = []
#                     special_box_count = 0
                    
#                     for page_num in range(len(doc)):
#                         page = doc[page_num]
#                         page_data = extract_page_with_layout(doc, page, page_num + 1)
                        
#                         # Find text-only special boxes
#                         special_box_chunks = extract_special_text_boxes(page_data['text_blocks'], page_num + 1)
#                         for chunk in special_box_chunks:
#                             all_layout_items.append(chunk)
#                             special_box_count += 1
                        
#                         # Store images with their layout context
#                         for img_info in page_data['images']:
#                             try:
#                                 img_pil = Image.open(BytesIO(img_info['bytes']))
#                                 width, height = img_pil.size
#                                 if width < 100 or height < 100: continue
#                                 if len(img_info['bytes']) < 5000: continue
                                
#                                 grayscale = img_pil.convert('L')
#                                 variance = np.var(np.array(grayscale))
#                                 if variance < 100: continue
                                
#                                 image_name = f"{item_id}_page_{page_num+1}_img_{img_info['index']}.png"
#                                 upload_path = f"class-10/{book_id}/{image_name}"
                                
#                                 supabase.storage.from_(IMAGE_BUCKET_NAME).upload(
#                                     path=upload_path,
#                                     file=img_info['bytes'],
#                                     file_options={"content-type": "image/png", "upsert": "true"}
#                                 )
                                
#                                 img_info['storage_path'] = upload_path
#                                 img_info['page_number'] = page_num + 1
#                                 img_info['type'] = 'image'
#                                 img_info['full_page_text'] = page_data['full_text']
#                                 all_layout_items.append(img_info)
#                             except Exception as e:
#                                 print(f"⚠️ Image filter error: {e}")
                    
#                     doc.close()
                    
#                     # Separate layout items
#                     text_box_items = [item for item in all_layout_items if item['type'] == 'text_box']
#                     image_items = [item for item in all_layout_items if item['type'] == 'image']
                    
#                     # Embed text-box chunks
#                     if text_box_items:
#                         print(f"📝 Embedding {len(text_box_items)} special text-box chunks...")
#                         text_box_contents = [item['content'] for item in text_box_items]
#                         text_box_vectors = get_embeddings(text_box_contents)
                        
#                         for i, item in enumerate(text_box_items):
#                             embeddings_to_insert.append({
#                                 'chapter_id': item_id,
#                                 'book_id': book_id,
#                                 'content': item['content'],
#                                 'page_number': item['page'],
#                                 'content_type': 'text_box',
#                                 'embedding': text_box_vectors[i],
#                                 'storage_path': None
#                             })
                    
#                     # Process images in batches
#                     if image_items:
#                         print(f"🖼️ Processing {len(image_items)} images with hybrid context...")
#                         image_batches = [
#                             image_items[i:i + GEMINI_BATCH_SIZE]
#                             for i in range(0, len(image_items), GEMINI_BATCH_SIZE)
#                         ]
                        
#                         enriched_image_embeds = []
#                         for batch_idx, batch in enumerate(image_batches):
#                             wait_for_rate_limit()
#                             image_bytes_batch = [img['bytes'] for img in batch]
#                             storage_paths = [img['storage_path'] for img in batch]
                            
#                             print(f"  Batch {batch_idx + 1}/{len(image_batches)}...")
#                             analyses = get_descriptions_for_batch(image_bytes_batch, storage_paths)
                            
#                             for analysis in analyses:
#                                 if analysis.get('analysis', '').upper() == 'IGNORE': continue
#                                 matching_img = next((img for img in batch if img['storage_path'] == analysis.get('image_id')), None)
#                                 if not matching_img: continue
                                
#                                 enriched_content = create_enriched_image_content(
#                                     matching_img,
#                                     analysis['analysis'],
#                                     matching_img['page_number']
#                                 )
#                                 enriched_image_embeds.append({
#                                     'chapter_id': item_id, 'book_id': book_id,
#                                     'content': enriched_content,
#                                     'page_number': matching_img['page_number'],
#                                     'content_type': 'image_description',
#                                     'embedding': None, # Will bulk embed next
#                                     'storage_path': matching_img['storage_path']
#                                 })
                        
#                         # Bulk embed all image descriptions
#                         if enriched_image_embeds:
#                             print(f"🔢 Embedding {len(enriched_image_embeds)} enriched image descriptions...")
#                             image_contents = [e['content'] for e in enriched_image_embeds]
#                             image_vectors = get_embeddings(image_contents)
#                             for i, embed in enumerate(enriched_image_embeds):
#                                 embed['embedding'] = image_vectors[i]
#                             embeddings_to_insert.extend(enriched_image_embeds)
                    
#                     # --- END OF PIPELINES ---
                    
#                     if embeddings_to_insert:
#                         # De-duplicate (in case markdown and text_box pipelines overlapped)
#                         final_embeddings_map = {e['content']: e for e in embeddings_to_insert}
#                         final_embeddings = list(final_embeddings_map.values())
                        
#                         print(f"💾 Inserting {len(final_embeddings)} total unique vectors...")
#                         supabase.table('chapter_embeddings').insert(final_embeddings).execute()
#                         update_db_status('chapters', item_id, 'completed')
#                         print(f"✅ Chapter {item_id} complete!\n")
#                     else:
#                         print(f"⚠️ No embeddings generated")
#                         update_db_status('chapters', item_id, 'error')
                
#                 except Exception as e:
#                     print(f"❌ Error processing {item_id}: {e}")
#                     import traceback
#                     traceback.print_exc()
#                     update_db_status('chapters', item_id, 'error')
        
#         except Exception as e:
#             print(f"❌ Worker loop error: {e}")
#             import traceback
#             traceback.print_exc()
        
#         print(f"💤 Sleeping {PROCESSING_LOOP_DELAY}s...\n{'='*60}\n")
#         time.sleep(PROCESSING_LOOP_DELAY)


# if __name__ == '__main__':
#     main_worker_loop()












import os
import time
import uuid
import requests
import sys
import re
import tempfile
from io import BytesIO
from typing import List, Dict, Any
from collections import deque, defaultdict
import numpy as np
from PIL import Image

# --- DOCLING IMPORTS ---
try:
    from docling.document_converter import DocumentConverter
    from docling.datamodel.base_models import InputFormat
    # Note: We don't use PdfPipelineOptions to avoid version compatibility issues
    DOCLING_AVAILABLE = True
except ImportError:
    print("❌ Docling not installed correctly. Please run: pip install docling")
    DOCLING_AVAILABLE = False

from supabase import create_client, Client
import pymupdf as fitz
from langchain_text_splitters import RecursiveCharacterTextSplitter
from urllib.parse import quote

# Import services
backend_dir = os.path.dirname(os.path.abspath(__file__))
if backend_dir not in sys.path:
    sys.path.insert(0, backend_dir)

from app.services.grading_service_utils.embedding_service import (
    initialize_embedding_service as init_bge_service,
    get_embeddings
)
from app.services.multimodal_service import (
    initialize_multimodal_service as init_vlm_service,
    get_descriptions_for_batch
)

# Configuration
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

# --- INITIALIZE DOCLING ---
DOC_CONVERTER = None

def init_docling():
    global DOC_CONVERTER
    if not DOCLING_AVAILABLE:
        return

    try:
        print("🚀 Initializing Docling...")
        # Use basic DocumentConverter without custom options to avoid version compatibility issues
        # The basic converter still extracts text well, including Hindi/Urdu content
        # BGE-M3 provides multilingual embedding support for cross-language queries
        DOC_CONVERTER = DocumentConverter()
        print("✅ Docling Initialized (Multilingual support via BGE-M3)")
        
    except Exception as e:
        print(f"❌ Docling Init Error: {e}")
        DOC_CONVERTER = None
        DOC_CONVERTER = DocumentConverter()

# --- HELPER FUNCTIONS ---

def detect_ncert_sections(text: str) -> List[str]:
    """
    Detects specific NCERT box types and styles (Spaced headers, Colors).
    """
    tags = []
    text_lower = text.lower()
    
    # 1. EXERCISES (Green Box)
    # Matches "EXERCISES" or "E X E R C I S E S"
    if re.search(r'e\s*x\s*e\s*r\s*c\s*i\s*s\s*e\s*s', text_lower):
        tags.append("SECTION: EXERCISES")
        tags.append("VISUAL: Green Box")
        tags.append("BOX_TYPE: Exercise")

    # 2. QUESTIONS (Blue Box)
    # Matches "QUESTIONS" or "Q U E S T I O N S"
    if re.search(r'q\s*u\s*e\s*s\s*t\s*i\s*o\s*n\s*s', text_lower):
        tags.append("SECTION: QUESTIONS")
        tags.append("VISUAL: Blue Box")
        tags.append("BOX_TYPE: Questions")

    # 3. WHAT YOU HAVE LEARNT (Pink Box)
    if 'what you have learnt' in text_lower:
        tags.append("SECTION: SUMMARY")
        tags.append("VISUAL: Pink Box")
        tags.append("BOX_TYPE: Summary")
        
    # 4. ACTIVITY (Yellow/Orange)
    if 'activity' in text_lower or 'gatividhi' in text_lower:
        tags.append("BOX_TYPE: Activity")
        tags.append("VISUAL: Yellow Box")

    # 5. THINK IT OVER
    if 'think it over' in text_lower:
        tags.append("BOX_TYPE: Think It Over")
        tags.append("VISUAL: Orange Box")

    return tags

def chunk_questions_section(text: str, page_num: int) -> List[Dict]:
    """
    Intelligently chunks question/exercise sections to keep all questions together.
    Detects numbered questions and ensures they're not split across chunks.
    Returns list of chunks with metadata.
    """
    # Detect if this is a questions/exercises section
    text_lower = text.lower()
    is_questions_section = any(keyword in text_lower for keyword in [
        'exercises', 'questions', 'ex e r c i s e s', 'q u e s t i o n s', 'e x e r c i s e s',
        'अभ्यास', 'प्रश्न', 'abhyas', 'prashn'
    ])
    
    if not is_questions_section:
        return None  # Use regular chunking
    
    # Split by numbered questions (pattern: number followed by period or space)
    # This pattern matches: "1.", "2.", "1 ", "2 ", etc.
    question_pattern = r'^(\d+)[\.\)]\s+'
    
    # Split text into question blocks
    lines = text.split('\n')
    question_blocks = []
    current_block = []
    
    for line in lines:
        # Check if this line starts a new question
        if re.match(question_pattern, line.strip()):
            # Save previous block if it exists
            if current_block:
                question_blocks.append('\n'.join(current_block))
            # Start new block
            current_block = [line]
        else:
            # Continue current block
            if current_block or line.strip():  # Don't start with empty lines
                current_block.append(line)
    
    # Add the last block
    if current_block:
        question_blocks.append('\n'.join(current_block))
    
    # If we found question blocks, chunk them intelligently
    if question_blocks:
        chunks = []
        current_chunk = []
        current_size = 0
        max_chunk_size = 3000  # Larger size for question sections to keep more questions together
        total_questions = len(question_blocks)
        
        for block in question_blocks:
            block_size = len(block)
            
            # If adding this block would exceed limit, save current chunk
            if current_size + block_size > max_chunk_size and current_chunk:
                chunk_text = '\n\n'.join(current_chunk)
                chunks.append({
                    'text': chunk_text,
                    'page': page_num,
                    'is_questions_section': True,
                    'question_count': len(current_chunk),
                    'total_questions_in_section': total_questions,
                    'chunk_index': len(chunks) + 1,
                    'total_chunks': None  # Will be set after we know total
                })
                current_chunk = [block]
                current_size = block_size
            else:
                current_chunk.append(block)
                current_size += block_size
        
        # Add the last chunk
        if current_chunk:
            chunk_text = '\n\n'.join(current_chunk)
            chunks.append({
                'text': chunk_text,
                'page': page_num,
                'is_questions_section': True,
                'question_count': len(current_chunk),
                'total_questions_in_section': total_questions,
                'chunk_index': len(chunks) + 1,
                'total_chunks': None
            })
        
        # Update total_chunks for all chunks
        total_chunks = len(chunks)
        for chunk in chunks:
            chunk['total_chunks'] = total_chunks
        
        return chunks
    
    return None  # Fall back to regular chunking

def extract_figure_references_from_text(text: str) -> List[str]:
    patterns = [
        r'(Figure|Fig\.|फिगर)\s*(\d+)\.(\d+)',
        r'(Activity|गतिविधि)\s*(\d+)\.(\d+)',
        r'(Table|तालिका)\s*(\d+)\.(\d+)',
        r'(Diagram|आरेख)\s*(\d+)\.(\d+)'
    ]
    references = []
    for pattern in patterns:
        matches = re.finditer(pattern, text, re.IGNORECASE | re.UNICODE)
        for match in matches:
            ref_type = match.group(1).capitalize()
            # Normalize terms
            type_mapping = {'फिगर': 'Figure', 'गतिविधि': 'Activity', 'तालिका': 'Table', 'आरेख': 'Diagram', 'Fig.': 'Figure'}
            ref_type = type_mapping.get(ref_type, ref_type)
            references.append(f"{ref_type} {match.group(2)}.{match.group(3)}")
    return list(set(references))

def create_enriched_image_content(image_info: Dict, gemini_description: str) -> str:
    page_num = image_info['page_number']
    parts = [f"[PAGE {page_num}]"]
    parts.append(f"[METADATA: Page {page_num}, Image {image_info['index']}]")
    
    if image_info.get('page_references'):
        refs_str = ", ".join(image_info['page_references'])
        parts.append(f"[REFERENCES: {refs_str}]")
    
    parts.append(f"\n[IMAGE_DESCRIPTION]\n{gemini_description}")
    parts.append(f"\n[LOCATION_TAGS: page {page_num}]")
    return "\n".join(parts)

# --- DATABASE / RATE LIMIT ---

def fetch_pending_chapters() -> List[Dict]:
    try:
        response = supabase.table('chapters').select('id, metadata, book_id').eq('embedding_status', 'not_started').limit(1).execute()
        return response.data
    except Exception as e:
        print(f"Error fetching chapters: {e}")
        return []

def update_db_status(table_name: str, item_id: uuid.UUID, status: str):
    try:
        supabase.table(table_name).update({'embedding_status': status}).eq('id', item_id).execute()
        print(f"✅ Updated {table_name} {item_id} → {status}")
    except Exception as e:
        print(f"Error updating status: {e}")

def wait_for_rate_limit():
    global REQUEST_TIMESTAMPS
    now = time.time()
    while REQUEST_TIMESTAMPS and REQUEST_TIMESTAMPS[0] <= now - RATE_LIMIT_WINDOW:
        REQUEST_TIMESTAMPS.popleft()
    if len(REQUEST_TIMESTAMPS) >= MAX_REQUESTS_PER_MINUTE:
        time.sleep(1)
    REQUEST_TIMESTAMPS.append(time.time())

# --- MAIN WORKER LOOP ---

def main_worker_loop():
    try:
        print("🚀 Initializing Services...")
        init_bge_service()
        init_vlm_service()
        init_docling()
        
        if not DOC_CONVERTER:
            print("❌ Critical: Docling failed to initialize.")
            return
            
        print("✅ Services Ready (DOCLING TEXT + GOOGLE VLM)\n")
    except Exception as e:
        print(f"❌ Initialization failed: {e}")
        return

    while True:
        try:
            pending = fetch_pending_chapters()
            
            for chapter in pending:
                item_id = chapter['id']
                book_id = chapter.get('book_id')
                metadata = chapter.get('metadata', {})
                
                update_db_status('chapters', item_id, 'processing')
                
                try:
                    pdf_path = metadata.get('supabase_storage_path')
                    if not pdf_path: continue
                    
                    pdf_url = f"{SUPABASE_URL}/storage/v1/object/public/{quote(PDF_BUCKET_NAME)}/{quote(pdf_path)}"
                    print(f"📥 Downloading PDF...")
                    response = requests.get(pdf_url, stream=True)
                    response.raise_for_status()
                    pdf_bytes = response.content
                    
                    embeddings_to_insert = []
                    
                    with tempfile.NamedTemporaryFile(suffix=".pdf", delete=False) as tmp_pdf:
                        tmp_pdf.write(pdf_bytes)
                        tmp_pdf_path = tmp_pdf.name

                    try:
                        # === PIPELINE 1: DOCLING (Page-Aware) ===
                        print("🚀 Running Docling...")
                        docling_result = DOC_CONVERTER.convert(tmp_pdf_path)
                        doc = docling_result.document
                        
                        # Group by Page
                        pages_content = defaultdict(list)
                        for item, level in doc.iterate_items():
                            page_no = 1
                            if hasattr(item, 'prov') and item.prov:
                                for prov in item.prov:
                                    if hasattr(prov, 'page_no'):
                                        page_no = prov.page_no
                                        break
                            
                            # Get text content from item, handling different item types
                            text_content = None
                            
                            # Check if this is a PictureItem - skip it entirely as images are handled in Pipeline 2
                            # The surrounding text (figure captions, descriptions) will be in other text items
                            item_type = type(item).__name__ if hasattr(type(item), '__name__') else str(type(item))
                            
                            if 'Picture' in item_type or 'Image' in item_type:
                                # Skip picture items - they're handled separately in the image pipeline
                                # The text around figures (captions, descriptions) will be in adjacent text items
                                continue
                            
                            # Handle text items
                            if hasattr(item, 'text'):
                                text_content = item.text
                            elif hasattr(item, 'export_to_markdown'):
                                try:
                                    # Some items require 'doc' argument
                                    markdown_output = item.export_to_markdown(doc)
                                    # Filter out HTML comments about missing images
                                    if markdown_output:
                                        # Remove the HTML comment about missing images
                                        markdown_output = re.sub(r'<!--.*?Image not available.*?-->', '', markdown_output, flags=re.DOTALL)
                                        if markdown_output.strip():
                                            text_content = markdown_output
                                except TypeError:
                                    # If it doesn't need doc argument, try without it
                                    try:
                                        markdown_output = item.export_to_markdown()
                                        if markdown_output:
                                            markdown_output = re.sub(r'<!--.*?Image not available.*?-->', '', markdown_output, flags=re.DOTALL)
                                            if markdown_output.strip():
                                                text_content = markdown_output
                                    except:
                                        text_content = None
                            elif hasattr(item, 'content'):
                                content_str = str(item.content)
                                # Filter out HTML comments about missing images
                                content_str = re.sub(r'<!--.*?Image not available.*?-->', '', content_str, flags=re.DOTALL)
                                if content_str.strip():
                                    text_content = content_str
                            
                            # Only add text content if it's not empty and doesn't contain the error message
                            if text_content and text_content.strip():
                                # Final check to ensure no image error messages
                                if 'Image not available' not in text_content and 'generate_picture_images' not in text_content:
                                    pages_content[page_no].append(text_content)
                        
                        # Chunking with smart handling for question sections
                        text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=100)
                        
                        for page_num in sorted(pages_content.keys()):
                            page_text = "\n\n".join(pages_content[page_num])
                            
                            # Try smart chunking for question sections first
                            question_chunks = chunk_questions_section(page_text, page_num)
                            
                            if question_chunks:
                                # Use smart chunking for questions - keeps all questions together
                                total_q_chunks = len(question_chunks)
                                total_questions = question_chunks[0].get('total_questions_in_section', total_q_chunks)
                                print(f"📋 Detected questions section on page {page_num}: {total_questions} questions in {total_q_chunks} chunks")
                                
                                for chunk_data in question_chunks:
                                    chunk_text = chunk_data['text']
                                    tags = detect_ncert_sections(chunk_text)
                                    
                                    meta_parts = [f"[PAGE {page_num}]"]
                                    meta_parts.append(f"[SECTION: EXERCISES/QUESTIONS]")
                                    meta_parts.append(f"[QUESTIONS_SECTION: Part {chunk_data['chunk_index']} of {chunk_data['total_chunks']}]")
                                    meta_parts.append(f"[QUESTIONS_IN_CHUNK: {chunk_data.get('question_count', 'multiple')}]")
                                    meta_parts.append(f"[TOTAL_QUESTIONS: {total_questions} questions in this section]")
                                    meta_parts.append("[QUERY_HINT: Query 'all questions' or 'complete questions list' to retrieve all parts]")
                                    meta_parts.append("[RETRIEVAL_HINT: Multiple chunks exist - retrieve all chunks with QUESTIONS_SECTION tag]")
                                    
                                    if tags: meta_parts.append("\n".join([f"[{t}]" for t in tags]))
                                    
                                    final_content = "\n".join(meta_parts) + f"\n{chunk_text}"
                                    
                                    embeddings_to_insert.append({
                                        'chapter_id': item_id, 'book_id': book_id,
                                        'content': final_content,
                                        'page_number': page_num, 
                                        'content_type': 'text',
                                        'embedding': None,
                                        'storage_path': None
                                    })
                            else:
                                # Use regular chunking for non-question sections
                                chunks = text_splitter.split_text(page_text)
                                
                                for chunk_text in chunks:
                                    # DETECT NCERT SECTIONS (Green box, Questions, etc.)
                                    tags = detect_ncert_sections(chunk_text)
                                    
                                    meta_parts = [f"[PAGE {page_num}]"]
                                    if tags: meta_parts.append("\n".join([f"[{t}]" for t in tags]))
                                    
                                    final_content = "\n".join(meta_parts) + f"\n{chunk_text}"
                                    
                                    embeddings_to_insert.append({
                                        'chapter_id': item_id, 'book_id': book_id,
                                        'content': final_content,
                                        'page_number': page_num, 
                                        'content_type': 'text',
                                        'embedding': None,
                                        'storage_path': None
                                    })

                        if embeddings_to_insert:
                            print(f"📝 Embedding {len(embeddings_to_insert)} text chunks...")
                            texts = [e['content'] for e in embeddings_to_insert]
                            vectors = get_embeddings(texts)
                            for i, v in enumerate(vectors): embeddings_to_insert[i]['embedding'] = v
                        
                        # === PIPELINE 2: IMAGES ===
                        print("🚀 Running Image Pipeline...")
                        pdf_doc = fitz.open(tmp_pdf_path)
                        all_images = []
                        
                        for page_num in range(len(pdf_doc)):
                            page = pdf_doc[page_num]
                            p_num = page_num + 1
                            page_text_context = page.get_text()
                            page_refs = extract_figure_references_from_text(page_text_context)
                            
                            for img_index, img in enumerate(page.get_images(full=True)):
                                try:
                                    base = pdf_doc.extract_image(img[0])
                                    img_bytes = base["image"]
                                    if len(img_bytes) < 5000: continue
                                    
                                    path = f"class-10/{book_id}/{item_id}_p{p_num}_{img_index}.png"
                                    supabase.storage.from_(IMAGE_BUCKET_NAME).upload(
                                        path=path, file=img_bytes, file_options={"upsert": "true"}
                                    )
                                    
                                    all_images.append({
                                        'index': img_index, 'bytes': img_bytes,
                                        'storage_path': path, 'page_number': p_num,
                                        'page_references': page_refs, 'page_text': page_text_context
                                    })
                                except: continue
                        pdf_doc.close()
                        
                        if all_images:
                            print(f"🖼️  Describing {len(all_images)} images...")
                            batches = [all_images[i:i+16] for i in range(0, len(all_images), 16)]
                            for batch in batches:
                                wait_for_rate_limit()
                                b_bytes = [x['bytes'] for x in batch]
                                b_paths = [x['storage_path'] for x in batch]
                                analyses = get_descriptions_for_batch(b_bytes, b_paths)
                                
                                for analysis in analyses:
                                    if analysis.get('analysis', '').upper() == 'IGNORE': continue
                                    match = next((x for x in batch if x['storage_path'] == analysis['image_id']), None)
                                    if match:
                                        content = create_enriched_image_content(match, analysis['analysis'])
                                        embeddings_to_insert.append({
                                            'chapter_id': item_id, 'book_id': book_id,
                                            'content': content,
                                            'page_number': match['page_number'],
                                            'content_type': 'image_description',
                                            'embedding': None,
                                            'storage_path': match['storage_path']
                                        })

                    finally:
                        if os.path.exists(tmp_pdf_path): os.unlink(tmp_pdf_path)

                    img_embeds = [e for e in embeddings_to_insert if e['content_type'] == 'image_description']
                    if img_embeds:
                        vecs = get_embeddings([e['content'] for e in img_embeds])
                        for i, e in enumerate(img_embeds): e['embedding'] = vecs[i]

                    if embeddings_to_insert:
                        print(f"💾 Inserting {len(embeddings_to_insert)} total vectors...")
                        supabase.table('chapter_embeddings').insert(embeddings_to_insert).execute()
                        update_db_status('chapters', item_id, 'completed')
                    else:
                        update_db_status('chapters', item_id, 'error')

                except Exception as e:
                    print(f"❌ Error: {e}")
                    update_db_status('chapters', item_id, 'error')
                    
        except Exception as e:
            print(f"❌ Loop Error: {e}")
            time.sleep(PROCESSING_LOOP_DELAY)
        
        print(f"💤 Sleeping {PROCESSING_LOOP_DELAY}s...")
        time.sleep(PROCESSING_LOOP_DELAY)

if __name__ == '__main__':
    main_worker_loop()