# # Create a new file: multimodal_service.py

# import torch
# from PIL import Image
# from transformers import AutoModel, AutoTokenizer
# from io import BytesIO
# import typing  # Import entire typing module to make it available for model code
# import warnings

# # Suppress FutureWarnings from transformers about deprecated arguments
# warnings.filterwarnings('ignore', category=FutureWarning, module='transformers')

# MODEL = None
# TOKENIZER = None

# def initialize_multimodal_service():
#     """Initializes the MiniCPM-V 4.5 model."""
#     global MODEL, TOKENIZER
#     if MODEL:
#         return

#     print("Loading MiniCPM-V 4.5 model...")
#     model_path = 'openbmb/MiniCPM-Llama3-V-2_5'
    
#     # Ensure typing imports are available for model's custom code
#     # The model's resampler.py might use List without importing it
#     from typing import List, Dict, Tuple, Any, Optional, Union
#     import sys
    
#     # Make typing available in builtins for model code that uses it directly
#     if not hasattr(__builtins__, 'List'):
#         import builtins
#         builtins.List = List
#         builtins.Dict = Dict
#         builtins.Tuple = Tuple
#         builtins.Any = Any
#         builtins.Optional = Optional
#         builtins.Union = Union
    
#     try:
#         # Load tokenizer with explicit use_fast to avoid warnings
#         TOKENIZER = AutoTokenizer.from_pretrained(
#             model_path, 
#             trust_remote_code=True,
#             use_fast=True,  # Explicitly set to avoid warning (model uses slow processor)
#         )
#         MODEL = AutoModel.from_pretrained(
#             model_path,
#             dtype=torch.float16,  # Changed from torch_dtype to dtype
#             device_map='auto',
#             trust_remote_code=True
#         )
#         print("Multimodal Service Initialized (MiniCPM-V).")
#     except Exception as e:
#         # If it's a typing-related error, provide helpful message
#         if "List" in str(e) or "name 'List' is not defined" in str(e):
#             print(f"Error: Model code requires typing imports. Error: {e}")
#             print("This might be a compatibility issue with the model's custom code.")
#             raise Exception(f"Model initialization failed due to typing import issue: {e}")
#         raise

# def get_description_for_image_bytes(image_bytes: bytes) -> str:
#     """
#     Generates a text description for an image using MiniCPM-V.
#     """
#     if not MODEL:
#         raise Exception("Multimodal service not initialized.")
    
#     try:
#         image = Image.open(BytesIO(image_bytes)).convert('RGB')
        
#         # This is a specific prompt for MiniCPM-V
#         # We ask it to be descriptive for RAG
#         prompt = (
#             "Describe this image in detail. "
#             "If it is a diagram or figure, explain what it shows. "
#             "If it is a table, transcribe its content in a structured way."
#         )
        
#         msgs = [{'role': 'user', 'content': prompt}]
        
#         # Model-specific call
#         res = MODEL.chat(
#             image=image,
#             msgs=msgs,
#             tokenizer=TOKENIZER,
#             sampling=True, 
#             temperature=0.7,
#             system_prompt="You are a helpful assistant."
#         )
        
#         return res
#     except Exception as e:
#         print(f"Error generating image description: {e}")
#         return "[Error: Could not describe image]"





# # In multimodal_service.py
# import google.generativeai as genai
# import os
# from PIL import Image
# from io import BytesIO
# import dotenv
# import json  # <-- NEW: For parsing the response
# import re  # <-- For JSON recovery
# from typing import List, Dict, Any # <-- NEW: For type hinting

# dotenv.load_dotenv()

# MODEL = None

# # This is a new, highly-structured prompt for BATCH processing.
# GEMINI_BATCH_PROMPT = """
# You are analyzing images from NCERT (Indian educational) textbook chapters for a study assistant.

# **YOUR TASK:**
# I will show you up to 16 images from the same chapter. For EACH image, decide:
# - Is it academically valuable? (diagram, chart, map, table, etc.) → Describe it thoroughly
# - Is it irrelevant? (QR code, logo, plain text page, decorative border) → Mark as "IGNORE"

# **RESPOND WITH VALID JSON ONLY** (no markdown, no ```json wrapper):
# {
#   "image_analyses": [
#     {"image_id": "path_1.png", "analysis": "Detailed description here..."},
#     {"image_id": "path_2.png", "analysis": "IGNORE"}
#   ]
# }

