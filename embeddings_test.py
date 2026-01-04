# import streamlit as st
# import re
# import os
# from pathlib import Path
# import dotenv
# from typing import List
# from supabase import create_client, Client
# from sentence_transformers import SentenceTransformer
# from openai import OpenAI
# os.environ["TOKENIZERS_PARALLELISM"] = "false"

# # Load .env from parent directory (project root)
# env_path = Path(__file__).parent.parent / ".env"
# dotenv.load_dotenv(env_path)

# # --- 1. CONFIGURATION ---
# BGE_MODEL_NAME = "BAAI/bge-m3"
# OPENAI_MODEL = "gpt-4o-mini"
# EMBEDDING_DIM = 1024
# MATCH_THRESHOLD = 0.5  # Lowered from 0.5 for better recall
# MATCH_COUNT = 15        # Increased from 5 for more context

# # --- 2. INITIALIZATION (CACHED) ---

# @st.cache_resource
# def init_supabase() -> Client:
#     """Initialize and return the Supabase client."""
#     url = os.getenv("SUPABASE_URL")
#     key = os.getenv("SUPABASE_SERVICE_KEY")
#     if not url or not key:
#         st.error("Missing SUPABASE_URL or SUPABASE_SERVICE_KEY in .env file.")
#         st.stop()
#     return create_client(url, key)

# @st.cache_resource
# def load_embedding_model() -> SentenceTransformer:
#     """Load and cache the BGE-M3 model."""
#     with st.spinner("Loading embedding model (bge-m3)..."):
#         model = SentenceTransformer(BGE_MODEL_NAME)
#     return model

# @st.cache_data
# def load_books_and_chapters(_supabase: Client) -> dict:
#     """Fetch all Class 10 books and their 'completed' chapters."""
#     with st.spinner("Fetching books and completed chapters..."):
#         try:
#             # 1. Fetch Class 10 books
#             books_res = _supabase.table("books").select("id, title").eq("class", 10).execute()
            
#             # 2. Fetch 'completed' chapters
#             chapters_res = _supabase.table("chapters").select("id, title, book_id").eq("embedding_status", "completed").execute()

#             # 3. Organize data for dropdowns
#             books_data = {}
#             for book in books_res.data:
#                 books_data[book['id']] = {
#                     "name": book['title'],
#                     "chapters": []
#                 }
            
#             for chapter in chapters_res.data:
#                 if chapter['book_id'] in books_data:
#                     books_data[chapter['book_id']]['chapters'].append({
#                         "id": chapter['id'],
#                         "title": chapter['title']
#                     })
            
#             # Filter out books with no completed chapters
#             return {book_id: data for book_id, data in books_data.items() if data['chapters']}
            
#         except Exception as e:
#             st.error(f"Error fetching data: {e}")
#             return {}

# # --- 3. CORE RAG FUNCTIONS ---

# def extract_figure_reference(query: str) -> dict:
#     """Extract figure/activity number from query."""
#     # Match patterns like: "figure 7.4", "activity 7.1", "diagram 5.2"
#     # Added 'फिगर', 'गतिविधि', 'तालिका' for Hindi support
#     pattern = r'(figure|activity|diagram|table|फिगर|गतिविधि|तालिका)\s*(\d+)\.(\d+)'
#     match = re.search(pattern, query.lower())
    
#     if match:
#         fig_type = match.group(1)
#         chapter_num = int(match.group(2))
#         fig_num = int(match.group(3))
        
#         # We no longer estimate the page. We just return the reference.
#         return {
#             'type': fig_type,
#             'number': f"{chapter_num}.{fig_num}",
#         }
#     return None

# def find_relevant_chunks(supabase: Client, chapter_id: str, query_embedding: List[float], query_text: str) -> List[dict]:
#     """
#     Find relevant chunks using a HYBRID search (Vector + Keyword).
    
#     1. Runs a vector search (low threshold for figs, high for normal).
#     2. If a fig/activity is mentioned, runs a *separate* keyword search
#        to guarantee finding the [REFERENCES: ...] tag.
#     3. Combines and re-ranks all results.
#     """
    
#     fig_ref = extract_figure_reference(query_text)
    
#     # Use a dictionary to store chunks by ID, auto-handling duplicates
#     all_chunks = {}

#     # --- 1. VECTOR SEARCH (SEMANTIC) ---
#     if fig_ref:
#         search_threshold = 0.2  # Low threshold for figure queries
#     else:
#         search_threshold = MATCH_THRESHOLD # 0.5 for normal queries
    
#     try:
#         response_vector = supabase.rpc("match_embeddings_for_chapter", {
#             "query_embedding": query_embedding,
#             "p_chapter_id": chapter_id,
#             "match_threshold": search_threshold,
#             "match_count": MATCH_COUNT,
#             "page_filter": None
#         }).execute()

#         if response_vector.data:
#             for chunk in response_vector.data:
#                 all_chunks[chunk['id']] = chunk
                
#     except Exception as e:
#         st.error(f"Error during vector search: {e}")

#     # --- 2. KEYWORD SEARCH (FALLBACK) ---
#     # If it was a figure query, we ALSO do a direct keyword search 
#     # to guarantee we find the reference, even if vector similarity is 0.
#     if fig_ref:
#         try:
#             # e.g., "%activity 8.2%"
#             search_term = f"%{fig_ref['type']} {fig_ref['number']}%" 
            
#             response_keyword = supabase.table("chapter_embeddings") \
#                 .select("id, content, page_number, content_type, storage_path") \
#                 .eq("chapter_id", chapter_id) \
#                 .ilike("content", search_term) \
#                 .execute()

#             if response_keyword.data:
#                 for chunk in response_keyword.data:
#                     # Add any new chunks found by keyword
#                     if chunk['id'] not in all_chunks:
#                         all_chunks[chunk['id']] = chunk
                        
#         except Exception as e:
#             st.error(f"Error during fallback keyword search: {e}")

#     # --- 3. COMBINE AND PRIORITIZE ---
#     if not all_chunks:
#         return []
    
#     final_chunk_list = list(all_chunks.values())
    
#     if fig_ref:
#         exact_matches = []
#         other_images = []
#         text_results = []
        
#         # e.g., "activity 8.2"
#         ref_string = f"{fig_ref['type']} {fig_ref['number']}".lower()
        
#         for r in final_chunk_list:
#             content_lower = r['content'].lower()
            
#             # If the literal string is in the content, it's an exact match
#             if ref_string in content_lower:
#                 exact_matches.append(r)
#             # Else, if it's just a semantically related image
#             elif r['content_type'] == 'image_description':
#                 other_images.append(r)
#             # Else, it's semantically related text
#             else:
#                 text_results.append(r)
        
#         # Return in prioritized order
#         return exact_matches + other_images + text_results
    
#     # If not a figure query, just return the vector results
#     # (We must .values() because all_chunks is a dict)
#     return final_chunk_list

