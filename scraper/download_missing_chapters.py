import os
import re
import requests
from supabase import create_client, Client
from urllib.parse import urlparse, unquote
import dotenv
dotenv.load_dotenv()    

# --- 1. CONFIGURATION ---
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_SERVICE_KEY")

BUCKET_NAME = "NCERT Books" 

# Setup the requests session
session = requests.Session()
session.headers.update({
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 "
                  "(KHTML, like Gecko) Chrome/124.0 Safari/537.36"
})

# --- 2. HARD-CODED PDF MAPS ---
# As you identified, maps for the 41 problem chapters.
# NOTE: 'jemh1' and 'jesc1' are placeholders. Update them if incorrect.

SAB_RANG_CODES = {
    "Ch_01": "jusr101.pdf", "Ch_02": "jusr102.pdf", "Ch_03": "jusr103.pdf",
    "Ch_04": "jusr104.pdf", "Ch_05": "jusr105.pdf", "Ch_06": "jusr106.pdf",
    "Ch_07": "jusr107.pdf", "Ch_08": "jusr108.pdf", "Ch_09": "jusr109.pdf",
}

NAWA_E_URDU_CODES = {
    "june115": "https://<mirror-site>/...chapter-15.pdf",
    "june116": "https://<mirror-site>/...chapter-16.pdf",
    "june117": "https://<mirror-site>/...chapter-17.pdf",
    "june118": "https://<mirror-site>/...chapter-18.pdf",
    "june119": "https://<mirror-site>/...chapter-19.pdf",
    "june120": "https://<mirror-site>/...chapter-20.pdf",
    "june121": "https://<mirror-site>/...chapter-21.pdf",
    "june122": "https://<mirror-site>/...chapter-22.pdf",
    "june123": "https://<mirror-site>/...chapter-23.pdf",
}

# Assumed: 5018 is Maths (jemh1)
CLASSX_5018_CODES = {
    "Chap-01": "jemh101.pdf", "Chap-02": "jemh102.pdf", "Chap-03": "jemh103.pdf",
    "Chap-04": "jemh104.pdf", "Chap-05": "jemh105.pdf", "Chap-06": "jemh106.pdf",
    "Chap-07": "jemh107.pdf", "Chap-08": "jemh108.pdf",
}

# Assumed: 5019 is Science (jesc1)
CLASSX_5019_CODES = {
    "Chap-01": "jesc101.pdf", "Chap-02": "jesc102.pdf", "Chap-03": "jesc103.pdf",
    "Chap-04": "jesc104.pdf", "Chap-05": "jesc105.pdf", "Chap-06": "jesc106.pdf",
    "Chap-07": "jesc107.pdf", "Chap-08": "jesc108.pdf", "Chap-09": "jesc109.pdf",
    "Chap-10": "jesc110.pdf", "Chap-11": "jesc111.pdf", "Chap-12": "jesc112.pdf",
}
# Note: The 'tiyhwlss101' URLs are still unmapped, as they are a different pattern.
# They will be logged as 'No PDF found by code or custom map'

# --- 3. HELPER FUNCTIONS ---

def derive_ncert_pdf_url_from_code(flipbook_url: str) -> tuple[str | None, str | None]:
    """
    ATTEMPT 1: Tries to derive the NCERT PDF code (e.g., 'jesc107')
    """
    m = re.search(r'/([a-z]{4}\d{3})(?:/index\.html|$)', flipbook_url)
    if not m:
        return None, None
    code = m.group(1)
    filename = f"{code}.pdf"
    pdf_url = f"https://ncert.nic.in/textbook/pdf/{filename}"
    return pdf_url, filename



SAMPLE_BASIC_CODES = {
    "tiyhwlss101": "<<<PUT_CORRECT_PDF_CODE_OR_URL_HERE>>>",
    "tiyhwlss102": "<<<...>>>",
    "tiyhwlss103": "<<<...>>>",
}