# **DESCRIPTION GUIDELINES (for non-IGNORE images):**
# ✓ **Scientific diagrams**: Label all parts, explain the process/concept
# ✓ **Tables**: Transcribe into Markdown table format
# ✓ **Charts/Graphs**: Describe axes, trends, and what data shows
# ✓ **Maps**: Identify regions, features, legends
# ✓ **Math figures**: Explain constructions, theorems being illustrated

# **IGNORE CRITERIA:**
# ✗ QR codes, publisher logos, page numbers
# ✗ Pages that are ONLY plain text paragraphs (no diagrams/tables)
# ✗ Decorative borders, clipart without labels

# **IMPORTANT:** 
# - The image_id in your response MUST exactly match the one I provide
# - Respond in the same language as the image's text (Hindi → Hindi, English → English)
# - Be thorough for diagrams (3-5 sentences), brief for simple figures

# I'll now provide the images. Here are their IDs in order:
# {MANIFEST_PLACEHOLDER}
# """

# def initialize_multimodal_service():
#     """Initializes the Google Gemini model."""
#     global MODEL
#     if MODEL:
#         return

#     try:
#         api_key = os.getenv("GOOGLE_API_KEY")
#         if not api_key:
#             raise ValueError("GOOGLE_API_KEY not found in environment variables.")
            
#         genai.configure(api_key=api_key)
        
#         # List available models and find one that supports generateContent
#         model_name = None
#         available_models_info = []
        
#         try:
#             print("🔍 Listing available Gemini models...")
#             for model in genai.list_models():
#                 if 'generateContent' in model.supported_generation_methods:
#                     # Store both full name and short name
#                     full_name = model.name  # e.g., "models/gemini-1.5-flash-latest"
#                     short_name = model.name.replace("models/", "")  # e.g., "gemini-1.5-flash-latest"
#                     available_models_info.append({
#                         'full': full_name,
#                         'short': short_name,
#                         'display_name': model.display_name if hasattr(model, 'display_name') else short_name
#                     })
            
#             # Print available models for debugging
#             if available_models_info:
#                 print(f"✅ Found {len(available_models_info)} models with generateContent support:")
#                 for info in available_models_info:
#                     print(f"   - {info['short']} (full: {info['full']})")
                
#                 # Prefer gemini-2.5-flash (latest stable Flash model) for speed and quality
#                 # Then fall back to other flash models, then pro models
#                 selected_model_info = None
                
#                 # First, try to find gemini-2.5-flash specifically (best for OCR/image tasks)
#                 gemini_25_flash = [m for m in available_models_info if m['short'] == 'gemini-2.5-flash']
#                 if gemini_25_flash:
#                     selected_model_info = gemini_25_flash[0]
#                     print(f"📌 Selected gemini-2.5-flash (optimal for image/OCR tasks)")
#                 else:
#                     # Prefer 2.5 flash models, then other flash models
#                     flash_25_models = [m for m in available_models_info if 'flash' in m['short'].lower() and '2.5' in m['short']]
#                     flash_models = [m for m in available_models_info if 'flash' in m['short'].lower()]
#                     pro_models = [m for m in available_models_info if 'pro' in m['short'].lower() and 'flash' not in m['short'].lower()]
                    
#                     if flash_25_models:
#                         selected_model_info = flash_25_models[0]
#                         print(f"📌 Selected Flash 2.5 model: {selected_model_info['short']}")
#                     elif flash_models:
#                         selected_model_info = flash_models[0]
#                         print(f"📌 Selected Flash model: {selected_model_info['short']}")
#                     elif pro_models:
#                         selected_model_info = pro_models[0]
#                         print(f"📌 Selected Pro model: {selected_model_info['short']}")
#                     else:
#                         selected_model_info = available_models_info[0]
#                         print(f"📌 Selected model: {selected_model_info['short']}")
                
#                 # Use the detected model name
#                 model_name = selected_model_info['short']
                
#         except Exception as e:
#             print(f"⚠️  Could not list models: {e}")
#             print("   Falling back to default model names...")
        
#         # If we couldn't find a model from the list, try common candidates
#         if not model_name:
#             model_candidates = [
#                 "gemini-1.5-flash",
#                 "gemini-1.5-pro",
#                 "gemini-pro",
#             ]
            