# def get_query_embedding(model: SentenceTransformer, query: str) -> List[float]:
#     """Generate embedding for the user's query."""
#     return model.encode(query, normalize_embeddings=True).tolist()

# def get_openai_response(client: OpenAI, prompt: str, context: str) -> str:
#     """Get a final answer from OpenAI based on the context."""
    
#     system_prompt = """You are an expert NCERT textbook assistant helping students learn.

# **Your Rules:**
# 1. Answer ONLY based on the provided context from the textbook
# 2. If the context contains image descriptions, use them to explain visual concepts
# 3. Be clear, accurate, and educational in your explanations
# 4. If the answer is not in the context, say: "I don't have information about this in the current chapter."
# 5. Use the same language as the question (English/Hindi/etc.)
# 6. For diagrams/tables mentioned in context, explain them thoroughly
# 7. Keep answers concise but complete (2-4 paragraphs max)

# **Response Format:**
# - Start with a direct answer
# - Support with details from the context
# - If relevant, mention page numbers or figures"""
    
#     user_message = f"""**Context from NCERT Textbook:**

# {context}

# ---

# **Student's Question:**
# {prompt}

# Please answer the question using only the information provided in the context above."""
    
#     try:
#         response = client.chat.completions.create(
#             model=OPENAI_MODEL,
#             messages=[
#                 {"role": "system", "content": system_prompt},
#                 {"role": "user", "content": user_message}
#             ],
#             temperature=0.2,  # Slightly higher for more natural responses
#             max_tokens=800    # Limit response length
#         )
#         return response.choices[0].message.content
#     except Exception as e:
#         st.error(f"Error with OpenAI API: {e}")
#         return "Sorry, I couldn't get an answer from the AI model."

# # --- 4. STREAMLIT APP UI ---

# st.set_page_config(layout="wide", page_title="NCERT RAG Tester", page_icon="📚")

# # Initialize clients
# supabase = init_supabase()
# embed_model = load_embedding_model()
# books_data = load_books_and_chapters(supabase)

# # --- Sidebar ---
# with st.sidebar:
#     st.title("⚙️ Configuration")
    
#     # Check for API key
#     openai_key_available = bool(os.getenv("OPENAI_API_KEY"))
#     try:
#         if hasattr(st, 'secrets') and "OPENAI_API_KEY" in st.secrets:
#             openai_key_available = True
#     except:
#         pass
    
#     if not openai_key_available:
#         st.warning("⚠️ Set `OPENAI_API_KEY` in your .env file")
#     else:
#         st.success("✅ OpenAI API Key loaded")
    
#     st.divider()
    
#     # 1. Book Selection
#     if not books_data:
#         st.error("No books with completed chapters found!")
#         st.stop()
    
#     book_name_to_id = {data['name']: book_id for book_id, data in books_data.items()}
#     selected_book_name = st.selectbox(
#         "📖 Choose a Book",
#         options=list(book_name_to_id.keys())
#     )
    
#     # 2. Chapter Selection
#     selected_book_id = None
#     selected_chapter_id = None
#     selected_chapter_name = None
    
#     if selected_book_name:
#         selected_book_id = book_name_to_id[selected_book_name]
#         chapters_in_book = books_data[selected_book_id]['chapters']
        
#         if not chapters_in_book:
#             st.warning("No completed chapters in this book.")
#             st.stop()
        
#         chapter_name_to_id = {chap['title']: chap['id'] for chap in chapters_in_book}
        
#         selected_chapter_name = st.selectbox(
#             "📑 Choose a Chapter",
#             options=list(chapter_name_to_id.keys())
#         )
        
#         if selected_chapter_name:
#             selected_chapter_id = chapter_name_to_id[selected_chapter_name]
#             st.success(f"✓ Ready to chat!")
    
#     st.divider()
    
#     # Advanced settings
#     with st.expander("🔧 Advanced Settings"):
#         st.caption(f"Match Threshold: {MATCH_THRESHOLD}")
#         st.caption(f"Retrieved Chunks: {MATCH_COUNT}")
#         st.caption(f"Model: {OPENAI_MODEL}")

# # --- Main Chat ---
# st.title("📚 Studious NCERT Chatbot")

# if not selected_chapter_name:
#     st.info("👈 Please choose a book and chapter from the sidebar to begin.")
#     st.stop()

# st.subheader(f"💬 {selected_book_name} - {selected_chapter_name}")

# # Initialize chat history
# if "messages" not in st.session_state:
#     st.session_state.messages = []

# # Display chat messages from history
# for message in st.session_state.messages:
#     with st.chat_message(message["role"]):
#         st.markdown(message["content"])
#         if "context" in message and message["context"]:
#             with st.expander("📄 View Retrieved Context"):
#                 st.markdown(message["context"]["text"])

# # React to user input
# if prompt := st.chat_input("Ask a question about this chapter..."):
    
#     # Check for OpenAI API Key
#     openai_key = os.getenv("OPENAI_API_KEY")
#     if not openai_key:
#         try:
#             if hasattr(st, 'secrets') and "OPENAI_API_KEY" in st.secrets:
#                 openai_key = st.secrets["OPENAI_API_KEY"]
#         except:
#             pass
    
#     if not openai_key:
#         st.error("❌ OPENAI_API_KEY is not set. Add it to your .env file.")
#         st.stop()
    
#     openai_client = OpenAI(api_key=openai_key)
    
#     # Add user message to chat history
#     st.session_state.messages.append({"role": "user", "content": prompt})
#     with st.chat_message("user"):
#         st.markdown(prompt)

#     # RAG Pipeline
#     with st.chat_message("assistant"):
#         with st.spinner("🔍 Searching textbook... 🤔 Thinking..."):
            
#             # 1. Embed user query
#             query_embedding = get_query_embedding(embed_model, prompt)
            
#             # 2. Find relevant chunks
#             chunks = find_relevant_chunks(supabase, selected_chapter_id, query_embedding, prompt)
            
#             if not chunks:
#                 no_info_msg = "I couldn't find relevant information about this in the current chapter. Try rephrasing your question or check if this topic is covered in this chapter."
#                 st.warning(no_info_msg)
#                 st.session_state.messages.append({
#                     "role": "assistant",
#                     "content": no_info_msg,
#                     "context": None
#                 })
#                 st.stop()

#             # 3. Format context
#             context_text = ""
#             context_for_display = ""
            
#             for i, chunk in enumerate(chunks, 1):
#                 # For OpenAI
#                 context_text += f"[Source {i} - Page {chunk['page_number']} - {chunk['content_type']}]\n{chunk['content']}\n\n"
                
#                 # For display
#                 context_piece = f"**Source {i}** (Page {chunk['page_number']}, Type: {chunk['content_type']})\n\n"
#                 context_piece += f"{chunk['content']}\n\n"
                
