import pandas as pd
import uuid
import re

# --- Configuration ---
CSV_FILE = "epathshala_class9_20251105_145153.csv"
OUTPUT_SQL_FILE = "ncert_class9_migration_final.sql"
SYSTEM_USER_ID = "10000000-0000-0000-0000-000000000001" # IMPORTANT: Use your actual System/Admin User ID

# --- Column Mapping ---
# Use the exact column names provided by the user
BOOK_COL = 'book_title'
SUBJECT_COL = 'subject'
CLASS_COL = 'class'
LANGUAGE_COL = 'language'
CHAPTER_TITLE_COL = 'chapter'
LINK_COL = 'chapter_url'

# --- 1. Define Helper to Extract Chapter Number ---
def extract_chapter_number(chapter_title, default_index):
    """Tries to find the first integer in the chapter title, defaults to index + 1."""
    match = re.search(r'\d+', str(chapter_title))
    if match:
        return int(match.group(0))
    return default_index + 1

# --- 2. Load and Prepare Data ---
try:
    df = pd.read_csv(CSV_FILE)
    df = df.dropna(subset=[BOOK_COL, LINK_COL]) # Drop rows missing critical data
    df = df.astype({CLASS_COL: 'int'}) # Ensure class is an integer
except Exception as e:
    print(f"An error occurred during file processing: {e}")
    exit()

# --- 3. Generate SQL ---
sql_statements = []

# --- Setup SQL ---
sql_statements.append("-- NCERT Class 10 Data Migration Script (Generated from CSV)")
sql_statements.append("-- This script populates the 'books' and 'chapters' tables with NCERT metadata.")
sql_statements.append(f"DO $$")
sql_statements.append(f"DECLARE")
sql_statements.append(f"    system_user_id uuid := '{SYSTEM_USER_ID}';")
sql_statements.append(f"    book_ids RECORD;")
sql_statements.append(f"BEGIN")


# --- 3a. Insert unique Books ---
# Group by the combination that defines a unique book
unique_books = df.groupby([BOOK_COL, SUBJECT_COL, CLASS_COL, LANGUAGE_COL]).first().reset_index()

book_id_map = {}
for index, row in unique_books.iterrows():
    book_id = str(uuid.uuid4())
    book_title = str(row[BOOK_COL]).replace("'", "''")
    book_subject = str(row[SUBJECT_COL]).replace("'", "''")
    book_class = int(row[CLASS_COL])
    book_language = str(row[LANGUAGE_COL]).replace("'", "''")
    
    # Store ID mapping for chapters
    book_id_map[(row[BOOK_COL], row[SUBJECT_COL], row[CLASS_COL])] = book_id
    
    # Insert statement for books table
    sql_statements.append(f"\n-- Inserting Book: Class {book_class} {book_subject} - {book_title}")
    sql_statements.append(f"""
    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '{book_id}', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        '{book_title}', 
        '{book_subject}', 
        {book_class}, 
        '{book_language}', 
        'ncert',
        '{{ "edition": "2024-25" }}'
    );
    """)

# --- 3b. Insert Chapters ---
for index, row in df.iterrows():
    try:
        # Get the corresponding book ID
        book_key = (row[BOOK_COL], row[SUBJECT_COL], row[CLASS_COL])
        book_id = book_id_map.get(book_key)
        
        if not book_id:
             continue # Skip if somehow mapping failed

        chapter_id = str(uuid.uuid4())
        chapter_title = str(row[CHAPTER_TITLE_COL]).replace("'", "''")
        
        # Determine chapter number
        chapter_number = extract_chapter_number(chapter_title, index)
        
        pdf_link = str(row[LINK_COL]).replace("'", "''")

        # Insert statement for chapters table
        # storage_path holds the external link for compliance/redirection
        sql_statements.append(f"""
        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '{chapter_id}', 
            '{book_id}', 
            '{chapter_title}', 
            {chapter_number}, 
            '{pdf_link}', 
            '{{}}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        """)
    except Exception as e:
        sql_statements.append(f"-- ERROR processing row {index}: {e}")
        continue


# --- 4. Finalize SQL ---
sql_statements.append(f"END $$;")

# --- 5. Write to File ---
with open(OUTPUT_SQL_FILE, "w") as f:
    f.write("\n".join(sql_statements))

print(f"\n--- Success! ---")
print(f"Generated SQL migration script for NCERT data: {OUTPUT_SQL_FILE}")
print(f"1. Check the SQL file.")
print(f"2. Run the script in your Supabase SQL Editor.")
print(f"3. Remember: Your 'storage_path' column now holds the e-Pathshala redirection URL.")
print(f"4. The 'not_started' status is the signal for your backend to begin the embedding pipeline once Pinecone is ready.")