#             for candidate in model_candidates:
#                 try:
#                     # Test if this model works by trying to create it
#                     test_model = genai.GenerativeModel(model_name=candidate)
#                     # If successful, use this model
#                     model_name = candidate
#                     print(f"📌 Using candidate model: {model_name}")
#                     break
#                 except Exception as test_error:
#                     print(f"   ❌ {candidate} failed: {test_error}")
#                     continue
        
#         if not model_name:
#             raise ValueError(
#                 f"Could not find an available Gemini model. "
#                 f"Please check your API key and available models. "
#                 f"Error: No working model found."
#             )
        
#         generation_config = {
#             "temperature": 0.1,
#             "top_p": 0.95,
#             "top_k": 40,
#             "max_output_tokens": 16384, # Increased for large batches (16 images can generate long responses)
#         }
        
#         # Try to create the model - if it fails with short name, try full name
#         MODEL = None
#         try:
#             MODEL = genai.GenerativeModel(
#                 model_name=model_name,
#                 generation_config=generation_config
#             )
#         except Exception as e:
#             # If short name fails, try using full name if we have it
#             if available_models_info:
#                 for info in available_models_info:
#                     if info['short'] == model_name:
#                         print(f"⚠️  Short name failed, trying full name: {info['full']}")
#                         try:
#                             MODEL = genai.GenerativeModel(
#                                 model_name=info['full'],
#                                 generation_config=generation_config
#                             )
#                             model_name = info['full']  # Update to full name
#                             break
#                         except Exception as e2:
#                             continue
#             if not MODEL:
#                 raise e
            
#         print(f"Multimodal Service Initialized (Google Gemini - {model_name} - BATCH MODE).")
        
#     except Exception as e:
#         print(f"Error initializing Gemini: {e}")
#         raise

# def get_descriptions_for_batch(
#     image_bytes_batch: List[bytes], 
#     storage_path_batch: List[str]
# ) -> List[Dict[str, Any]]:
#     """
#     Generates text descriptions for a BATCH of images using Gemini.
#     Returns a list of analysis objects.
#     """
#     if not MODEL:
#         raise Exception("Multimodal service (Gemini) not initialized.")
#     if not image_bytes_batch or len(image_bytes_batch) > 16:
#         raise ValueError("Image batch must be between 1 and 16 images.")
        
#     try:
#         # 1. Build the "manifest" as JSON (This is the safer way)
#         manifest = [
#             {"image_index": i, "image_id": storage_path}
#             for i, storage_path in enumerate(storage_path_batch)
#         ]
#         manifest_json = json.dumps(manifest, indent=2)
        
#         # 2. Build the full prompt (No placeholder needed)
#         full_prompt = (
#             f"{GEMINI_BATCH_PROMPT}\n\n"
#             f"Here is the manifest for the {len(image_bytes_batch)} images in this batch:\n"
#             f"{manifest_json}\n\n"
#             "Now, analyze the images provided after this prompt."
#         )

#         # 3. Build the model input list
#         model_input = [full_prompt]
#         for img_bytes in image_bytes_batch:
#             model_input.append(Image.open(BytesIO(img_bytes)).convert('RGB'))

#         # 4. Generate content
#         print(f"📤 Sending batch of {len(image_bytes_batch)} images to Gemini...")
#         response = MODEL.generate_content(model_input)
        
#         # Check if response was truncated
#         if hasattr(response, 'candidates') and response.candidates:
#             finish_reason = response.candidates[0].finish_reason if response.candidates[0].finish_reason else None
#             if finish_reason == 'MAX_TOKENS':
#                 print(f"⚠️  Warning: Response was truncated due to token limit. Consider reducing batch size.")
        
#         # 5. Use your new, more robust JSON extraction logic
#         raw_text = response.text.strip()
        
#         # Remove markdown fences if present
#         if raw_text.startswith("```"):
#             json_part = raw_text.split("```")[1]
#             if json_part.startswith("json"):
#                 raw_text = json_part[4:].strip() # Remove 'json' and any newlines
#             else:
#                 raw_text = json_part.strip()
        