#                 # Add image link if it's an image description
#                 if chunk['content_type'] == 'image_description' and chunk.get('storage_path'):
#                     try:
#                         img_url = supabase.storage.from_("NCERT Images").get_public_url(chunk['storage_path'])
#                         context_piece += f"[🖼️ View Image]({img_url})\n\n"
#                     except:
#                         pass
                
#                 context_for_display += context_piece + "---\n\n"
            
#             # 4. Get final answer from OpenAI
#             response = get_openai_response(openai_client, prompt, context_text)
            
#             # 5. Display response
#             st.markdown(response)
            
#             with st.expander("📄 View Retrieved Context (click to expand)"):
#                 st.markdown(context_for_display)

#     # Add assistant response to chat history
#     st.session_state.messages.append({
#         "role": "assistant",
#         "content": response,
#         "context": {"text": context_for_display}
#     })

# # Footer
# st.sidebar.divider()
# st.sidebar.caption("💡 Tip: Ask specific questions for best results!")
# st.sidebar.caption(f"📊 Chat messages: {len(st.session_state.messages)}")











# import streamlit as st
# import re
# import os
# from pathlib import Path
# import dotenv
# from typing import List
# from supabase import create_client, Client
# from sentence_transformers import SentenceTransformer
# from openai import OpenAI

# os.environ["TOKENIZERS_PARALLELISM"] = "false"

# env_path = Path(__file__).parent.parent / ".env"
# dotenv.load_dotenv(env_path)

# # --- CONFIGURATION ---
# BGE_MODEL_NAME = "BAAI/bge-m3"
# OPENAI_MODEL = "gpt-4o-mini"
# MATCH_THRESHOLD = 0.5
# MATCH_COUNT = 15

# # --- INITIALIZATION ---

# @st.cache_resource
# def init_supabase() -> Client:
#     url = os.getenv("SUPABASE_URL")
#     key = os.getenv("SUPABASE_SERVICE_KEY")
#     if not url or not key:
#         st.error("Missing SUPABASE_URL or SUPABASE_SERVICE_KEY")
#         st.stop()
#     return create_client(url, key)

# @st.cache_resource
# def load_embedding_model() -> SentenceTransformer:
#     with st.spinner("Loading embedding model (bge-m3)..."):
#         model = SentenceTransformer(BGE_MODEL_NAME)
#     return model

# def standardize_query_with_llm(client: OpenAI, query: str) -> str:
#     """
#     Uses LLM to standardize the query to English for better retrieval.
#     Handles Hinglish, transliteration, and vague phrasing.
#     """
#     system_prompt = """You are a query pre-processor for an NCERT textbook search engine.
#     Your task is to convert the user's query into a precise, keyword-rich English search query.
    
#     Rules:
#     1. Translate Hinglish/Hindi/Urdu to English.
#     2. Convert number words to digits (e.g., "page teen" -> "page 3").
#     3. Keep specific terminology (like "monohybrid cross") intact.
#     4. If the user asks for a specific page, ensure the format "page X" is present.
#     5. Output ONLY the standardized query, nothing else.
#     """
    
#     try:
#         response = client.chat.completions.create(
#             model="gpt-4o-mini",
#             messages=[
#                 {"role": "system", "content": system_prompt},
#                 {"role": "user", "content": query}
#             ],
#             temperature=0,
#             max_tokens=50
#         )
#         return response.choices[0].message.content.strip()
#     except Exception as e:
#         return query # Fallback to original

# @st.cache_data
# def load_books_and_chapters(_supabase: Client) -> dict:
#     with st.spinner("Fetching books and chapters..."):
#         try:
#             books_res = _supabase.table("books").select("id, title").eq("class", 10).execute()
#             chapters_res = _supabase.table("chapters").select("id, title, book_id").eq("embedding_status", "completed").execute()

#             books_data = {}
#             for book in books_res.data:
#                 books_data[book['id']] = {"name": book['title'], "chapters": []}
            
#             for chapter in chapters_res.data:
#                 if chapter['book_id'] in books_data:
#                     books_data[chapter['book_id']]['chapters'].append({
#                         "id": chapter['id'],
#                         "title": chapter['title']
#                     })
            
#             return {book_id: data for book_id, data in books_data.items() if data['chapters']}
#         except Exception as e:
#             st.error(f"Error fetching data: {e}")
#             return {}

# # --- SMART RETRIEVAL FUNCTIONS ---

# def parse_query_intent(query: str) -> dict:
#     """Enhanced query parser with better page number and questions detection."""
#     query_lower = query.lower()
#     intent = {
#         'type': 'general',
#         'page_number': None,
#         'figure_ref': None,
#         'location_keywords': [],
#         'box_keywords': [],
#         'content_type_filter': None
#     }
    
#     # Page number - handle multiple patterns
#     page_patterns = [
#         r'page\s+(\d+)',
#         r'pg\s+(\d+)', 
#         r'p\.\s*(\d+)',
#         r'on\s+(\d+)',  # "questions on 164"
#     ]
    
#     for pattern in page_patterns:
#         page_match = re.search(pattern, query_lower)
#         if page_match:
#             intent['page_number'] = int(page_match.group(1))
#             intent['type'] = 'page_location'
#             break
    
#     # Detect if asking about questions specifically
#     if re.search(r'\bquestions?\b', query_lower):
#         intent['box_keywords'].append('questions')
#         intent['content_type_filter'] = 'questions_section'
    
#     # Figure/activity reference
#     fig_patterns = [
#         r'(figure|fig\.?|activity|table|diagram)\s*(\d+)[\.\-\s]*(\d+)',
#         r'(figure|fig|activity|table)(\d+)[\.\-](\d+)',
#     ]
    
#     for pattern in fig_patterns:
#         match = re.search(pattern, query_lower)
#         if match:
#             intent['type'] = 'figure_reference'
#             intent['figure_ref'] = {
#                 'type': match.group(1).replace('.', ''),
#                 'number': f"{match.group(2)}.{match.group(3)}"
#             }
#             break
    
#     # Location keywords
#     for word in ['top', 'bottom', 'left', 'right', 'corner', 'side']:
#         if word in query_lower:
#             intent['location_keywords'].append(word)
    
#     # Box keywords
#     for word in ['box', 'orange', 'colored', 'activity', 'biography', 'questions']:
#         if word in query_lower:
#             intent['box_keywords'].append(word)
    
#     return intent

# def find_relevant_chunks(supabase: Client, chapter_id: str, query_embedding: List[float], query_text: str) -> List[dict]:
#     """Smart multi-strategy retrieval with proper page filtering."""
    
#     intent = parse_query_intent(query_text)
#     all_chunks = {}
    
#     # STRATEGY 1: PAGE-SPECIFIC DIRECT SEARCH (NEW - HIGHEST PRIORITY)
#     if intent['page_number']:
#         try:
#             query_builder = supabase.table("chapter_embeddings") \
#                 .select("id, content, page_number, content_type, storage_path") \
#                 .eq("chapter_id", chapter_id) \
#                 .eq("page_number", intent['page_number'])
            
