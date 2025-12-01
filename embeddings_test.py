import streamlit as st
import os
from pathlib import Path
import dotenv
from typing import List
from supabase import create_client, Client
from sentence_transformers import SentenceTransformer
from openai import OpenAI
os.environ["TOKENIZERS_PARALLELISM"] = "false"

# Load .env from parent directory (project root)
env_path = Path(__file__).parent.parent / ".env"
dotenv.load_dotenv(env_path)

# --- 1. CONFIGURATION ---
BGE_MODEL_NAME = "BAAI/bge-m3"
OPENAI_MODEL = "gpt-4o-mini"
EMBEDDING_DIM = 1024
MATCH_THRESHOLD = 0.3  # Lowered from 0.5 for better recall
MATCH_COUNT = 8        # Increased from 5 for more context

# --- 2. INITIALIZATION (CACHED) ---

@st.cache_resource
def init_supabase() -> Client:
    """Initialize and return the Supabase client."""
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_SERVICE_KEY")
    if not url or not key:
        st.error("Missing SUPABASE_URL or SUPABASE_SERVICE_KEY in .env file.")
        st.stop()
    return create_client(url, key)

@st.cache_resource
def load_embedding_model() -> SentenceTransformer:
    """Load and cache the BGE-M3 model."""
    with st.spinner("Loading embedding model (bge-m3)..."):
        model = SentenceTransformer(BGE_MODEL_NAME)
    return model

@st.cache_data
def load_books_and_chapters(_supabase: Client) -> dict:
    """Fetch all Class 10 books and their 'completed' chapters."""
    with st.spinner("Fetching books and completed chapters..."):
        try:
            # 1. Fetch Class 10 books
            books_res = _supabase.table("books").select("id, title").eq("class", 10).execute()
            
            # 2. Fetch 'completed' chapters
            chapters_res = _supabase.table("chapters").select("id, title, book_id").eq("embedding_status", "completed").execute()

            # 3. Organize data for dropdowns
            books_data = {}
            for book in books_res.data:
                books_data[book['id']] = {
                    "name": book['title'],
                    "chapters": []
                }
            
            for chapter in chapters_res.data:
                if chapter['book_id'] in books_data:
                    books_data[chapter['book_id']]['chapters'].append({
                        "id": chapter['id'],
                        "title": chapter['title']
                    })
            
            # Filter out books with no completed chapters
            return {book_id: data for book_id, data in books_data.items() if data['chapters']}
            
        except Exception as e:
            st.error(f"Error fetching data: {e}")
            return {}

# --- 3. CORE RAG FUNCTIONS ---

import re

def extract_figure_reference(query: str) -> dict:
    """Extract figure/activity number from query."""
    # Match patterns like: "figure 7.4", "activity 7.1", "diagram 5.2"
    pattern = r'(figure|activity|diagram|table)\s*(\d+)\.(\d+)'
    match = re.search(pattern, query.lower())
    
    if match:
        fig_type = match.group(1)
        chapter_num = int(match.group(2))
        fig_num = int(match.group(3))
        # Rough estimate: assume figures are on page = chapter_num
        # This is a heuristic - adjust based on your textbook structure
        estimated_page = chapter_num
        return {
            'type': fig_type,
            'number': f"{chapter_num}.{fig_num}",
            'estimated_page': estimated_page
        }
    return None