#         # Try to parse JSON, with recovery for truncated responses
#         try:
#             result_data = json.loads(raw_text)
#             analyses = result_data.get("image_analyses", [])
#             print(f"✅ Gemini returned {len(analyses)} analyses")
#             return analyses
#         except json.JSONDecodeError as json_error:
#             # Try to recover partial JSON if possible
#             print(f"❌ JSON Parse Error: {json_error}")
#             print(f"Raw response length: {len(raw_text)} characters")
#             print(f"Raw response preview: {raw_text[:1000]}...")
            
#             # Try to extract what we can from the partial JSON
#             try:
#                 # Find where "image_analyses" array starts
#                 start_idx = raw_text.find('"image_analyses"')
#                 if start_idx == -1:
#                     start_idx = raw_text.find('[')
                
#                 if start_idx != -1:
#                     # Extract the array portion
#                     array_start = raw_text.find('[', start_idx)
#                     if array_start != -1:
#                         # Try to find complete objects by counting braces
#                         brace_count = 0
#                         in_string = False
#                         escape_next = False
#                         last_complete_idx = array_start
                        
#                         for i in range(array_start + 1, len(raw_text)):
#                             char = raw_text[i]
                            
#                             if escape_next:
#                                 escape_next = False
#                                 continue
                            
#                             if char == '\\':
#                                 escape_next = True
#                                 continue
                            
#                             if char == '"' and not escape_next:
#                                 in_string = not in_string
#                                 continue
                            
#                             if not in_string:
#                                 if char == '{':
#                                     brace_count += 1
#                                 elif char == '}':
#                                     brace_count -= 1
#                                     if brace_count == 0:
#                                         last_complete_idx = i + 1
#                                         break
#                                 elif char == ']' and brace_count == 0:
#                                     last_complete_idx = i
#                                     break
                        
#                         # Extract the portion up to the last complete object
#                         partial_json = raw_text[:last_complete_idx] + ']}'
                        
#                         # Try to parse the partial JSON
#                         try:
#                             result_data = json.loads(partial_json)
#                             analyses = result_data.get("image_analyses", [])
#                             if analyses:
#                                 print(f"⚠️  Recovered {len(analyses)} complete analyses from truncated response")
#                                 return analyses
#                         except:
#                             pass
#             except Exception as recovery_error:
#                 print(f"⚠️  Could not recover partial JSON: {recovery_error}")
            
#             return []
        
#     except json.JSONDecodeError as e:
#         print(f"❌ JSON Parse Error: {e}")
#         if 'response' in locals():
#             print(f"Raw response length: {len(response.text)} characters")
#             print(f"Raw response preview: {response.text[:1000]}...")
#         return []
#     except Exception as e:
#         print(f"❌ Gemini API Error: {e}")
#         return []


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

# --- HELPER FUNCTIONS ---