#             # Filter by content type
#             if 'questions' in intent['box_keywords']:
#                 query_builder = query_builder.or_(
#                     "content.ilike.%[BOX_TYPE: Questions]%,"
#                     "content.ilike.%QUESTIONS%,"
#                     "content.ilike.%Q U E S T I O N S%"
#                 )
#             elif intent['box_keywords']:
#                 if 'biography' in intent['box_keywords']:
#                     query_builder = query_builder.ilike("content", "%Biography%")
#                 elif 'activity' in intent['box_keywords']:
#                     query_builder = query_builder.ilike("content", "%Activity%")
#                 else:
#                     query_builder = query_builder.ilike("content", "%[BOX_TYPE:%")
            
#             response = query_builder.limit(20).execute()
            
#             if response.data:
#                 for chunk in response.data:
#                     score = 0.9
#                     if 'questions' in intent['box_keywords']:
#                         if any(m in chunk['content'].upper() for m in ['QUESTIONS', 'Q U E S T I O N S']):
#                             score = 1.0
                    
#                     all_chunks[chunk['id']] = {
#                         **chunk,
#                         'similarity': score,
#                         'match_type': 'page_specific_match'
#                     }
#         except Exception as e:
#             st.warning(f"Page search error: {e}")
    
#     # STRATEGY 2: EXACT METADATA SEARCH (for figures)
#     if intent['type'] == 'figure_reference' and intent['figure_ref']:
#         fig_ref = intent['figure_ref']
#         patterns = [
#             f"%[REFERENCES:%{fig_ref['type']}%{fig_ref['number']}%",
#             f"%[SEARCHABLE_TAGS:%{fig_ref['type']} {fig_ref['number']}%",
#             f"%{fig_ref['type']} {fig_ref['number']}%"
#         ]
        
#         for pattern in patterns:
#             try:
#                 response = supabase.table("chapter_embeddings") \
#                     .select("id, content, page_number, content_type, storage_path") \
#                     .eq("chapter_id", chapter_id) \
#                     .ilike("content", pattern) \
#                     .limit(5) \
#                     .execute()
                
#                 if response.data:
#                     for chunk in response.data:
#                         all_chunks[chunk['id']] = {
#                             **chunk,
#                             'similarity': 1.0,
#                             'match_type': 'exact_figure_match'
#                         }
#                     break
#             except Exception as e:
#                 st.warning(f"Metadata search error: {e}")
#     # STRATEGY 2: PAGE + LOCATION SEARCH (legacy - now handled by STRATEGY 1)
#     # Skip this if we already found results in STRATEGY 1
    
#     # STRATEGY 3: VECTOR SEARCH
#     if len(all_chunks) < 5 or intent['type'] == 'general':
#         try:
#             threshold = 0.3 if intent['type'] in ['figure_reference', 'page_location'] else MATCH_THRESHOLD
            
#             response_vector = supabase.rpc("match_embeddings_for_chapter", {
#                 "query_embedding": query_embedding,
#                 "p_chapter_id": chapter_id,
#                 "match_threshold": threshold,
#                 "match_count": MATCH_COUNT * 2,
#                 "page_filter": None
#             }).execute()

#             if response_vector.data:
#                 # Manually filter by page if specified
#                 filtered_results = response_vector.data
#                 if intent['page_number']:
#                     filtered_results = [c for c in response_vector.data if c.get('page_number') == intent['page_number']]
                
#                 for chunk in filtered_results:
#                     if chunk['id'] not in all_chunks:
#                         all_chunks[chunk['id']] = {
#                             **chunk,
#                             'match_type': 'vector_search'
#                         }
#         except Exception as e:
#             st.error(f"Vector search error: {e}")
    
#     # STRATEGY 4: KEYWORD FALLBACK
#     # STRATEGY 4: KEYWORD FALLBACK
#     if len(all_chunks) < 5:
#         keywords = [w for w in re.findall(r'\b[a-zA-Z]{4,}\b', query_text.lower()) 
#                    if w not in {'what', 'where', 'when', 'explain', 'about', 'tell', 'page'}]
        
#         for keyword in keywords[:2]:
#             try:
#                 query_builder = supabase.table("chapter_embeddings") \
#                     .select("id, content, page_number, content_type, storage_path") \
#                     .eq("chapter_id", chapter_id) \
#                     .ilike("content", f"%{keyword}%") \
#                     .limit(5)
                
#                 # Apply page filter if specified
#                 if intent['page_number']:
#                     query_builder = query_builder.eq("page_number", intent['page_number'])
                
#                 response = query_builder.execute()
                
#                 if response.data:
#                     for chunk in response.data:
#                         if chunk['id'] not in all_chunks:
#                             all_chunks[chunk['id']] = {
#                                 **chunk,
#                                 'similarity': 0.6,
#                                 'match_type': 'keyword_fallback'
#                             }
#             except:
#                 continue
    
#     # SORT AND RETURN
#     if not all_chunks:
#         return []
    
#     final_chunks = list(all_chunks.values())
    
#     def sort_key(chunk):
#         priority_map = {
#             'page_specific_match': 0,      # NEW: Highest priority
#             'exact_figure_match': 1,
#             'vector_search': 2,
#             'keyword_fallback': 3
#         }
#         priority = priority_map.get(chunk.get('match_type'), 99)
#         similarity = chunk.get('similarity', 0)
#         return (priority, -similarity)
    
#     final_chunks.sort(key=sort_key)
#     return final_chunks[:MATCH_COUNT]

# def get_query_embedding(model: SentenceTransformer, query: str) -> List[float]:
#     return model.encode(query, normalize_embeddings=True).tolist()

# def get_openai_response(client: OpenAI, prompt: str, context: str, query_intent: dict) -> str:
#     system_prompt = """You are an expert NCERT textbook assistant helping students learn.

# **Your Rules:**
# 1. Answer ONLY based on the provided context from the textbook.
# 2. **IMPORTANT**: The context may contain Hindi text encoded in legacy fonts (like Kruti Dev) which appears as random English characters (e.g., 'ml fnu osQ', ';g irk', 'IkQkjlh'). If you encounter such text, TREAT IT AS HINDI, decode it contextually, and use it to answer the question.
# 3. Pay special attention to structured tags:
#    - [BOX_TYPE: ...] and [BOX_TITLE: ...] (colored boxes like Activity or Biography)
#    - [METADATA: Page X] (page information)
#    - [NEARBY_TEXT] and [BOX_CONTENT] (surrounding context)
#    - [IMAGE_DESCRIPTION] (what the image shows)
# 4. Be clear, accurate, and educational.
# 5. If the answer is not in the context, say: "I don't have information about this in the current chapter."
# 6. Use the same language as the question.
# 7. Keep answers concise (2-4 paragraphs max).

