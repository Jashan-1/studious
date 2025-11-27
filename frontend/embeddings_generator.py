import streamlit as st
import os
import requests
import uuid
import tempfile
from urllib.parse import urljoin
from bs4 import BeautifulSoup
from pathlib import Path
from dotenv import load_dotenv
import re

# Load environment variables from .env file
# Try multiple locations: current dir, parent dir, project root
env_paths = [
    Path(__file__).parent / ".env",  # frontend/.env
    Path(__file__).parent.parent / ".env",  # project root/.env
    Path(__file__).parent.parent / "backend" / ".env",  # backend/.env
]

for env_path in env_paths:
    if env_path.exists():
        load_dotenv(env_path)
        break
else:
    # If no .env found, try default location
    load_dotenv()  # This will look in current working directory

# Database & Storage
from supabase import create_client, Client

# AI & Vector DB
# Note: langchain_pinecone handles Pinecone initialization internally
from langchain_openai import OpenAIEmbeddings
from langchain_community.document_loaders import PyPDFLoader
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_pinecone import PineconeVectorStore

# --- 1. CONFIGURATION ---

# 1.1 Supabase Config
try:
    SUPABASE_URL = os.environ.get("SUPABASE_URL")
    SUPABASE_KEY = os.environ.get("SUPABASE_SERVICE_KEY")
    
    if not SUPABASE_URL or not SUPABASE_KEY:
        st.error("Missing SUPABASE_URL or SUPABASE_SERVICE_KEY in .env file or environment variables.")
        st.stop()
    
    supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)
except Exception as e:
    st.error(f"Failed to initialize Supabase. Error: {e}")
    st.stop()

# 1.2 Pinecone & OpenAI Config
# Make sure these are in your .env or Streamlit secrets
PINECONE_API_KEY = os.environ.get("PINECONE_API_KEY")
OPENAI_API_KEY = os.environ.get("OPENAI_API_KEY")
PINECONE_INDEX_NAME = "ncert-books" # Replace with your actual index name

if not PINECONE_API_KEY or not OPENAI_API_KEY:
    st.error("Missing PINECONE_API_KEY or OPENAI_API_KEY.")
    st.stop()

# Note: Pinecone initialization is handled by langchain_pinecone
# Set environment variable for langchain_pinecone to use
os.environ["PINECONE_API_KEY"] = PINECONE_API_KEY

# Bucket Config
BUCKET_NAME = "NCERT Books" 
st.set_page_config(layout="wide", page_title="NCERT Admin")
st.title("📚 Studious NCERT Embedding Admin")

# --- 2. DATA LOADING FUNCTIONS ---

@st.cache_data(ttl=600)
def load_books():
    try:
        response = supabase.table('books').select('id, title').is_('org_id', 'NULL').execute()
        return response.data
    except Exception as e:
        return []

@st.cache_data(ttl=60)
def load_chapters(book_id: uuid.UUID):
    try:
        response = supabase.table('chapters').select('id, title, embedding_status, storage_path').eq('book_id', book_id).order('chapter_number').execute()
        return response.data
    except Exception as e:
        return []

# --- 3. HELPER FUNCTIONS (The Heavy Lifting) ---

def scrape_and_download_pdf(flipbook_url: str, _chapter_title="") -> tuple[str, bytes]:
    """
    Downloads the PDF whose URL is stored in book-config.js
    (the file linked by the top-left 3rd button “Download PDF”).
    Returns (local_temp_path, file_bytes).
    """
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
        "Referer": "https://epathshala.nic.in/",
    }

    st.write("🔍 Fetching book-config.js …")
    base = flipbook_url.split("?")[0].split("#")[0].rstrip("/")
    if base.endswith("/index.php"):
        base = base.replace("/index.php", "")
    js_url = urljoin(base + "/", "book-config.js")

    try:
        js = requests.get(js_url, headers=headers, timeout=10).text
        m = re.search(r'"pdf"\s*:\s*"([^"]+\.pdf)"', js)
        if not m:
            raise ValueError("bookConfig.pdf not found in JS")
        pdf_path = m.group(1)
        pdf_url = urljoin(js_url, pdf_path)  # absolutise
    except Exception as e:
        st.error(f"❌ Could not retrieve PDF URL from book-config.js: {e}")
        raise

    # quick HEAD check
    r = requests.head(pdf_url, headers=headers, timeout=5)
    if r.status_code != 200 or "application/pdf" not in r.headers.get("Content-Type", ""):
        st.error(f"❌ PDF URL invalid or not a PDF: {pdf_url}")
        raise ValueError("PDF URL validation failed")

    st.success(f"✅ PDF located: {pdf_url}")
    st.write("⬇️ Downloading …")

    # stream download → temp file
    with requests.get(pdf_url, headers=headers, stream=True) as resp:
        resp.raise_for_status()
        with tempfile.NamedTemporaryFile(delete=False, suffix=".pdf") as tmp:
            for chunk in resp.iter_content(chunk_size=8192):
                if chunk:
                    tmp.write(chunk)
            tmp_path = tmp.name

    # read bytes for Supabase upload
    with open(tmp_path, "rb") as f:
        pdf_bytes = f.read()

    return tmp_path, pdf_bytes