def extract_figure_references_from_text(text: str, page_num: int) -> List[str]:
    """
    Extract figure/activity/table references from surrounding text.
    Returns list like ["Figure 7.1", "Activity 7.2"]
    """
    patterns = [
        r'(Figure|Fig\.|फिगर)\s*(\d+)\.(\d+)',
        r'(Activity|गतिविधि)\s*(\d+)\.(\d+)',
        r'(Table|तालिका)\s*(\d+)\.(\d+)',
        r'(Diagram|आरेख)\s*(\d+)\.(\d+)'
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
        # Limit context to 200 chars to avoid bloat
        context_preview = nearby_text.strip()[:200]
        if len(nearby_text) > 200:
            context_preview += "..."
        parts.append(f"\n[CONTEXT]\n{context_preview}")
    
    return "\n".join(parts)

def extract_text_near_image(doc: fitz.Document, page_num: int, img_bbox=None) -> str:
    """
    Extract text near an image on the page for context.
    This helps capture figure captions and references.
    """
    try:
        page = doc[page_num]
        # Get all text from the page
        text = page.get_text()
        
        # For now, return the full page text
        # You could implement more sophisticated proximity detection
        return text
    except:
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
                    print(f"Text pipeline: {len(embeddings_to_insert)} vectors generated.")

                    # --- IMAGE PIPELINE WITH METADATA ---
                    print("Running image pipeline with metadata extraction...")
                    
                    # Reopen for image extraction
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
                                
                                # --- IMAGE FILTERING ---
                                image_pil = Image.open(BytesIO(image_bytes))
                                width, height = image_pil.size
                                
                                if width < 100 or height < 100:
                                    print(f"Skipping tiny: {width}x{height}px")
                                    continue
                                
                                if len(image_bytes) < 5000:
                                    print(f"Skipping small file: {len(image_bytes)} bytes")
                                    continue
                                
                                grayscale = image_pil.convert('L')
                                img_array = np.array(grayscale)
                                variance = np.var(img_array)
                                
                                if variance < 100:
                                    print(f"Skipping low-variance image")
                                    continue
                                # --- END FILTER ---
                                
                                # Upload image
                                image_name = f"{item_id}_page_{page_num+1}_img_{img_index}.png"
                                upload_path = f"class-10/{book_id}/{image_name}"
                                print(f"Uploading {image_name}...")
                                supabase.storage.from_(IMAGE_BUCKET_NAME).upload(
                                    path=upload_path,
                                    file=image_bytes,
                                    file_options={"content-type": "image/png", "upsert": "true"}
                                )
                                
                                # Save with context
                                uploaded_images_info.append({
                                    'page_number': page_num + 1,
                                    'image_index': img_index,
                                    'image_bytes': image_bytes,
                                    'storage_path': upload_path,
                                    'nearby_text': page_text  # NEW: Store context
                                })
                            except Exception as e:
                                print(f"Warning: Image extraction error: {e}")
                                continue
                    doc.close()
                    
                    # Batch images
                    image_batches = [
                        uploaded_images_info[i:i + GEMINI_BATCH_SIZE]
                        for i in range(0, len(uploaded_images_info), GEMINI_BATCH_SIZE)
                    ]
                    
                    print(f"Extracted {len(uploaded_images_info)} images in {len(image_batches)} batches.")
                    
                    all_valid_captions = []
                    
                    # Process each batch
                    for batch in image_batches:
                        wait_for_rate_limit()
                        
                        image_bytes_batch = [img['image_bytes'] for img in batch]
                        storage_path_batch = [img['storage_path'] for img in batch]
                        
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
                                    # --- CREATE ENRICHED CONTENT ---
                                    enriched_content = create_searchable_image_content(
                                        gemini_description=caption,
                                        page_number=original_info['page_number'],
                                        image_index=original_info['image_index'],
                                        nearby_text=original_info['nearby_text']
                                    )
                                    # --- END ENRICHMENT ---
                                    
                                    all_valid_captions.append({
                                        'caption': enriched_content,  # Now metadata-rich!
                                        'page_number': original_info['page_number'],
                                        'storage_path': image_id
                                    })
                                    print(f"✓ Enriched: {image_id}")
                                else:
                                    print(f"Warning: Unknown image_id: {image_id}")
                            elif image_id:
                                print(f"✓ Ignored: {image_id}")

                    # Embed enriched captions
                    if all_valid_captions:
                        captions_list = [c['caption'] for c in all_valid_captions]
                        print(f"Embedding {len(captions_list)} enriched descriptions...")
                        image_vectors = get_embeddings(captions_list)
                        
                        for i, caption_data in enumerate(all_valid_captions):
                            embeddings_to_insert.append({
                                'chapter_id': item_id,
                                'book_id': book_id,
                                'content': caption_data['caption'],  # Metadata-rich!
                                'page_number': caption_data['page_number'],
                                'content_type': 'image_description',
                                'embedding': image_vectors[i],
                                'storage_path': caption_data['storage_path']
                            })
                    print(f"Image pipeline: {len(all_valid_captions)} enriched vectors.")

                    # --- BATCH INSERT ---
                    if embeddings_to_insert:
                        print(f"Inserting {len(embeddings_to_insert)} total vectors...")
                        supabase.table('chapter_embeddings').insert(embeddings_to_insert).execute()
                        update_db_status('chapters', item_id, 'completed')
                    else:
                        print(f"No content found for chapter {item_id}.")
                        update_db_status('chapters', item_id, 'error')
                
                except Exception as e:
                    print(f"Fatal error processing chapter {item_id}: {e}")
                    update_db_status('chapters', item_id, 'error')

        except Exception as e:
            print(f"Worker Loop Error: {e}")
        
        print(f"Cycle complete. Sleeping {PROCESSING_LOOP_DELAY}s.")
        time.sleep(PROCESSING_LOOP_DELAY)

if __name__ == '__main__':
    main_worker_loop()