# **Response Format:**
# - Start with a direct answer
# - Support with details from the context
# - Mention page numbers or figures if relevant"""
    
#     if query_intent['type'] == 'page_location':
#         user_message = f"""**Context from NCERT Textbook:**

# {context}

# ---

# **Student's Question:**
# {prompt}

# **Note:** This asks about a specific page location. Look for [BOX_TYPE:], [BOX_TITLE:], and [VISUAL_POSITION:] tags to identify what's there."""
#     else:
#         user_message = f"""**Context from NCERT Textbook:**

# {context}

# ---

# **Student's Question:**
# {prompt}

# Answer using only the information provided above."""
    
#     try:
#         response = client.chat.completions.create(
#             model=OPENAI_MODEL,
#             messages=[
#                 {"role": "system", "content": system_prompt},
#                 {"role": "user", "content": user_message}
#             ],
#             temperature=0.2,
#             max_tokens=800
#         )
#         return response.choices[0].message.content
#     except Exception as e:
#         st.error(f"OpenAI API error: {e}")
#         return "Sorry, I couldn't get an answer from the AI model."

# # --- STREAMLIT UI ---

# st.set_page_config(layout="wide", page_title="NCERT RAG Chatbot", page_icon="📚")

# supabase = init_supabase()
# embed_model = load_embedding_model()
# books_data = load_books_and_chapters(supabase)

# # SIDEBAR
# with st.sidebar:
#     st.title("⚙️ Configuration")
    
#     openai_key_available = bool(os.getenv("OPENAI_API_KEY"))
#     if not openai_key_available:
#         st.warning("⚠️ Set OPENAI_API_KEY in .env")
#     else:
#         st.success("✅ OpenAI API Key loaded")
    
#     st.divider()
    
#     if not books_data:
#         st.error("No books with completed chapters found!")
#         st.stop()
    
#     book_name_to_id = {data['name']: book_id for book_id, data in books_data.items()}
#     selected_book_name = st.selectbox("📖 Choose a Book", list(book_name_to_id.keys()))
    
#     selected_book_id = None
#     selected_chapter_id = None
#     selected_chapter_name = None
    
#     if selected_book_name:
#         selected_book_id = book_name_to_id[selected_book_name]
#         chapters_in_book = books_data[selected_book_id]['chapters']
        
#         if not chapters_in_book:
#             st.warning("No completed chapters")
#             st.stop()
        
#         chapter_name_to_id = {chap['title']: chap['id'] for chap in chapters_in_book}
#         selected_chapter_name = st.selectbox("📑 Choose a Chapter", list(chapter_name_to_id.keys()))
        
#         if selected_chapter_name:
#             selected_chapter_id = chapter_name_to_id[selected_chapter_name]
#             st.success("✅ Ready to chat!")
    
#     st.divider()
    
#     with st.expander("🔧 Advanced Settings"):
#         st.caption(f"Match Threshold: {MATCH_THRESHOLD}")
#         st.caption(f"Retrieved Chunks: {MATCH_COUNT}")
#         st.caption(f"Model: {OPENAI_MODEL}")

# # MAIN CHAT
# st.title("📚 Studious NCERT Chatbot")

# if not selected_chapter_name:
#     st.info("👈 Please choose a book and chapter from the sidebar to begin.")
#     st.stop()

# st.subheader(f"💬 {selected_book_name} - {selected_chapter_name}")

# if "messages" not in st.session_state:
#     st.session_state.messages = []

# # Display chat history
# for message in st.session_state.messages:
#     with st.chat_message(message["role"]):
#         st.markdown(message["content"])
#         if "context" in message and message["context"]:
#             with st.expander("📄 View Retrieved Context"):
#                 st.markdown(message["context"]["text"])

# # Chat input
# if prompt := st.chat_input("Ask a question about this chapter..."):
    
#     openai_key = os.getenv("OPENAI_API_KEY")
#     if not openai_key:
#         st.error("❌ OPENAI_API_KEY not set")
#         st.stop()
    
#     openai_client = OpenAI(api_key=openai_key)
    
#     st.session_state.messages.append({"role": "user", "content": prompt})
#     with st.chat_message("user"):
#         st.markdown(prompt)

#     # RAG PIPELINE
#     with st.chat_message("assistant"):
#         with st.spinner("🔍 Searching textbook... 🤔 Thinking..."):
            
#             # 0. Standardize Query (Handle Hinglish/Transliteration)
#             search_query = standardize_query_with_llm(openai_client, prompt)
#             if search_query.lower() != prompt.lower():
#                 st.caption(f"Translated for search: *{search_query}*")
            
#             # Analyze query intent
#             intent = parse_query_intent(search_query)
            
#             # Get embedding from ORIGINAL query (to leverage bge-m3's multilingual capabilities)
#             # This allows matching "page 3 par prashn..." (Hindi) to content, 
#             # while 'search_query' (English) is used for intent parsing and keyword fallback.
#             query_embedding = get_query_embedding(embed_model, prompt)
            
#             # Find chunks with smart retrieval
#             chunks = find_relevant_chunks(supabase, selected_chapter_id, query_embedding, search_query)
            
#             if not chunks:
#                 no_info_msg = "I couldn't find relevant information about this in the current chapter. Try rephrasing your question."
#                 st.warning(no_info_msg)
#                 st.session_state.messages.append({
#                     "role": "assistant",
#                     "content": no_info_msg,
#                     "context": None
#                 })
#                 st.stop()

#             # Format context
#             context_text = ""
#             context_for_display = ""
            
#             for i, chunk in enumerate(chunks, 1):
#                 context_text += f"[Source {i} - Page {chunk['page_number']} - {chunk['content_type']}]\n{chunk['content']}\n\n"
                
#                 context_piece = f"**Source {i}** (Page {chunk['page_number']}, Type: {chunk['content_type']}, Match: {chunk.get('match_type', 'N/A')})\n\n"
#                 context_piece += f"{chunk['content'][:300]}...\n\n"
                
#                 if chunk['content_type'] == 'image_description' and chunk.get('storage_path'):
#                     try:
#                         img_url = supabase.storage.from_("NCERT Images").get_public_url(chunk['storage_path'])
#                         context_piece += f"[🖼️ View Image]({img_url})\n\n"
#                     except:
#                         pass
                
#                 context_for_display += context_piece + "---\n\n"
            
#             # Get final answer
#             response = get_openai_response(openai_client, prompt, context_text, intent)
            
#             # Display
#             st.markdown(response)
            
#             with st.expander("📄 View Retrieved Context (click to expand)"):
#                 st.markdown(context_for_display)
                
#                 # Debug info
#                 st.divider()
#                 st.caption(f"Query Intent: {intent['type']}")
#                 if intent['page_number']:
#                     st.caption(f"Page Filter: {intent['page_number']}")
#                 if intent['figure_ref']:
#                     st.caption(f"Figure: {intent['figure_ref']}")