def derive_pdf_from_custom_map(flipbook_url: str) -> tuple[str | None, str | None]:
    path = unquote(urlparse(flipbook_url).path)
    query = urlparse(flipbook_url).query
    code = None

    # existing key logic...
    key = path.rsplit("/", 1)[-1]

    if "/5024-Sab Rang Class X/" in path:
        code = SAB_RANG_CODES.get(key)
    elif "/5012-Nawa-e-Urdu/" in path:
        code = NAWA_E_URDU_CODES.get(key)
    elif "/Class X/5018/" in path:
        code = CLASSX_5018_CODES.get(key)
    elif "/Class X/5019/" in path:
        code = CLASSX_5019_CODES.get(key)
    else:
        # handle sample/basic index.php?tra=tiyhwlss10x
        if "tra=" in query:
            from urllib.parse import parse_qs
            tra = parse_qs(query).get("tra", [None])[0]
            if tra:
                code = SAMPLE_BASIC_CODES.get(tra)
                if code and code.startswith("http"):
                    # allow full URL override if you store absolute URLs
                    return code, os.path.basename(urlparse(code).path)

    if not code:
        return None, None

    if code.startswith("http"):
        pdf_url = code
        filename = os.path.basename(urlparse(pdf_url).path)
    else:
        pdf_url = f"https://ncert.nic.in/textbook/pdf/{code}"
        filename = code

    return pdf_url, filename



# def derive_pdf_from_custom_map(flipbook_url: str) -> tuple[str | None, str | None]:
#     """
#     ATTEMPT 2: Uses the hard-coded dictionaries to map known problem URLs.
#     """
#     path = unquote(urlparse(flipbook_url).path) # Decode %20 to spaces
#     code = None
    
#     # Get the last part of the URL path (e.g., 'Ch_01', 'june115')
#     key = path.rsplit("/", 1)[-1]

#     if "/5024-Sab Rang Class X/" in path:
#         code = SAB_RANG_CODES.get(key)
#     elif "/5012-Nawa-e-Urdu/" in path:
#         code = NAWA_E_URDU_CODES.get(key)
#     elif "/Class X/5018/" in path:
#         code = CLASSX_5018_CODES.get(key)
#     elif "/Class X/5019/" in path:
#         code = CLASSX_5019_CODES.get(key)

#     if not code:
#         return None, None
        
#     pdf_url = f"https://ncert.nic.in/textbook/pdf/{code}"
#     return pdf_url, code

def update_metadata_with_error(supabase: Client, chapter_id: str, existing_metadata: dict, error_message: str):
    """Helper to log an error to the chapter's metadata."""
    print(f"Logging error to metadata: {error_message}")
    existing_metadata['processing_error'] = error_message
    existing_metadata.pop('manual_download_url', None)
    existing_metadata.pop('supabase_storage_path', None)
    
    supabase.table('chapters').update(
        {'metadata': existing_metadata}
    ).eq('id', chapter_id).execute()