def find_relevant_chunks(supabase: Client, chapter_id: str, query_embedding: List[float], query_text: str) -> List[dict]:
    """Find relevant chunks with figure-aware search."""
    
    fig_ref = extract_figure_reference(query_text)
    
    # Set parameters based on whether a figure was referenced
    if fig_ref:
        search_threshold = 0.2  # Looser threshold for page-specific search
        page_filter_value = fig_ref['estimated_page']
    else:
        search_threshold = MATCH_THRESHOLD
        page_filter_value = None  # <-- This is the crucial fix
    
    # --- Single, unambiguous RPC call ---
    try:
        response = supabase.rpc("match_embeddings_for_chapter", {
            "query_embedding": query_embedding,
            "p_chapter_id": chapter_id,
            "match_threshold": search_threshold,
            "match_count": MATCH_COUNT,
            "page_filter": page_filter_value  # <-- Always pass this parameter
        }).execute()

        if not response.data:
            return []
        
        # If we did a figure search, prioritize images
        if fig_ref:
            image_results = [r for r in response.data if r['content_type'] == 'image_description']
            text_results = [r for r in response.data if r['content_type'] == 'text']
            return image_results + text_results
        
        # Otherwise, return all results
        return response.data

    except Exception as e:
        # Catch the specific error to provide a better message
        if "PGRST203" in str(e):
             st.error(f"DB Error: Ambiguous function call. This is likely a code issue. {e}")
        else:
            st.error(f"Error searching embeddings: {e}")
        return []

def get_query_embedding(model: SentenceTransformer, query: str) -> List[float]:
    """Generate embedding for the user's query."""
    return model.encode(query, normalize_embeddings=True).tolist()

def get_openai_response(client: OpenAI, prompt: str, context: str) -> str:
    """Get a final answer from OpenAI based on the context."""
    
    system_prompt = """You are an expert NCERT textbook assistant helping students learn.

**Your Rules:**
1. Answer ONLY based on the provided context from the textbook
2. If the context contains image descriptions, use them to explain visual concepts
3. Be clear, accurate, and educational in your explanations
4. If the answer is not in the context, say: "I don't have information about this in the current chapter."
5. Use the same language as the question (English/Hindi/etc.)
6. For diagrams/tables mentioned in context, explain them thoroughly
7. Keep answers concise but complete (2-4 paragraphs max)

**Response Format:**
- Start with a direct answer
- Support with details from the context
- If relevant, mention page numbers or figures"""
    
    user_message = f"""**Context from NCERT Textbook:**

{context}

---

**Student's Question:**
{prompt}

Please answer the question using only the information provided in the context above."""
    
    try:
        response = client.chat.completions.create(
            model=OPENAI_MODEL,
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_message}
            ],
            temperature=0.2,  # Slightly higher for more natural responses
            max_tokens=800    # Limit response length
        )
        return response.choices[0].message.content
    except Exception as e:
        st.error(f"Error with OpenAI API: {e}")
        return "Sorry, I couldn't get an answer from the AI model."

# --- 4. STREAMLIT APP UI ---

st.set_page_config(layout="wide", page_title="NCERT RAG Tester", page_icon="📚")

# Initialize clients
supabase = init_supabase()
embed_model = load_embedding_model()
books_data = load_books_and_chapters(supabase)

# --- Sidebar ---
with st.sidebar:
    st.title("⚙️ Configuration")
    
    # Check for API key
    openai_key_available = bool(os.getenv("OPENAI_API_KEY"))
    try:
        if hasattr(st, 'secrets') and "OPENAI_API_KEY" in st.secrets:
            openai_key_available = True
    except:
        pass
    
    if not openai_key_available:
        st.warning("⚠️ Set `OPENAI_API_KEY` in your .env file")
    else:
        st.success("✅ OpenAI API Key loaded")
    
    st.divider()
    
    # 1. Book Selection
    if not books_data:
        st.error("No books with completed chapters found!")
        st.stop()
    
    book_name_to_id = {data['name']: book_id for book_id, data in books_data.items()}
    selected_book_name = st.selectbox(
        "📖 Choose a Book",
        options=list(book_name_to_id.keys())
    )
    
    # 2. Chapter Selection
    selected_book_id = None
    selected_chapter_id = None
    selected_chapter_name = None
    
    if selected_book_name:
        selected_book_id = book_name_to_id[selected_book_name]
        chapters_in_book = books_data[selected_book_id]['chapters']
        
        if not chapters_in_book:
            st.warning("No completed chapters in this book.")
            st.stop()
        
        chapter_name_to_id = {chap['title']: chap['id'] for chap in chapters_in_book}
        
        selected_chapter_name = st.selectbox(
            "📑 Choose a Chapter",
            options=list(chapter_name_to_id.keys())
        )
        
        if selected_chapter_name:
            selected_chapter_id = chapter_name_to_id[selected_chapter_name]
            st.success(f"✓ Ready to chat!")
    
    st.divider()
    
    # Advanced settings
    with st.expander("🔧 Advanced Settings"):
        st.caption(f"Match Threshold: {MATCH_THRESHOLD}")
        st.caption(f"Retrieved Chunks: {MATCH_COUNT}")
        st.caption(f"Model: {OPENAI_MODEL}")