#     st.session_state.messages.append({
#         "role": "assistant",
#         "content": response,
#         "context": {"text": context_for_display}
#     })

# # Footer
# st.sidebar.divider()
# st.sidebar.caption("💡 Tip: Be specific! Try 'what's in the orange box on page 130?'")
# st.sidebar.caption(f"📊 Chat messages: {len(st.session_state.messages)}")










import streamlit as st
import re
import os
from pathlib import Path
import dotenv
from typing import List
from supabase import create_client, Client
from sentence_transformers import SentenceTransformer
from openai import OpenAI

os.environ["TOKENIZERS_PARALLELISM"] = "false"

env_path = Path(__file__).parent.parent / ".env"
dotenv.load_dotenv(env_path)

# --- CONFIGURATION ---
BGE_MODEL_NAME = "BAAI/bge-m3"
OPENAI_MODEL = "gpt-4o-mini"
MATCH_THRESHOLD = 0.5
MATCH_COUNT = 15

# --- INITIALIZATION ---

@st.cache_resource
def init_supabase() -> Client:
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_SERVICE_KEY")
    if not url or not key:
        st.error("Missing SUPABASE_URL or SUPABASE_SERVICE_KEY")
        st.stop()
    return create_client(url, key)

@st.cache_resource
def load_embedding_model() -> SentenceTransformer:
    with st.spinner("Loading embedding model (bge-m3)..."):
        model = SentenceTransformer(BGE_MODEL_NAME)
    return model

def standardize_query_with_llm(client: OpenAI, query: str) -> str:
    """
    Uses LLM to standardize the query to English for better retrieval.
    Handles Hinglish, transliteration, and vague phrasing.
    """
    system_prompt = """You are a query pre-processor for an NCERT textbook search engine.
    Your task is to convert the user's query into a precise, keyword-rich English search query.
    
    Rules:
    1. Translate Hinglish/Hindi/Urdu to English.
    2. Convert number words to digits (e.g., "page teen" -> "page 3").
    3. Keep specific terminology (like "monohybrid cross") intact.
    4. If the user asks for a specific page, ensure the format "page X" is present.
    5. Output ONLY the standardized query, nothing else.
    """
    
    try:
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": query}
            ],
            temperature=0,
            max_tokens=50
        )
        return response.choices[0].message.content.strip()
    except Exception as e:
        return query  # Fallback to original

@st.cache_data
def load_books_and_chapters(_supabase: Client) -> dict:
    with st.spinner("Fetching books and chapters..."):
        try:
            books_res = _supabase.table("books").select("id, title").eq("class", 10).execute()
            chapters_res = _supabase.table("chapters").select("id, title, book_id").eq("embedding_status", "completed").execute()

            books_data = {}
            for book in books_res.data:
                books_data[book['id']] = {"name": book['title'], "chapters": []}
            
            for chapter in chapters_res.data:
                if chapter['book_id'] in books_data:
                    books_data[chapter['book_id']]['chapters'].append({
                        "id": chapter['id'],
                        "title": chapter['title']
                    })
            
            return {book_id: data for book_id, data in books_data.items() if data['chapters']}
        except Exception as e:
            st.error(f"Error fetching data: {e}")
            return {}

# --- SMART RETRIEVAL FUNCTIONS ---

def parse_query_intent(query: str) -> dict:
    """Enhanced query parser with section detection."""
    query_lower = query.lower()
    intent = {
        'type': 'general',
        'page_number': None,
        'figure_ref': None,
        'location_keywords': [],
        'box_keywords': [],
        'content_type_filter': None,
        'section_name': None  # NEW
    }
    
    # Page number
    page_patterns = [
        r'page\s+(\d+)',
        r'pg\s+(\d+)', 
        r'p\.\s*(\d+)',
        r'on\s+(\d+)',
    ]
    
    for pattern in page_patterns:
        page_match = re.search(pattern, query_lower)
        if page_match:
            intent['page_number'] = int(page_match.group(1))
            intent['type'] = 'page_location'
            break
    
    # NEW: Detect section queries
    section_patterns = {
        'what you have learnt': r'what\s+you\s+have\s+learnt?',
        'exercises': r'exercises?|E\s*X\s*E\s*R\s*C\s*I\s*S\s*E\s*S',
        'questions': r'questions?|Q\s*U\s*E\s*S\s*T\s*I\s*O\s*N\s*S',
        'think it over': r'think\s+it\s+over',
        'summary': r'summary'
    }
    
    for section_name, pattern in section_patterns.items():
        if re.search(pattern, query_lower):
            intent['section_name'] = section_name
            intent['type'] = 'section_query'
            break
    
    # Questions detection
    if re.search(r'\bquestions?\b', query_lower):
        intent['box_keywords'].append('questions')
        if not intent['section_name']:
            intent['section_name'] = 'questions'
    
    # Exercises detection  
    if re.search(r'\bexercises?\b', query_lower):
        intent['box_keywords'].append('exercises')
        if not intent['section_name']:
            intent['section_name'] = 'exercises'
    
    # Figure/activity reference
    fig_patterns = [
        r'(figure|fig\.?|activity|table|diagram)\s*(\d+)[\.\-\s]*(\d+)',
        r'(figure|fig|activity|table)(\d+)[\.\-](\d+)',
    ]
    
    for pattern in fig_patterns:
        match = re.search(pattern, query_lower)
        if match:
            intent['type'] = 'figure_reference'
            intent['figure_ref'] = {
                'type': match.group(1).replace('.', ''),
                'number': f"{match.group(2)}.{match.group(3)}"
            }
            break
    
    # Location keywords
    for word in ['top', 'bottom', 'left', 'right', 'corner', 'side']:
        if word in query_lower:
            intent['location_keywords'].append(word)
    
    # Box keywords
    for word in ['box', 'orange', 'colored', 'activity', 'biography', 'questions']:
        if word in query_lower:
            intent['box_keywords'].append(word)
    
    return intent