# --- 4. MAIN PROCESSING SCRIPT ---
def main():
    try:
        supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)
        print("Successfully connected to Supabase.")
    except Exception as e:
        print(f"Error connecting to Supabase: {e}")
        return

    # 1. Find all 'Class 10' books
    print("Fetching books for Class 10...")
    books_response = supabase.table('books').select('id').eq('class', 10).execute()
    book_ids = [book['id'] for book in books_response.data]

    # 2. Fetch all chapters for these books
    print("Fetching all chapters for Class 10...")
    chapters_response = supabase.table('chapters').select('id, storage_path, metadata').in_('book_id', book_ids).execute()
    
    chapters = chapters_response.data
    
    # Filter to find unprocessed chapters (those without supabase_storage_path or manual_download_url)
    # unprocessed_chapters = [
    #     ch for ch in chapters 
    #     if not (ch.get('metadata') and (ch.get('metadata').get('supabase_storage_path') or ch.get('metadata').get('manual_download_url')))
    # ]
    
    # print(f"Found {len(chapters)} total chapters, {len(unprocessed_chapters)} need processing.")
    # better: also ignore rows already marked as "No PDF found by code or custom map"
    unprocessed_chapters = []
    for ch in chapters:
        md = ch.get('metadata') or {}
        if md.get('supabase_storage_path') or md.get('manual_download_url'):
            continue
        # optionally skip rows where you *know* there is no mapping
        if md.get('processing_error') == "No PDF found by code or custom map" and "tiyhwlss" in (ch.get('storage_path') or ""):
            continue
        unprocessed_chapters.append(ch)
    
    print(f"Found {len(chapters)} total chapters, {len(unprocessed_chapters)} need processing.")
    
    # 3. Process each unprocessed chapter
    for i, chapter in enumerate(unprocessed_chapters):
        print(f"\n--- Processing {i+1}/{len(unprocessed_chapters)} (ID: {chapter['id']}) ---")
        
        pdf_url, filename = None, None
        existing_metadata = chapter.get('metadata') or {}
        
        try:
            flipbook_url = chapter['storage_path']
            if not flipbook_url:
                update_metadata_with_error(supabase, chapter['id'], existing_metadata, "storage_path is empty")
                continue

            # --- 3-STAGE RESOLVER LOGIC ---
            # 1. Try NCERT Code Resolver
            pdf_url, filename = derive_ncert_pdf_url_from_code(flipbook_url)
            
            # 2. Try Custom Map Resolver
            if not pdf_url:
                print("NCERT code not found. Trying custom map resolver...")
                pdf_url, filename = derive_pdf_from_custom_map(flipbook_url)
            
            # 3. Handle Failure
            if not pdf_url or not filename:
                print(f"FAILED to find PDF by code or custom map for URL: {flipbook_url}")
                update_metadata_with_error(supabase, chapter['id'], existing_metadata, "No PDF found by code or custom map")
                continue
            # --- END NEW LOGIC ---
                
            print(f"Resolver found PDF URL: {pdf_url}")
            print(f"Resolver found filename: {filename}")

            # 5. Download the PDF content
            print(f"Downloading {filename}...")
            response = session.get(pdf_url, timeout=60)
            
            if response.status_code == 404:
                print(f"!! FAILED (404): File not found at {pdf_url}")
                update_metadata_with_error(supabase, chapter['id'], existing_metadata, f"File not found on server (404): {pdf_url}")
                continue
            
            response.raise_for_status()
            pdf_content = response.content

            # 6. Upload to Supabase Storage
            upload_path = f"class-10/{filename}"
            print(f"Uploading to Supabase bucket '{BUCKET_NAME}' at path: {upload_path}")
            
            supabase.storage.from_(BUCKET_NAME).upload(
                path=upload_path,
                file=pdf_content,
                file_options={"content-type": "application/pdf", "upsert": "true"}
            )
            
            # 7. Update the chapter's metadata in the database
            print("Updating metadata in 'chapters' table...")
            existing_metadata['supabase_storage_path'] = upload_path
            existing_metadata.pop('manual_download_url', None)
            existing_metadata.pop('processing_error', None)
            
            supabase.table('chapters').update(
                {'metadata': existing_metadata}
            ).eq('id', chapter['id']).execute()
            
            print(f"Successfully processed chapter {chapter['id']}.")

        except Exception as e:
            error_message = str(e)
            
            # Handle 50MB Limit
            if "'statusCode': 413" in error_message or "'error': 'Payload too large'" in error_message:
                print(f"!! FAILED (File > 50MB): Saving URL to metadata for manual download.")
                if pdf_url:
                    existing_metadata['manual_download_url'] = pdf_url
                    existing_metadata.pop('processing_error', None)
                    supabase.table('chapters').update(
                        {'metadata': existing_metadata}
                    ).eq('id', chapter['id']).execute()
                else:
                    update_metadata_with_error(supabase, chapter['id'], existing_metadata, "File too large, but URL was not set")

            else:
                # Other unexpected error
                print(f"!! FAILED (Unexpected Error): {e}")
                update_metadata_with_error(supabase, chapter['id'], existing_metadata, f"Unexpected error: {error_message[:100]}")
            
            pass

    print("\n--- Batch processing complete! ---")

if __name__ == "__main__":
    main()