def upload_to_supabase(file_content, chapter_id):
    """Uploads bytes to Supabase and returns the path."""
    file_path = f"public/{chapter_id}.pdf"
    supabase.storage.from_(BUCKET_NAME).upload(
        file=file_content,
        path=file_path,
        file_options={"content-type": "application/pdf", "upsert": "true"}
    )
    return file_path

def process_embeddings(local_pdf_path, chapter_id, book_title, chapter_title):
    """Loads PDF, Splits, Embeds, and Upserts to Pinecone."""
    
    # 1. Load PDF
    loader = PyPDFLoader(local_pdf_path)
    docs = loader.load()
    
    # 2. Split Text
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=1000,
        chunk_overlap=200
    )
    splits = text_splitter.split_documents(docs)
    
    # Add metadata to splits
    for split in splits:
        split.metadata["chapter_id"] = str(chapter_id)
        split.metadata["book_title"] = book_title
        split.metadata["chapter_title"] = chapter_title

    st.write(f"Generated {len(splits)} chunks. Generating embeddings...")

    # 3. Embed & Upsert to Pinecone
    embeddings = OpenAIEmbeddings(model="text-embedding-3-small")
    
    # Utilizing LangChain's Pinecone wrapper for ease
    PineconeVectorStore.from_documents(
        documents=splits,
        embedding=embeddings,
        index_name=PINECONE_INDEX_NAME
    )

def cleanup_files(local_path, supabase_path):
    """Deletes local temp file and Supabase storage file."""
    
    # 1. Delete Local
    if os.path.exists(local_path):
        os.remove(local_path)
    
    # 2. Delete from Supabase
    try:
        supabase.storage.from_(BUCKET_NAME).remove([supabase_path])
        st.info("Cleaned up: Removed PDF from Supabase Storage.")
    except Exception as e:
        st.warning(f"Could not delete from Supabase: {e}")

# --- 4. UI LOGIC ---

books = load_books()
if books:
    selected_book_title = st.selectbox("Select a Book", options={b['title']: b['id'] for b in books}.keys())
    selected_book_id = {b['title']: b['id'] for b in books}[selected_book_title]

    chapters = load_chapters(selected_book_id)
    if chapters:
        chapter_map = {c['title']: c for c in chapters}
        selected_chapter = st.selectbox("Select Chapter", options=chapter_map.keys())
        chap_data = chapter_map[selected_chapter]
        
        st.divider()
        st.write(f"**Source URL:** {chap_data['storage_path']}")
        
        if st.button("🚀 Start Full Process (Download -> Embed -> Cleanup)", type="primary"):
            
            progress_bar = st.progress(0)
            status_text = st.empty()
            
            try:
                # --- Step 1: Download ---
                status_text.text("Step 1/4: Scraping & Downloading...")
                # local_path, pdf_bytes = scrape_and_download_pdf(chap_data['storage_path'])
                # Pass the selected_chapter (e.g., "» Chapter 1") so the script can guess "Chapter-1.pdf"
                local_path, pdf_bytes = scrape_and_download_pdf(chap_data['storage_path'], chap_data['title'])
                progress_bar.progress(25)
                
                # --- Step 2: Upload to Supabase ---
                status_text.text("Step 2/4: Uploading to Supabase bucket...")
                sb_path = upload_to_supabase(pdf_bytes, chap_data['id'])
                progress_bar.progress(50)
                
                # --- Step 3: Embed & Pinecone ---
                status_text.text("Step 3/4: Generating Embeddings & Upserting to Pinecone...")
                process_embeddings(
                    local_path=local_path, 
                    chapter_id=chap_data['id'],
                    book_title=selected_book_title,
                    chapter_title=selected_chapter
                )
                
                # Update DB status to completed
                supabase.table('chapters').update({'embedding_status': 'completed'}).eq('id', chap_data['id']).execute()
                progress_bar.progress(75)

                # --- Step 4: Cleanup ---
                status_text.text("Step 4/4: Deleting temporary files...")
                cleanup_files(local_path, sb_path)
                progress_bar.progress(100)
                
                st.success(f"Successfully processed '{selected_chapter}'!")
                st.balloons()
                
            except Exception as e:
                st.error(f"An error occurred: {str(e)}")