import os
import re
import requests
from supabase import create_client, Client
from urllib.parse import urlparse
import dotenv
dotenv.load_dotenv()

# --- 1. CONFIGURATION ---
# !! IMPORTANT: Fill these in. Use environment variables for your key!
SUPABASE_URL = os.getenv("SUPABASE_URL", "https://svkiztvkjbklhqrlmszy.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_SERVICE_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNkZWlzdW5xbWFveXhpam5ycmFzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MzMwMzQ0OCwiZXhwIjoyMDc4ODc5NDQ4fQ.INz5WyMvDm-B8t9PnkhCczN-EpHcANaS98bBrXqgjHM")

# The bucket you created in Supabase Storage
BUCKET_NAME = "NCERT Books" 

# Setup the requests session
session = requests.Session()
session.headers.update({
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 "
                  "(KHTML, like Gecko) Chrome/124.0 Safari/537.36"
})

# --- 2. HELPER FUNCTION ---
def derive_ncert_pdf_url_from_code(flipbook_url: str) -> tuple[str | None, str | None]:
    """
    Extracts the NCERT code (e.g., 'jesc107') from a flipbook URL
    and returns the direct PDF URL and the code.
    
    Returns: (pdf_url, filename)
    """
    m = re.search(r'/([a-z]{4}\d{3})(?:/index\.html|$)', flipbook_url)
    if not m:
        return None, None
        
    code = m.group(1)
    filename = f"{code}.pdf"
    pdf_url = f"https://ncert.nic.in/textbook/pdf/{filename}"
    
    return pdf_url, filename

# --- 3. MAIN PROCESSING SCRIPT ---
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
    if not books_response.data:
        print("No books found for Class 10.")
        return
        
    book_ids = [book['id'] for book in books_response.data]
    print(f"Found {len(book_ids)} books for Class 10.")

    # 2. Fetch all chapters for these books
    print("Fetching all chapters for these books...")
    chapters_response = supabase.table('chapters').select('id, storage_path, metadata').in_('book_id', book_ids).execute()
    
    if not chapters_response.data:
        print("No chapters found for these books.")
        return
        
    chapters = chapters_response.data
    print(f"Found {len(chapters)} total chapters to process.")
    
    # 3. Process each chapter
    for i, chapter in enumerate(chapters):
        print(f"\n--- Processing chapter {i+1}/{len(chapters)} (ID: {chapter['id']}) ---")
        
        pdf_url = None # Initialize pdf_url here to use it in the except block
        
        try:
            flipbook_url = chapter['storage_path']
            if not flipbook_url:
                print(f"Skipping chapter: 'storage_path' is empty.")
                continue

            # 4. Derive the real PDF URL
            pdf_url, filename = derive_ncert_pdf_url_from_code(flipbook_url)
            if not pdf_url:
                print(f"Skipping chapter: Could not derive PDF code from URL: {flipbook_url}")
                continue
                
            print(f"Derived PDF URL: {pdf_url}")

            # 5. Download the PDF content into memory
            print(f"Downloading {filename}...")
            response = session.get(pdf_url, timeout=60)
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
            
            existing_metadata = chapter.get('metadata') or {}
            existing_metadata['supabase_storage_path'] = upload_path
            # Ensure we remove any old manual download URL if this succeeds
            existing_metadata.pop('manual_download_url', None) 
            
            supabase.table('chapters').update(
                {'metadata': existing_metadata}
            ).eq('id', chapter['id']).execute()
            
            print(f"Successfully processed chapter {chapter['id']}.")

        except Exception as e:
            # --- THIS IS THE NEW LOGIC ---
            error_message = str(e)
            
            # Check if this is the "Payload too large" error
            if "'statusCode': 413" in error_message or "'error': 'Payload too large'" in error_message:
                print(f"!! FAILED (File > 50MB): Saving URL to metadata for manual download.")
                
                if not pdf_url:
                    print(f"!! Error: Cannot save manual URL because 'pdf_url' was not set.")
                    continue # Skip to next chapter

                try:
                    # Try to update the metadata with the failed URL
                    existing_metadata = chapter.get('metadata') or {}
                    existing_metadata['manual_download_url'] = pdf_url # The URL we derived
                    
                    supabase.table('chapters').update(
                        {'metadata': existing_metadata}
                    ).eq('id', chapter['id']).execute()
                    
                    print(f"Successfully saved 'manual_download_url' for chapter {chapter['id']}.")
                
                except Exception as meta_e:
                    print(f"!! FAILED to update metadata for chapter {chapter['id']}: {meta_e}")

            else:
                # It was a different error (e.g., download failed, non-413 upload error)
                print(f"!! FAILED to process chapter {chapter['id']}: {e}")
            
            # Continue to the next chapter
            pass
            # --- END OF NEW LOGIC ---

    print("\n--- Batch processing complete! ---")

if __name__ == "__main__":
    main()