def find_relevant_chunks(supabase: Client, chapter_id: str, query_embedding: List[float], 
                         query_text: str, original_query: str = None) -> List[dict]:
    """
    Smart multi-strategy retrieval with proper cross-lingual support.
    
    Args:
        query_embedding: Embedding of the ORIGINAL user query (not translated)
        query_text: Standardized English query (for keyword fallback only)
        original_query: The actual user input (for display/logging)
    """
    
    intent = parse_query_intent(query_text)
    all_chunks = {}
    
    # STRATEGY 1: PAGE-SPECIFIC OR SECTION-SPECIFIC SEARCH
    if intent['page_number'] or intent['section_name']:
        try:
            query_builder = supabase.table("chapter_embeddings") \
                .select("id, content, page_number, content_type, storage_path") \
                .eq("chapter_id", chapter_id)
            
            # Apply page filter if specified
            if intent['page_number']:
                query_builder = query_builder.eq("page_number", intent['page_number'])
            
            # Apply section filter if specified
            if intent['section_name']:
                section_pattern = f"%[SECTION: %{intent['section_name']}%]%"
                query_builder = query_builder.ilike("content", section_pattern)
            
            # Also check for box-type questions/exercises
            elif 'questions' in intent['box_keywords']:
                query_builder = query_builder.or_(
                    "content.ilike.%[SECTION: Questions]%,"
                    "content.ilike.%[SECTION: QUESTIONS]%,"
                    "content.ilike.%[BOX_TYPE: Questions]%"
                )
            
            elif 'exercises' in intent['box_keywords']:
                query_builder = query_builder.or_(
                    "content.ilike.%[SECTION: Exercises]%,"
                    "content.ilike.%[SECTION: EXERCISES]%"
                )
            
            response = query_builder.limit(20).execute()
            
            if response.data:
                for chunk in response.data:
                    score = 1.0 if intent['section_name'] else 0.9
                    all_chunks[chunk['id']] = {
                        **chunk,
                        'similarity': score,
                        'match_type': 'section_match' if intent['section_name'] else 'page_specific_match'
                    }
        except Exception as e:
            st.warning(f"Section/page search error: {e}")
    
    # STRATEGY 2: EXACT METADATA SEARCH (for figures)
    if intent['type'] == 'figure_reference' and intent['figure_ref']:
        fig_ref = intent['figure_ref']
        patterns = [
            f"%[REFERENCES:%{fig_ref['type']}%{fig_ref['number']}%",
            f"%[SEARCHABLE_TAGS:%{fig_ref['type']} {fig_ref['number']}%",
            f"%{fig_ref['type']} {fig_ref['number']}%"
        ]
        
        for pattern in patterns:
            try:
                response = supabase.table("chapter_embeddings") \
                    .select("id, content, page_number, content_type, storage_path") \
                    .eq("chapter_id", chapter_id) \
                    .ilike("content", pattern) \
                    .limit(5) \
                    .execute()
                
                if response.data:
                    for chunk in response.data:
                        all_chunks[chunk['id']] = {
                            **chunk,
                            'similarity': 1.0,
                            'match_type': 'exact_figure_match'
                        }
                    break
            except Exception as e:
                st.warning(f"Metadata search error: {e}")
    
    # STRATEGY 3: VECTOR SEARCH (CROSS-LINGUAL via BGE-M3)
    # This is where the magic happens - query_embedding is from the ORIGINAL query
    if len(all_chunks) < 5 or intent['type'] == 'general':
        try:
            # Detect if query is non-English and adjust threshold
            threshold = MATCH_THRESHOLD
            if original_query and not original_query.isascii():
                threshold = MATCH_THRESHOLD * 0.8  # More lenient for non-English
            elif intent['type'] in ['figure_reference', 'page_location']:
                threshold = 0.3
            
            response_vector = supabase.rpc("match_embeddings_for_chapter", {
                "query_embedding": query_embedding,  # Original multilingual embedding
                "p_chapter_id": chapter_id,
                "match_threshold": threshold,
                "match_count": MATCH_COUNT * 2,
                "page_filter": None
            }).execute()

            if response_vector.data:
                filtered_results = response_vector.data
                if intent['page_number']:
                    filtered_results = [c for c in response_vector.data 
                                       if c.get('page_number') == intent['page_number']]
                
                for chunk in filtered_results:
                    if chunk['id'] not in all_chunks:
                        all_chunks[chunk['id']] = {
                            **chunk,
                            'match_type': 'vector_search'
                        }
        except Exception as e:
            st.error(f"Vector search error: {e}")
    
    # STRATEGY 4: KEYWORD FALLBACK (uses standardized English query)
    # This is now the ONLY place we use the translated query
    if len(all_chunks) < 5:
        # Extract keywords from the STANDARDIZED query
        keywords = [w for w in re.findall(r'\b[a-zA-Z]{4,}\b', query_text.lower()) 
                   if w not in {'what', 'where', 'when', 'explain', 'about', 'tell', 'page'}]
        
        for keyword in keywords[:2]:
            try:
                query_builder = supabase.table("chapter_embeddings") \
                    .select("id, content, page_number, content_type, storage_path") \
                    .eq("chapter_id", chapter_id) \
                    .ilike("content", f"%{keyword}%") \
                    .limit(5)
                
                if intent['page_number']:
                    query_builder = query_builder.eq("page_number", intent['page_number'])
                
                response = query_builder.execute()
                
                if response.data:
                    for chunk in response.data:
                        if chunk['id'] not in all_chunks:
                            all_chunks[chunk['id']] = {
                                **chunk,
                                'similarity': 0.6,
                                'match_type': 'keyword_fallback'
                            }
            except:
                continue
    
    # SORT AND RETURN
    if not all_chunks:
        return []
    
    final_chunks = list(all_chunks.values())
    
    def sort_key(chunk):
        priority_map = {
            'section_match': 0,            # NEW: Highest for section queries
            'page_specific_match': 1,      
            'exact_figure_match': 2,
            'vector_search': 3,
            'keyword_fallback': 4
        }
        priority = priority_map.get(chunk.get('match_type'), 99)
        similarity = chunk.get('similarity', 0)
        return (priority, -similarity)
    
    final_chunks.sort(key=sort_key)
    return final_chunks[:MATCH_COUNT]

def get_query_embedding(model: SentenceTransformer, query: str) -> List[float]:
    return model.encode(query, normalize_embeddings=True).tolist()

def get_openai_response(client: OpenAI, prompt: str, context: str, query_intent: dict) -> str:
    system_prompt = """You are an expert NCERT textbook assistant helping students learn.

**Your Rules:**
1. Answer ONLY based on the provided context from the textbook.
2. **IMPORTANT**: The context may contain Hindi text encoded in legacy fonts (like Kruti Dev) which appears as random English characters (e.g., 'ml fnu osQ', ';g irk', 'IkQkjlh'). If you encounter such text, TREAT IT AS HINDI, decode it contextually, and use it to answer the question.
3. Pay special attention to structured tags:
   - [BOX_TYPE: ...] and [BOX_TITLE: ...] (colored boxes like Activity or Biography)
   - [METADATA: Page X] (page information)
   - [NEARBY_TEXT] and [BOX_CONTENT] (surrounding context)
   - [IMAGE_DESCRIPTION] (what the image shows)
4. Be clear, accurate, and educational.
5. If the answer is not in the context, say: "I don't have information about this in the current chapter."
6. Use the same language as the question.
7. Keep answers concise (2-4 paragraphs max).

**Response Format:**
- Start with a direct answer
- Support with details from the context
- Mention page numbers or figures if relevant"""
    
    if query_intent['type'] == 'page_location':
        user_message = f"""**Context from NCERT Textbook:**

{context}

---

**Student's Question:**
{prompt}

**Note:** This asks about a specific page location. Look for [BOX_TYPE:], [BOX_TITLE:], and [VISUAL_POSITION:] tags to identify what's there."""
    else:
        user_message = f"""**Context from NCERT Textbook:**

{context}

---

**Student's Question:**
{prompt}

Answer using only the information provided above."""
    
    try:
        response = client.chat.completions.create(
            model=OPENAI_MODEL,
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_message}
            ],
            temperature=0.2,
            max_tokens=800
        )
        return response.choices[0].message.content
    except Exception as e:
        st.error(f"OpenAI API error: {e}")
        return "Sorry, I couldn't get an answer from the AI model."