# --- Main Chat ---
st.title("📚 Studious NCERT Chatbot")

if not selected_chapter_name:
    st.info("👈 Please choose a book and chapter from the sidebar to begin.")
    st.stop()

st.subheader(f"💬 {selected_book_name} - {selected_chapter_name}")

# Initialize chat history
if "messages" not in st.session_state:
    st.session_state.messages = []

# Display chat messages from history
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])
        if "context" in message and message["context"]:
            with st.expander("📄 View Retrieved Context"):
                st.markdown(message["context"]["text"])

# React to user input
if prompt := st.chat_input("Ask a question about this chapter..."):
    
    # Check for OpenAI API Key
    openai_key = os.getenv("OPENAI_API_KEY")
    if not openai_key:
        try:
            if hasattr(st, 'secrets') and "OPENAI_API_KEY" in st.secrets:
                openai_key = st.secrets["OPENAI_API_KEY"]
        except:
            pass
    
    if not openai_key:
        st.error("❌ OPENAI_API_KEY is not set. Add it to your .env file.")
        st.stop()
    
    openai_client = OpenAI(api_key=openai_key)
    
    # Add user message to chat history
    st.session_state.messages.append({"role": "user", "content": prompt})
    with st.chat_message("user"):
        st.markdown(prompt)

    # RAG Pipeline
    with st.chat_message("assistant"):
        with st.spinner("🔍 Searching textbook... 🤔 Thinking..."):
            
            # 1. Embed user query
            query_embedding = get_query_embedding(embed_model, prompt)
            
            # 2. Find relevant chunks
            chunks = find_relevant_chunks(supabase, selected_chapter_id, query_embedding, prompt)
            
            if not chunks:
                no_info_msg = "I couldn't find relevant information about this in the current chapter. Try rephrasing your question or check if this topic is covered in this chapter."
                st.warning(no_info_msg)
                st.session_state.messages.append({
                    "role": "assistant",
                    "content": no_info_msg,
                    "context": None
                })
                st.stop()

            # 3. Format context
            context_text = ""
            context_for_display = ""
            
            for i, chunk in enumerate(chunks, 1):
                # For OpenAI
                context_text += f"[Source {i} - Page {chunk['page_number']} - {chunk['content_type']}]\n{chunk['content']}\n\n"
                
                # For display
                context_piece = f"**Source {i}** (Page {chunk['page_number']}, Type: {chunk['content_type']})\n\n"
                context_piece += f"{chunk['content']}\n\n"
                
                # Add image link if it's an image description
                if chunk['content_type'] == 'image_description' and chunk.get('storage_path'):
                    try:
                        img_url = supabase.storage.from_("NCERT Images").get_public_url(chunk['storage_path'])
                        context_piece += f"[🖼️ View Image]({img_url})\n\n"
                    except:
                        pass
                
                context_for_display += context_piece + "---\n\n"
            
            # 4. Get final answer from OpenAI
            response = get_openai_response(openai_client, prompt, context_text)
            
            # 5. Display response
            st.markdown(response)
            
            with st.expander("📄 View Retrieved Context (click to expand)"):
                st.markdown(context_for_display)

    # Add assistant response to chat history
    st.session_state.messages.append({
        "role": "assistant",
        "content": response,
        "context": {"text": context_for_display}
    })

# Footer
st.sidebar.divider()
st.sidebar.caption("💡 Tip: Ask specific questions for best results!")
st.sidebar.caption(f"📊 Chat messages: {len(st.session_state.messages)}")