# --- STREAMLIT UI ---

st.set_page_config(layout="wide", page_title="NCERT RAG Chatbot", page_icon="📚")

supabase = init_supabase()
embed_model = load_embedding_model()
books_data = load_books_and_chapters(supabase)

# SIDEBAR
with st.sidebar:
    st.title("⚙️ Configuration")
    
    openai_key_available = bool(os.getenv("OPENAI_API_KEY"))
    if not openai_key_available:
        st.warning("⚠️ Set OPENAI_API_KEY in .env")
    else:
        st.success("✅ OpenAI API Key loaded")
    
    st.divider()
    
    if not books_data:
        st.error("No books with completed chapters found!")
        st.stop()
    
    book_name_to_id = {data['name']: book_id for book_id, data in books_data.items()}
    selected_book_name = st.selectbox("📖 Choose a Book", list(book_name_to_id.keys()))
    
    selected_book_id = None
    selected_chapter_id = None
    selected_chapter_name = None
    
    if selected_book_name:
        selected_book_id = book_name_to_id[selected_book_name]
        chapters_in_book = books_data[selected_book_id]['chapters']
        
        if not chapters_in_book:
            st.warning("No completed chapters")
            st.stop()
        
        chapter_name_to_id = {chap['title']: chap['id'] for chap in chapters_in_book}
        selected_chapter_name = st.selectbox("📑 Choose a Chapter", list(chapter_name_to_id.keys()))
        
        if selected_chapter_name:
            selected_chapter_id = chapter_name_to_id[selected_chapter_name]
            st.success("✅ Ready to chat!")
    
    st.divider()
    
    with st.expander("🔧 Advanced Settings"):
        st.caption(f"Match Threshold: {MATCH_THRESHOLD}")
        st.caption(f"Retrieved Chunks: {MATCH_COUNT}")
        st.caption(f"Model: {OPENAI_MODEL}")
        st.caption("🌍 Cross-lingual: BGE-M3")

# MAIN CHAT
st.title("📚 Studious NCERT Chatbot")

if not selected_chapter_name:
    st.info("👈 Please choose a book and chapter from the sidebar to begin.")
    st.stop()

st.subheader(f"💬 {selected_book_name} - {selected_chapter_name}")

if "messages" not in st.session_state:
    st.session_state.messages = []

# Display chat history
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])
        if "context" in message and message["context"]:
            with st.expander("📄 View Retrieved Context"):
                st.markdown(message["context"]["text"])

# Chat input
if prompt := st.chat_input("Ask a question about this chapter..."):
    
    openai_key = os.getenv("OPENAI_API_KEY")
    if not openai_key:
        st.error("⚠️ OPENAI_API_KEY not set")
        st.stop()
    
    openai_client = OpenAI(api_key=openai_key)
    
    st.session_state.messages.append({"role": "user", "content": prompt})
    with st.chat_message("user"):
        st.markdown(prompt)

    # RAG PIPELINE
    with st.chat_message("assistant"):
        with st.spinner("🔍 Searching textbook... 🤔 Thinking..."):
            
            # STEP 1: Standardize query for INTENT PARSING and KEYWORD FALLBACK ONLY
            search_query = standardize_query_with_llm(openai_client, prompt)
            
            # STEP 2: Get embedding from ORIGINAL QUERY (cross-lingual magic!)
            query_embedding = get_query_embedding(embed_model, prompt)  # NOT search_query!
            
            # STEP 3: Parse intent from standardized query
            intent = parse_query_intent(search_query)
            
            # Show translation only if significantly different
            if search_query.lower() != prompt.lower() and len(search_query) < len(prompt) * 1.5:
                st.caption(f"🔍 Understood as: *{search_query}*")
            
            # STEP 4: Find chunks using ORIGINAL embedding + standardized query for fallback
            chunks = find_relevant_chunks(
                supabase, 
                selected_chapter_id, 
                query_embedding,      # Original multilingual embedding
                search_query,         # Standardized English (for keywords)
                original_query=prompt # For threshold adjustment
            )
            
            if not chunks:
                no_info_msg = "I couldn't find relevant information about this in the current chapter. Try rephrasing your question."
                st.warning(no_info_msg)
                st.session_state.messages.append({
                    "role": "assistant",
                    "content": no_info_msg,
                    "context": None
                })
                st.stop()

            # Format context
            context_text = ""
            context_for_display = ""
            
            for i, chunk in enumerate(chunks, 1):
                context_text += f"[Source {i} - Page {chunk['page_number']} - {chunk['content_type']}]\n{chunk['content']}\n\n"
                
                context_piece = f"**Source {i}** (Page {chunk['page_number']}, Type: {chunk['content_type']}, Match: {chunk.get('match_type', 'N/A')})\n\n"
                context_piece += f"{chunk['content'][:300]}...\n\n"
                
                if chunk['content_type'] == 'image_description' and chunk.get('storage_path'):
                    try:
                        img_url = supabase.storage.from_("NCERT Images").get_public_url(chunk['storage_path'])
                        context_piece += f"[🖼️ View Image]({img_url})\n\n"
                    except:
                        pass
                
                context_for_display += context_piece + "---\n\n"
            
            # Get final answer
            response = get_openai_response(openai_client, prompt, context_text, intent)
            
            # Display
            st.markdown(response)
            
            with st.expander("📄 View Retrieved Context (click to expand)"):
                st.markdown(context_for_display)
                
                # Debug info
                st.divider()
                st.caption(f"**Query Intent:** {intent['type']}")
                if intent['page_number']:
                    st.caption(f"**Page Filter:** {intent['page_number']}")
                if intent['figure_ref']:
                    st.caption(f"**Figure:** {intent['figure_ref']}")
                st.caption(f"**Original Query:** {prompt}")
                st.caption(f"**Standardized:** {search_query}")
                if chunks:
                    st.caption(f"**Top Match Similarity:** {chunks[0].get('similarity', 'N/A')}")

    st.session_state.messages.append({
        "role": "assistant",
        "content": response,
        "context": {"text": context_for_display}
    })

# Footer
st.sidebar.divider()
st.sidebar.caption("💡 Tip: Ask in any language - Hindi, English, or Hinglish!")
st.sidebar.caption("🌍 BGE-M3 handles cross-lingual search automatically")
st.sidebar.caption(f"📊 Chat messages: {len(st.session_state.messages)}")