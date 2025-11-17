-- NCERT Class 10 Data Migration Script (Generated from CSV)
-- This script populates the 'books' and 'chapters' tables with NCERT metadata.
DO $$
DECLARE
    system_user_id uuid := '10000000-0000-0000-0000-000000000001';
    book_ids RECORD;
BEGIN

-- Inserting Book: Class 10 Yoga - A Healthy Way of Living

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '1a1e0aa4-8aa0-4b48-a6e1-028ef4e710a4', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'A Healthy Way of Living', 
        'Yoga', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Social Science - Aasri Hindustan - II

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '72d5302e-343f-473a-9fb3-f18fc8f3cdd0', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Aasri Hindustan - II', 
        'Social Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Sanskrit - Abhyasvan Bhaav

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Abhyasvan Bhaav', 
        'Sanskrit', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Social Science - Arthik Vikas ki Samajh

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '0a20ece9-4b5f-4e1b-97a9-1642265397ee', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Arthik Vikas ki Samajh', 
        'Social Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Social Science - Bharat aur Samakalin Vishav - 2

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'cee4643a-3c5e-4b44-84e0-f5605b1da7d1', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Bharat aur Samakalin Vishav - 2', 
        'Social Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Social Science - Contemporary India

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'dfaafedf-6a54-454e-92e1-aa575ced4c1a', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Contemporary India', 
        'Social Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Social Science - Democratic Politics

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'cc6f2d03-b079-457f-b6bb-99c3467fd3ef', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Democratic Politics', 
        'Social Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Urdu - Door Paas

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '7d368d2d-51ad-4ef4-8200-50646f46323f', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Door Paas', 
        'Urdu', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 English - First Flight

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '0ebe80cf-298e-45c8-8b8b-fcceae828ef9', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'First Flight', 
        'English', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 English - Footprints without Feet Supp. Reader

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '025cc837-ab75-4856-8087-3a9cf1dc1395', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Footprints without Feet Supp. Reader', 
        'English', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Mathematics - Ganit

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '79933dde-68c6-41dc-962a-eb9664412ac9', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Ganit', 
        'Mathematics', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Urdu - Gulzar-e-Urdu

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'c52906f2-ca55-4041-ab62-73095b8758c3', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Gulzar-e-Urdu', 
        'Urdu', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Health and Physical Education - Health and Physical Education

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '9ded7824-5494-477e-bdee-c589b7888fd9', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Health and Physical Education', 
        'Health and Physical Education', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Social Science - Hindustan aur Asri Duniya

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '205f10da-5339-4571-b905-79681bcff9b5', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Hindustan aur Asri Duniya', 
        'Social Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Social Science - India and the Contemporary World - II

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '8197c31b-302c-49dd-aecd-64c51455888e', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'India and the Contemporary World - II', 
        'Social Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Urdu - Jaan Pahchan

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '1095a022-4235-4c49-9827-b7a4ab566300', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Jaan Pahchan', 
        'Urdu', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Social Science - Jamhuri Siyasat - II

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '0136ef8c-7c08-4921-98f5-883848dee0db', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Jamhuri Siyasat - II', 
        'Social Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Hindi - Kritika

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '634333c9-0440-47a2-ad5c-16ec086b0690', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Kritika', 
        'Hindi', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Hindi - Kshitij - 2

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Kshitij - 2', 
        'Hindi', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Social Science - Loktantrik Rajniti

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '56817770-fc82-43fd-a6f7-12c9ef4f93d6', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Loktantrik Rajniti', 
        'Social Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Social Science - Maashi Taraqqui ki Samajh

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '572ce398-2639-4b43-ac6c-d2af30d8ba6f', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Maashi Taraqqui ki Samajh', 
        'Social Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Mathematics - Mathematics

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '37b8b91d-71de-45f8-a83a-d6b127178175', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Mathematics', 
        'Mathematics', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Urdu - Nawa-e-Urdu

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Nawa-e-Urdu', 
        'Urdu', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Mathematics - Riyazi

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'eacce644-057b-49c9-b252-3327bfae1d98', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Riyazi', 
        'Mathematics', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Urdu - Sab Rang

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'f6929f2f-8a9e-4702-b30f-cb06ac8d87cf', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Sab Rang', 
        'Urdu', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Social Science - Samkalin Bharat

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '97e489c3-7de5-49ad-a684-a9529d158b83', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Samkalin Bharat', 
        'Social Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Hindi - Sanchayan Bhag - 2

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'd93e1c10-cb19-48e8-aef8-479fc7aa0bc6', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Sanchayan Bhag - 2', 
        'Hindi', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Science - Science

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Science', 
        'Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Science - Science (Urdu)

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'be026828-c508-457b-9f16-588947e54660', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Science (Urdu)', 
        'Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Sanskrit - Shemushi

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '68411ef0-f4f6-4f03-8056-77ad18d10c5e', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Shemushi', 
        'Sanskrit', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Hindi - Sparsh

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Sparsh', 
        'Hindi', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Social Science - Understanding Economic Development

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'aed0e729-e9d2-4931-82d3-3533e98c22c1', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Understanding Economic Development', 
        'Social Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Science - Vigyan

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '550cf301-2162-437a-a0f9-c28bd0dd0341', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Vigyan', 
        'Science', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 Sanskrit - Vyakaranavithi

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Vyakaranavithi', 
        'Sanskrit', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 10 English - Words and Expressions

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'd68f2a32-0e73-408c-8019-3ef4d1613e72', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Words and Expressions', 
        'English', 
        10, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c4dbd51c-cd75-4861-ad2a-835a03a7d290', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '98ba2dfb-ddee-4fc1-9d68-e20be3c16c34', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f26a7372-8f4f-400b-b87d-b2effadc01f9', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '95cf1ea2-df92-44a9-8b8f-3dea6bd08188', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f4a52167-bef2-4cb2-96a8-c3132c4418a8', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '42a047a9-2eec-4a2b-916c-f293c701e39f', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '83f17c46-8cd4-4e2a-92a1-198e04819617', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '05cd3b12-31ca-4252-8998-f738c6c2c1c7', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9be43e6a-0919-42d8-9aad-64c15054b472', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e979b58e-1e9b-41a8-a249-1db9f8016472', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b461ef9a-c78b-4e67-aa4e-8034faceda6e', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b550251c-61d7-4754-a718-23a56afd1741', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4428bd52-3ed8-447a-93b6-798b5fb0e71b', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh113/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c714b196-891d-479d-803a-40948d176f0e', 
            '37b8b91d-71de-45f8-a83a-d6b127178175', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh114/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3cf764eb-312b-4d46-8446-a7865681af6e', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'df1304e0-0707-43cd-b585-39a300ee9dd4', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '05fc019b-1b3f-45a5-8f5c-d5ba41020a39', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '875a04c7-fc2a-48c4-bc53-c17c7d52157e', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2a062945-2dc2-42c9-ba82-322913354aef', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f23fdd9d-512a-4647-af91-4ef900badafe', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '71da3448-5706-4047-a9e4-079957d77794', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '498cfb8a-8a74-40fb-8a8e-eeb61a1f46bf', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '56590d6d-9fe4-47fb-8a16-40a69ee5e03d', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'dbc5656f-6a73-44e9-a89b-d373a4543ce8', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd2034d74-251c-4198-ba3e-bc28566866f1', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1fc59f99-92f3-4a8f-a478-3f37299711de', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f0ae3e18-5ded-4b19-bb9e-28b456429621', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh113/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8bcfb776-5fe6-4f4a-bb8d-2f7ce531a243', 
            '79933dde-68c6-41dc-962a-eb9664412ac9', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh114/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1630844e-1e7d-402b-b73d-8a75585823f3', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh101', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '157ec41e-6ad6-4d77-b7b5-c50b118421e8', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh102', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f93c6e39-433f-416c-ae9d-008688d443ad', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh103', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2f854fec-8392-4f06-8a1c-031e7880a3bc', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh104', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1c865f7a-59ea-4e17-a9cc-2dea8430e0d3', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh105', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0fd9ab62-a67d-46c5-9b3c-152354c44734', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh106', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1c557a7a-909e-486a-a531-348b81126173', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh107', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1ce78950-d727-4355-97e0-d7ad84e66329', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh108', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'dc767233-9a82-4e9d-9739-a4ca5142a311', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh109', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '98248b27-93f6-47b4-9244-1e07a87941f8', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh110', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f8b1dedf-2ab9-472f-8425-0b1689ff0a40', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh111', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f7e59732-2054-4866-aead-cc4bf109aba6', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh112', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b3b44814-d848-44fe-8467-829abc4be33b', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh113', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0c3d5bde-02e3-443a-8f79-da7990d24a2a', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh114', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '637d781c-0a85-45f0-9d73-8e993b83ce54', 
            'eacce644-057b-49c9-b252-3327bfae1d98', 
            '» Chapter 15', 
            15, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh115', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1eac47d8-ab03-4500-8cc0-6896e45e0264', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f6fe715a-9f4e-47bd-affb-5744ad35ec4d', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e2cf20b4-b24f-4df1-b810-be7bf68ad8da', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '749ad5a7-8e8c-4ea9-a2b1-c7f5312b0d2b', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4c2c8432-088a-45fb-94a7-205a2b180f6c', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e3b2d248-b501-4b23-a01c-c4cd734f3645', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '03872f57-55fc-42ae-bb91-2ef142d1b5da', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'bdfc0d6f-3282-4353-bc05-3f9974574b10', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'beca2fa9-be9a-4cbd-a621-cdc572ee021e', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c6981017-cec5-4606-8d20-58ff39da8e0f', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ff2f3822-6d6b-4540-86e7-5e750f11a421', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9f5fd2e5-8ce3-4d91-a4e3-7fcc64260d58', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7a675b1c-8357-440f-aa93-f5bebed30449', 
            'f55f2761-3862-499e-b3ac-cc2276e2a97f', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc113/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '98cd2041-d4f9-4089-bcbf-2285d0b744e8', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd0daf65f-dd81-48ac-992f-619a05df255d', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c27126fc-b305-4f89-a59c-41e7041b7411', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a4ec71ec-5897-40d2-9133-b91faa88531c', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'dcb69119-ab18-45e7-8b47-cf46b3190b36', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9b9201e5-348c-4845-be5b-288ddafaecfc', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '78c470b6-271e-40a1-9c8f-533aa4e45388', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '000622ef-4865-4e9d-acfa-8b06adafbe0e', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c4ec2b90-5fea-4bcc-a836-3cd616a4c724', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3ff841ef-ea9a-4426-b068-1d5d1bf6afac', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '408214f0-4a88-4295-90ce-cf0bd5155dd9', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f202f6ea-700d-4c40-a3e2-e0fa6a7d5cfc', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'aef5931b-a162-4e69-b6ea-cbc3c0f7cf55', 
            '550cf301-2162-437a-a0f9-c28bd0dd0341', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc113/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c7ba1c2f-7952-4e59-ba16-26eceb72b9f0', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc101', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '30fa90e4-67a4-4498-a76f-2a1e5fd67a35', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc102', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '047316dd-b0a9-45dd-90dd-dfc2bd8b1590', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc103', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd1704c56-ce14-45b6-b64a-bcf1107d0abf', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc104', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '69b44fd9-62c6-41d8-af98-20064b790f75', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc105', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '179212d7-a9d9-419b-a82b-90de3be13119', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc106', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '36df2c62-4fe4-4765-a829-404afd63f386', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc107', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '169baecf-f348-43e4-9413-3bbd6c0ecb3c', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc108', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f3e7d128-7f55-4bc6-9119-828d5008eeee', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc109', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'fe15d27f-e0f2-4f4f-a9b8-fc393dfd1b96', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc110', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b479244a-8243-445b-a3ba-932a7ba6c0df', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc111', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e9b8b713-9647-4dac-80e9-8ef861555ecd', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc112', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '340d367b-5c65-4494-a155-9226fcd2c689', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc113', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '36ade020-cd7b-4e27-9b10-80e456baa0f0', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc114', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ee14b226-d5e9-40a0-8b84-28616e3d338d', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 15', 
            15, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc115', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9450422c-7a6e-4f7a-bfeb-5e4d4425d3dd', 
            'be026828-c508-457b-9f16-588947e54660', 
            '» Chapter 16', 
            16, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc116', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '11aab51f-e040-48c6-8382-6ab91a1241b8', 
            '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f5ec9eca-2e7f-4cd7-8898-bd0790e9c31f', 
            '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '93a97e08-ddd0-44b1-b507-3e3f04384a17', 
            '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '182409a3-9f84-4479-a25e-b8e7be97f994', 
            '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a25f4ed7-516a-4207-9990-6ccc16a7ed34', 
            '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5ac0d745-d0d4-45d3-a043-10e99427324d', 
            '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4f6bd50f-2417-44d3-87f4-7c004a241a26', 
            '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '12b8cb03-caaf-422c-971a-505d71bd3323', 
            '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f97788fb-ae1e-4fa1-98e3-7a39fa20a7dd', 
            '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3036dc50-ca29-49d9-9154-063f70374249', 
            '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '080a655e-83d3-44f6-aabd-97766e8294e8', 
            '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5d1e1ada-50dd-476c-82c5-14709a543aa5', 
            '02a1a4b5-525c-42ce-a5c7-c83e63a67127', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6fe55ba8-c9de-498b-a203-226c5cac5063', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '60ca9b44-04b5-4191-91ec-65bb579a4a04', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1c1155d2-e307-4415-b82b-e6f5746ded25', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '683fe2b0-997b-40ed-b4e8-d545bab0fe1c', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2487f287-8b3b-4809-b750-315ac5105c11', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd96f2a8a-2600-4732-abc4-8b45f8dffc3b', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '138a993a-7e6d-4e60-b6f9-8ecc896db131', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8510a7d9-d379-4928-9c48-f541746ed549', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a8178109-99e1-4b1b-ac76-9072f80a1c4f', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cf609a83-ce7b-4fdf-a3ee-140ed5ca4a7e', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0259299a-2c6e-4808-b5f4-1c79f7fc3e69', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'deb26946-b6c8-4c67-a59e-e81e331ec19e', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b24e6a2b-cddf-43f0-8ba2-2711a3551919', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp113/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8324511d-688a-4955-8ab1-c03c81c41e76', 
            'b85b1ade-1679-4a00-a156-8e53ec6836fd', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp114/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7f5f02bf-7e29-42c1-b037-83685ea03b71', 
            'd93e1c10-cb19-48e8-aef8-479fc7aa0bc6', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1058Sanchayan%20Bhag%202,%20Hindi%20Suppli/jhsy101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ead3bcb7-83b4-4f16-8843-2c8cea134bd3', 
            'd93e1c10-cb19-48e8-aef8-479fc7aa0bc6', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1058Sanchayan%20Bhag%202,%20Hindi%20Suppli/jhsy102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd87b7def-e55c-4a5e-b4cd-3b3238aa4d44', 
            'd93e1c10-cb19-48e8-aef8-479fc7aa0bc6', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1058Sanchayan%20Bhag%202,%20Hindi%20Suppli/jhsy103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6eef43d5-ddcc-4718-9b08-4d493c8070e9', 
            '634333c9-0440-47a2-ad5c-16ec086b0690', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1056Kritka%20Bhag%202%20Hindi%20Suppl%20CourseA/jhkr101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'acf36dba-1db3-4667-8e15-f6fa5a1919f5', 
            '634333c9-0440-47a2-ad5c-16ec086b0690', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1056Kritka%20Bhag%202%20Hindi%20Suppl%20CourseA/jhkr102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '07553745-86c0-44d0-a7da-990fe219d1b9', 
            '634333c9-0440-47a2-ad5c-16ec086b0690', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1056Kritka%20Bhag%202%20Hindi%20Suppl%20CourseA/jhkr103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '08282922-3319-47b9-ac01-529e24fa0c2f', 
            '97e489c3-7de5-49ad-a684-a9529d158b83', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1069%20Samkalin%20Bharat%20-%202%20-%20Bhugol/jhss101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8bc749c0-3307-4d5b-91e5-0c35cc4a1ac4', 
            '97e489c3-7de5-49ad-a684-a9529d158b83', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1069%20Samkalin%20Bharat%20-%202%20-%20Bhugol/jhss102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '75a93d6d-3b39-406a-a9cc-fdb01f477a9c', 
            '97e489c3-7de5-49ad-a684-a9529d158b83', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1069%20Samkalin%20Bharat%20-%202%20-%20Bhugol/jhss103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f21c41e6-d0f3-4caf-ac24-84d4fe072dce', 
            '97e489c3-7de5-49ad-a684-a9529d158b83', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1069%20Samkalin%20Bharat%20-%202%20-%20Bhugol/jhss104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '658b1d34-c64f-45e5-baa1-ebf6b6794726', 
            '97e489c3-7de5-49ad-a684-a9529d158b83', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1069%20Samkalin%20Bharat%20-%202%20-%20Bhugol/jhss105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3ac14c4f-85f3-4b65-8fb4-3bb636f06c25', 
            '97e489c3-7de5-49ad-a684-a9529d158b83', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1069%20Samkalin%20Bharat%20-%202%20-%20Bhugol/jhss106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8f7441db-c78f-4dd2-9f9b-b499d2a78f50', 
            '97e489c3-7de5-49ad-a684-a9529d158b83', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1069%20Samkalin%20Bharat%20-%202%20-%20Bhugol/jhss107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '11804b1c-cb93-483d-8c09-bdadd8cc9ea0', 
            '72d5302e-343f-473a-9fb3-f18fc8f3cdd0', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5017-Aasri%20Hindustan(Contemporary-India-II)/juss101', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '96809ba1-08a7-4a16-ad2d-9eb3eba1df05', 
            '72d5302e-343f-473a-9fb3-f18fc8f3cdd0', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5017-Aasri%20Hindustan(Contemporary-India-II)/juss102', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd507b433-0d1c-467e-8919-87618bc7c626', 
            '72d5302e-343f-473a-9fb3-f18fc8f3cdd0', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5017-Aasri%20Hindustan(Contemporary-India-II)/juss103', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd067e037-50e6-43f2-b2f2-821094f2c91b', 
            '72d5302e-343f-473a-9fb3-f18fc8f3cdd0', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5017-Aasri%20Hindustan(Contemporary-India-II)/juss104', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e73f5d21-766d-4ff4-8d89-85841cfc07e4', 
            '72d5302e-343f-473a-9fb3-f18fc8f3cdd0', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5017-Aasri%20Hindustan(Contemporary-India-II)/juss105', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '534cabfc-b424-4f3d-8601-20f70ad84e9a', 
            '72d5302e-343f-473a-9fb3-f18fc8f3cdd0', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5017-Aasri%20Hindustan(Contemporary-India-II)/juss106', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4d27ce6c-f493-4fc1-aa01-1c7edab9a483', 
            '72d5302e-343f-473a-9fb3-f18fc8f3cdd0', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5017-Aasri%20Hindustan(Contemporary-India-II)/juss107', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6494e60b-7599-44de-99a7-650bc80a93b0', 
            'aed0e729-e9d2-4931-82d3-3533e98c22c1', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1070Understanding%20Economic%20Development/jess201/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '240708f0-9f86-4ee8-a7d0-e9cf95566758', 
            'aed0e729-e9d2-4931-82d3-3533e98c22c1', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1070Understanding%20Economic%20Development/jess202/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '326f1e0a-ae93-4bbc-a44a-c86418f095ef', 
            'aed0e729-e9d2-4931-82d3-3533e98c22c1', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1070Understanding%20Economic%20Development/jess203/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd16d4c29-ad89-4602-88fc-fc80dd782145', 
            'aed0e729-e9d2-4931-82d3-3533e98c22c1', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1070Understanding%20Economic%20Development/jess204/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '65bbf8c7-43d0-45c7-84d6-530feea98248', 
            'aed0e729-e9d2-4931-82d3-3533e98c22c1', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1070Understanding%20Economic%20Development/jess205/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9337cfaf-bf12-4141-894e-2fd688c2cbab', 
            '0a20ece9-4b5f-4e1b-97a9-1642265397ee', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1071Arthik%20Vikas%20Ki%20Samajh/jhss201/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ca3572d4-114f-472c-8fb0-4aea794ee855', 
            '0a20ece9-4b5f-4e1b-97a9-1642265397ee', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1071Arthik%20Vikas%20Ki%20Samajh/jhss202/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1cf42ba0-fa93-45fb-9467-723838280d72', 
            '0a20ece9-4b5f-4e1b-97a9-1642265397ee', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1071Arthik%20Vikas%20Ki%20Samajh/jhss203/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0f849f6a-cc16-4fe1-9359-65e1de79bc8f', 
            '0a20ece9-4b5f-4e1b-97a9-1642265397ee', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1071Arthik%20Vikas%20Ki%20Samajh/jhss204/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a9c7b9f1-e2c8-4dad-9414-25b68983b214', 
            '0a20ece9-4b5f-4e1b-97a9-1642265397ee', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1071Arthik%20Vikas%20Ki%20Samajh/jhss205/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'bb2cd601-9995-4419-96bb-21c901a3602a', 
            '572ce398-2639-4b43-ac6c-d2af30d8ba6f', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5016-Maashi%20Taraqqi%20ki%20Samajh/juss201', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b1db908b-2d70-441c-9c62-b6dfad38d135', 
            '572ce398-2639-4b43-ac6c-d2af30d8ba6f', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5016-Maashi%20Taraqqi%20ki%20Samajh/juss202', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'eb27ea33-4533-4f1b-9ec8-94bfaaf2656a', 
            '572ce398-2639-4b43-ac6c-d2af30d8ba6f', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5016-Maashi%20Taraqqi%20ki%20Samajh/juss203', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1196e825-621e-44fd-9371-630dda2e1f9a', 
            '572ce398-2639-4b43-ac6c-d2af30d8ba6f', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5016-Maashi%20Taraqqi%20ki%20Samajh/juss204', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2ab615e5-242d-4f0a-9cd4-004584309b49', 
            '572ce398-2639-4b43-ac6c-d2af30d8ba6f', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5016-Maashi%20Taraqqi%20ki%20Samajh/juss205', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c69b921d-8226-44f8-92e3-8aef5358c448', 
            '8197c31b-302c-49dd-aecd-64c51455888e', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1066India%20and%20the%20Contemporary%20World%20IIHistory/jess301/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c828b9de-a9f3-4c6b-a9c0-9eec24e3ac9b', 
            '8197c31b-302c-49dd-aecd-64c51455888e', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1066India%20and%20the%20Contemporary%20World%20IIHistory/jess302/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3985f4ae-780e-4ea6-ba72-20b28a5485fb', 
            '8197c31b-302c-49dd-aecd-64c51455888e', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1066India%20and%20the%20Contemporary%20World%20IIHistory/jess303/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '18d4eaee-b7a5-48fb-b1ab-cfce46cc533a', 
            '8197c31b-302c-49dd-aecd-64c51455888e', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1066India%20and%20the%20Contemporary%20World%20IIHistory/jess304/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4ee81b11-6e33-44ae-a95a-25832de8cfbb', 
            '8197c31b-302c-49dd-aecd-64c51455888e', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1066India%20and%20the%20Contemporary%20World%20IIHistory/jess305/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '680cc854-23be-4fd1-a550-ac401ea68644', 
            'cee4643a-3c5e-4b44-84e0-f5605b1da7d1', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1067Bharat%20Aur%20Samakalin%20Vishwa%20II%20Itihas/jhss301/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7981acd5-6bc0-4df6-8575-6331f7fafe11', 
            'cee4643a-3c5e-4b44-84e0-f5605b1da7d1', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1067Bharat%20Aur%20Samakalin%20Vishwa%20II%20Itihas/jhss302/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ece62249-3d1d-4017-89d2-840dea380301', 
            'cee4643a-3c5e-4b44-84e0-f5605b1da7d1', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1067Bharat%20Aur%20Samakalin%20Vishwa%20II%20Itihas/jhss303/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c6c6d553-13b5-454c-863f-47078293ea91', 
            'cee4643a-3c5e-4b44-84e0-f5605b1da7d1', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1067Bharat%20Aur%20Samakalin%20Vishwa%20II%20Itihas/jhss304/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '85480385-c61d-45bb-89bb-49b496e1d32f', 
            'cee4643a-3c5e-4b44-84e0-f5605b1da7d1', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1067Bharat%20Aur%20Samakalin%20Vishwa%20II%20Itihas/jhss305/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a47f5739-639b-48f0-a4da-297023871853', 
            '205f10da-5339-4571-b905-79681bcff9b5', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5015-Hindustan%20Aur%20Asri%20Duniya/juss301', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9e08a7f6-ccc1-4d86-b0d5-05b8ccce23a5', 
            '205f10da-5339-4571-b905-79681bcff9b5', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5015-Hindustan%20Aur%20Asri%20Duniya/juss302', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f20fed56-6472-4b1d-b1c2-9062f705a4ff', 
            '205f10da-5339-4571-b905-79681bcff9b5', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5015-Hindustan%20Aur%20Asri%20Duniya/juss303', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a72486cd-dcc0-4093-b634-e04bf7cae7b5', 
            '205f10da-5339-4571-b905-79681bcff9b5', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5015-Hindustan%20Aur%20Asri%20Duniya/juss304', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '465b4226-ed12-4efe-984f-3ca3ae0418ef', 
            '205f10da-5339-4571-b905-79681bcff9b5', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5015-Hindustan%20Aur%20Asri%20Duniya/juss305', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '54eaae76-aa64-41c5-aeff-b730c73126de', 
            'cc6f2d03-b079-457f-b6bb-99c3467fd3ef', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1072Democratic%20Politics%20II/jess401/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2011ca5c-d0ef-42b9-b636-5fe95e204c75', 
            'cc6f2d03-b079-457f-b6bb-99c3467fd3ef', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1072Democratic%20Politics%20II/jess402/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '884573d5-9151-4861-8576-ef8ef9a40628', 
            'cc6f2d03-b079-457f-b6bb-99c3467fd3ef', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1072Democratic%20Politics%20II/jess403/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '05d956a0-f033-4612-a7bf-4c0ad603315b', 
            'cc6f2d03-b079-457f-b6bb-99c3467fd3ef', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1072Democratic%20Politics%20II/jess404/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '03b06500-b15d-4bb1-b2ec-7ca9327c6145', 
            'cc6f2d03-b079-457f-b6bb-99c3467fd3ef', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1072Democratic%20Politics%20II/jess405/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e53b1a6f-37f2-4f82-93e6-fed76920fa78', 
            '56817770-fc82-43fd-a6f7-12c9ef4f93d6', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1073Loktantrik%20Rajniti%20II/jhss401/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9bd123b6-4e56-4398-928f-cbb08c0a3465', 
            '56817770-fc82-43fd-a6f7-12c9ef4f93d6', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1073Loktantrik%20Rajniti%20II/jhss402/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0bd6dcfb-12e0-42c6-bb6b-3319254c3d07', 
            '56817770-fc82-43fd-a6f7-12c9ef4f93d6', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1073Loktantrik%20Rajniti%20II/jhss403/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '92204705-b139-4103-9738-1546daae66a3', 
            '56817770-fc82-43fd-a6f7-12c9ef4f93d6', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1073Loktantrik%20Rajniti%20II/jhss404/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '794dc900-7a0c-4267-9ac0-8ce4496332f8', 
            '56817770-fc82-43fd-a6f7-12c9ef4f93d6', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1073Loktantrik%20Rajniti%20II/jhss405/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '974646e1-c751-4954-9cde-83bd5d2db634', 
            '0136ef8c-7c08-4921-98f5-883848dee0db', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5018/Chap-01', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8771a1a7-c734-4f27-b3b2-59ba467803f7', 
            '0136ef8c-7c08-4921-98f5-883848dee0db', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5018/Chap-02', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6cafa4e6-e122-4baf-b451-76cbd9c16ca6', 
            '0136ef8c-7c08-4921-98f5-883848dee0db', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5018/Chap-03', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'effbca9f-eab9-4789-91ef-2bc43cb52c3b', 
            '0136ef8c-7c08-4921-98f5-883848dee0db', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5018/Chap-04', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '03079f24-a4ff-4753-9547-afedd22a064e', 
            '0136ef8c-7c08-4921-98f5-883848dee0db', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5018/Chap-05', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd49cef0d-a3a6-42a3-8a44-7c7958eaae73', 
            '0136ef8c-7c08-4921-98f5-883848dee0db', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5018/Chap-06', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '72149ab1-c5d3-4ad7-bf55-bab27758739d', 
            '0136ef8c-7c08-4921-98f5-883848dee0db', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5018/Chap-07', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9cd9b38f-2694-43ff-9320-fe16e97ecd52', 
            '0136ef8c-7c08-4921-98f5-883848dee0db', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5018/Chap-08', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '459ac946-bb7d-4bad-8419-b54b3354d323', 
            'dfaafedf-6a54-454e-92e1-aa575ced4c1a', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '04a41af6-33bf-42e2-883d-3d9387d599a2', 
            'dfaafedf-6a54-454e-92e1-aa575ced4c1a', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e75968d3-a1c7-4558-b461-32ef95fc37e9', 
            'dfaafedf-6a54-454e-92e1-aa575ced4c1a', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5976b810-dc8f-425c-b402-f9947678726e', 
            'dfaafedf-6a54-454e-92e1-aa575ced4c1a', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '16a8edfc-c9bd-421a-a68b-9ea43ec8346f', 
            'dfaafedf-6a54-454e-92e1-aa575ced4c1a', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '317825eb-a913-47b9-a9cf-0428f146162f', 
            'dfaafedf-6a54-454e-92e1-aa575ced4c1a', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '07d0e02f-0d8f-46d0-8f40-a5cd83461adb', 
            'dfaafedf-6a54-454e-92e1-aa575ced4c1a', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4cbd87ad-d9a7-4bb0-9d1c-0d393f009180', 
            '0ebe80cf-298e-45c8-8b8b-fcceae828ef9', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd4bbcb26-8fce-4764-bda4-9d3a7f9419b0', 
            '0ebe80cf-298e-45c8-8b8b-fcceae828ef9', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0d646f77-f237-4aab-a11d-c6b800d66f23', 
            '0ebe80cf-298e-45c8-8b8b-fcceae828ef9', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '63994bf9-507c-4897-a7fb-5eb9f29302d9', 
            '0ebe80cf-298e-45c8-8b8b-fcceae828ef9', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '43669848-05eb-4536-a466-39c3d5459d31', 
            '0ebe80cf-298e-45c8-8b8b-fcceae828ef9', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '67e14eae-1508-441c-9111-b0f410877fef', 
            '0ebe80cf-298e-45c8-8b8b-fcceae828ef9', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b43714f5-a202-45eb-b6b7-9cae2f758317', 
            '0ebe80cf-298e-45c8-8b8b-fcceae828ef9', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4eb1aa03-cbb3-4ea2-a5ee-06064a365bf7', 
            '0ebe80cf-298e-45c8-8b8b-fcceae828ef9', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7a489698-f5be-4e2f-a3bb-cef94b9254f5', 
            '0ebe80cf-298e-45c8-8b8b-fcceae828ef9', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '90623d6d-a111-48e0-8084-404e87f9bf1f', 
            '025cc837-ab75-4856-8087-3a9cf1dc1395', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '32276f19-a651-4b79-a698-8b2e6539d85d', 
            '025cc837-ab75-4856-8087-3a9cf1dc1395', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1fb3789d-bc37-42b8-8d73-bf7fe6aa2d2b', 
            '025cc837-ab75-4856-8087-3a9cf1dc1395', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '06a641cf-05ec-4d36-8e74-638a4f6c881b', 
            '025cc837-ab75-4856-8087-3a9cf1dc1395', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'baa54550-0171-493f-ac6f-184eec8f9a38', 
            '025cc837-ab75-4856-8087-3a9cf1dc1395', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5b6a93b1-f695-400b-a7f6-a48b1bf589e1', 
            '025cc837-ab75-4856-8087-3a9cf1dc1395', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd255484d-b13b-42b6-a134-e5ae665bd47c', 
            '025cc837-ab75-4856-8087-3a9cf1dc1395', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'df7184c2-21e0-4d4d-9006-b2b76b8609f1', 
            '025cc837-ab75-4856-8087-3a9cf1dc1395', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '14632845-262d-4db6-8be2-ecf7b94f4d73', 
            '025cc837-ab75-4856-8087-3a9cf1dc1395', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ca0e9949-c7ef-4c47-b25f-7c949224b6ba', 
            'd68f2a32-0e73-408c-8019-3ef4d1613e72', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe201/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5d0e5351-8683-482a-acaf-93b97a6d8ad1', 
            'd68f2a32-0e73-408c-8019-3ef4d1613e72', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe202/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ff4f6b8e-a5a3-48a1-a947-c4d1349cb186', 
            'd68f2a32-0e73-408c-8019-3ef4d1613e72', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe203/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b92c8b0f-4eb7-4bc7-ac11-f0350ea195e2', 
            'd68f2a32-0e73-408c-8019-3ef4d1613e72', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe204/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a004eb4c-517b-4f49-978e-578c9c644e4d', 
            'd68f2a32-0e73-408c-8019-3ef4d1613e72', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe205/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '795357ad-5604-4882-84f1-326c8839a1ca', 
            'd68f2a32-0e73-408c-8019-3ef4d1613e72', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe206/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'dd6e7418-8aba-44af-8402-dde0fcb8d622', 
            'd68f2a32-0e73-408c-8019-3ef4d1613e72', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe207/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'abb559e6-1a0a-4701-b9d9-ebe5062a01bb', 
            'd68f2a32-0e73-408c-8019-3ef4d1613e72', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe208/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd79129fe-f953-4400-9d5b-3bda2379a21f', 
            'd68f2a32-0e73-408c-8019-3ef4d1613e72', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe209/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8a383781-9308-4d88-b765-06cdb0f20ffb', 
            '68411ef0-f4f6-4f03-8056-77ad18d10c5e', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '92f18c2f-c7d1-4048-89de-87009e265168', 
            '68411ef0-f4f6-4f03-8056-77ad18d10c5e', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5ee88f1e-602d-4b74-9da6-4e760872fa5d', 
            '68411ef0-f4f6-4f03-8056-77ad18d10c5e', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '56f69479-2e22-4046-ac38-8159eca87169', 
            '68411ef0-f4f6-4f03-8056-77ad18d10c5e', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '72d1be0a-84a7-4ac3-a92a-34782e321687', 
            '68411ef0-f4f6-4f03-8056-77ad18d10c5e', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '301806cb-43a9-48a8-81b4-a973feac4d62', 
            '68411ef0-f4f6-4f03-8056-77ad18d10c5e', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0ea8e2e9-2081-4c50-b7cf-88570c801304', 
            '68411ef0-f4f6-4f03-8056-77ad18d10c5e', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ae998a78-f8c7-4a12-95d0-15192953ef9d', 
            '68411ef0-f4f6-4f03-8056-77ad18d10c5e', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1c2cf7a4-b11a-4192-b7d4-3491fc2c289e', 
            '68411ef0-f4f6-4f03-8056-77ad18d10c5e', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7e4360dc-6a90-4e72-953e-29820dec013f', 
            '68411ef0-f4f6-4f03-8056-77ad18d10c5e', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd3f2686d-3351-470a-aa4c-c78c605807a1', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '18db0322-4bcb-4b60-ae12-924fead5da31', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8c5f4f97-9b02-4ea9-955e-c216480d6936', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f3e52cf5-d28f-4b65-9d98-1ad3461546c6', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6ffb87c2-3948-45c4-8775-f587e1617c0d', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'dafb7b6e-370d-45da-9e49-3df204c25dba', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f957c615-2738-467c-b2ba-45489a4bf152', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6408c509-7144-4ae2-8346-2cf56839e35d', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ac09a7b8-55c8-426f-9351-ef5b8b39ea12', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6689ba6f-2a54-41c4-a960-7dea99ceddaa', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '21ec6499-e90a-46bd-a455-3d1525fb3942', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7cf309df-309a-451f-9521-6a863b5c43d3', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'bd2c1ffe-e78e-424b-87cc-dc184215397d', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab113/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'aaa14443-0612-4602-84ae-b50e4b530675', 
            'a81fc4c2-49c4-4fe8-9976-0997b98bc371', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab114/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '030ea52d-870e-4ed3-bc56-b67b5cbdca5c', 
            'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '957f9140-3bc2-4a51-8b72-8c40458224fd', 
            'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0e41742a-505c-4db1-bd17-20490c9f2d40', 
            'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '39676b67-fbae-4c64-b1d3-44b149f89a89', 
            'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cfa4ed0b-efdf-40b1-bf82-b3dd89e4cf8b', 
            'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0443ffb5-503d-4d99-b510-3742e861d9ab', 
            'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1b6f7058-c9cc-4ff2-ba93-c9ed4e6c670f', 
            'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ae4778dd-091c-4e6e-a2ef-2ed768e0eb51', 
            'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5ec70a23-6bbc-432a-9e9c-e7ae0ab0b9d8', 
            'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8745e7da-b83c-4982-81b8-47b00074fcfc', 
            'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '93c6fc3e-003f-4edb-ba34-9e2b2654c511', 
            'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'eeb7c741-54ba-4b31-b9ac-92be48e221a8', 
            'd3251f69-d240-4606-8ddd-45b9bac3fa20', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f416f2f5-0f78-476b-a9e7-af1f0e70727a', 
            'c52906f2-ca55-4041-ab62-73095b8758c3', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-01', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ce8f6b84-6531-4f68-8e6f-2c6707f733d3', 
            'c52906f2-ca55-4041-ab62-73095b8758c3', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-02', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8ce1f87d-f755-4219-ad2b-15b7f7a85675', 
            'c52906f2-ca55-4041-ab62-73095b8758c3', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-03', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9bfeefd2-4fba-4449-a5f3-58669dfdd45f', 
            'c52906f2-ca55-4041-ab62-73095b8758c3', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-04', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9b50af85-ae1a-4b50-906c-bdc8fac8d6c5', 
            'c52906f2-ca55-4041-ab62-73095b8758c3', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-05', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '81df07a5-7820-44c7-a0c5-e62e5c8b84ab', 
            'c52906f2-ca55-4041-ab62-73095b8758c3', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-06', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '85e10a27-7333-419a-ac89-369eb333543a', 
            'c52906f2-ca55-4041-ab62-73095b8758c3', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-07', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'fa81f04f-7543-4050-85ff-89bc10ef136b', 
            'c52906f2-ca55-4041-ab62-73095b8758c3', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-08', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e37b9fa2-3bfa-4c0b-9db8-1f6527dd49c3', 
            'c52906f2-ca55-4041-ab62-73095b8758c3', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-09', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4d78c495-612a-474d-bd2d-b8e95f262803', 
            'c52906f2-ca55-4041-ab62-73095b8758c3', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-10', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '36832957-7c84-4fc2-b9de-249e9d662615', 
            'c52906f2-ca55-4041-ab62-73095b8758c3', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-11', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '61409ab8-8af6-409d-859a-d169df811649', 
            'c52906f2-ca55-4041-ab62-73095b8758c3', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-12', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c445be2a-1e37-45e9-9eea-b5c81189e94a', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june101', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '70a36604-e9f1-49d7-b933-25b82fb44c62', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june102', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2c890d53-f144-4698-97ec-61019ac1ec79', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june103', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a7adf874-f7d8-45c8-b24f-ab9c969119e8', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june104', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4dab8e7f-fd21-4637-994c-6fbc8364bbf3', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june105', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1c9f5fa6-ccfd-495f-b482-6f5bbf2a7ef9', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june106', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c9e1a5e1-9825-4210-899c-8b4f35ea1be6', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june107', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6ca65b97-82d1-479d-8461-4ca3b4c14aa9', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june108', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a05b1014-e66c-4d75-9012-93a181589b98', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june109', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ffb2dcca-894a-4902-8bee-2bf1d691ab08', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june110', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '37859548-1136-401a-b675-3089199d3037', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june111', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '96033387-deeb-458a-b044-e18b6e7b380a', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june112', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'aba909d8-4708-4c11-836d-11ed799c9de1', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june113', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2ef07351-a940-4566-85ac-93c08c625dc1', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june114', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '261b7394-614d-4430-973f-8d900543196b', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 15', 
            15, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june115', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f168bfad-0698-41b6-9bf5-c46f7c857414', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 16', 
            16, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june116', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b51ed656-a04e-45f1-bcd5-705c2b0890bb', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 17', 
            17, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june117', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '742f4864-cb49-475a-92a7-7d39a12ed8c0', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 18', 
            18, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june118', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1be571a7-6f8e-44b7-8b44-769ed0048f5c', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 19', 
            19, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june119', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3107a474-9671-4b47-b698-96891a96e8b4', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 20', 
            20, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june120', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ee655a21-eb2a-4d9a-a1ac-35ba927d19ba', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 21', 
            21, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june121', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9860991a-1886-46df-9191-e0619ed6ef8a', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 22', 
            22, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june122', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '16c77bad-bcab-46be-9ccc-3955f1c4d43f', 
            'bcc4ddcd-aa09-45cf-badd-1814583d5982', 
            '» Chapter 23', 
            23, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june123', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '704a5826-5453-446f-9967-4244a951a9e7', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp101', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e863b285-807f-4f6d-8e34-62c1d8ea50a3', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp102', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '775ea9c8-72a6-490e-87f4-3d3e64126241', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp103', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e9c60bc0-726e-4cb1-8c27-c0fdbc965f76', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp104', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '72afae20-8d09-449d-98d5-a655212401b7', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp105', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5515f55e-e0e4-4ad1-b2b4-fc4e875494eb', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp106', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3dab735e-59d5-4092-b6fd-74d16297357b', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp107', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '43a3782a-1527-4cbf-acbb-358da86b2aa0', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp108', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e1082ca5-7ad2-4e23-a0a2-dc36703047ce', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp109', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3d359392-8f07-42b5-bbf8-222c04172174', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp110', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6ec0c80b-8a4d-4bc1-8bd7-15144e35034d', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp111', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a20c452a-5b5b-4b25-95a6-8257ef951458', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp112', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5a8f6bd5-5b45-4331-9441-7cea0f72eea0', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp113', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '48caa353-8d6a-4db2-b27e-257ac13c0752', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp114', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd83abdb9-8da6-465c-b884-5f091dd9f460', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 15', 
            15, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp115', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7b63171c-c4b3-487d-a35f-1b9cc3f91575', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 16', 
            16, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp116', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4188fb5d-ad86-46a0-9a9f-0b31317c4205', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 17', 
            17, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp117', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '67468f9d-f5c3-4daf-b8c8-a7baf629bb32', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 18', 
            18, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp118', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'de8cc251-e004-425b-aa44-a8e4956f4285', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 19', 
            19, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp119', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5a1dc9f9-84c2-4bb0-9d70-ee79d3be4dec', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 20', 
            20, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp120', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b48850d2-98f9-425f-b8d1-14c760f38b53', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 21', 
            21, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp121', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2af9823b-b319-4fa2-8e23-29aad2a8ee4e', 
            '1095a022-4235-4c49-9827-b7a4ab566300', 
            '» Chapter 22', 
            22, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp122', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e052852e-6ade-491f-953a-4a20f0dc0f57', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp101', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cec90d36-0db8-467f-b322-562132863e61', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp102', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '759783c9-dc42-4bc2-a1fc-ab8dcb29bf76', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp103', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '27357193-873f-4723-9da7-dc0ef5dce648', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp104', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0b9d047b-0edf-4bbe-bd7f-58d9d6d83e3c', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp105', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6d803aea-59ca-465c-a280-ff606f32fd58', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp106', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8269891d-d9e3-49fa-8021-30e9ce0f22bb', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp107', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'dcd4f465-15d5-4ec4-9a8c-d331a77b0930', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp108', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd025eb2f-c8e0-4e77-9bc5-dbd1b0bfe9c1', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp109', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c83b6501-1b50-4cc9-9012-ce78354347ff', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp110', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '255db57b-4417-4217-9b43-43689cf6ee3b', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp111', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0b28ad1c-883a-4bd4-8ee7-ae332ba8a7a6', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp112', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2e4f5f98-c6d3-4c28-aa04-ec7761938bf8', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp113', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c95d8a82-a54c-45b8-b68b-a2ddb628f3f4', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp114', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a42c985e-ed10-4da5-a4a9-23b768a408ec', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 15', 
            15, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp115', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7015f4d8-045f-47bd-9ab8-3d00c2e86973', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 16', 
            16, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp116', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '08c9a70d-3949-455a-98db-c70001a242a4', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 17', 
            17, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp117', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '553a0bcb-b8da-45a5-895c-9ee2e67432f6', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 18', 
            18, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp118', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '578a1178-fdba-4ee0-97a1-2e4092ee897c', 
            '7d368d2d-51ad-4ef4-8200-50646f46323f', 
            '» Chapter 19', 
            19, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp119', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2d52b502-1fde-4057-a3ea-c9fd5695f3a6', 
            'f6929f2f-8a9e-4702-b30f-cb06ac8d87cf', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_01', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b02b80b0-45fa-44c8-9da9-42d4139d9e6c', 
            'f6929f2f-8a9e-4702-b30f-cb06ac8d87cf', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_02', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a94c0528-d1b5-4c81-ab52-b57b1cd89286', 
            'f6929f2f-8a9e-4702-b30f-cb06ac8d87cf', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_03', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7c732525-a242-4c08-8fa5-426659a1958e', 
            'f6929f2f-8a9e-4702-b30f-cb06ac8d87cf', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_04', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '266a6480-78a4-4673-baa4-35cff86b86f4', 
            'f6929f2f-8a9e-4702-b30f-cb06ac8d87cf', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_05', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f29ae0bb-7375-489b-90e9-39872c929bf8', 
            'f6929f2f-8a9e-4702-b30f-cb06ac8d87cf', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_06', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3642adf4-d426-42be-a787-aaf473d3c603', 
            'f6929f2f-8a9e-4702-b30f-cb06ac8d87cf', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_07', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd4c7b618-62b4-4117-89e2-6468ab86203d', 
            'f6929f2f-8a9e-4702-b30f-cb06ac8d87cf', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_08', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e68b1db7-ec85-4c0f-804f-5709808e9782', 
            'f6929f2f-8a9e-4702-b30f-cb06ac8d87cf', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_09', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '10d3b89c-d8bf-4087-b7a4-adb545cb0751', 
            '1a1e0aa4-8aa0-4b48-a6e1-028ef4e710a4', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/l/sample/basic/index.php?tra=tiyhwlss101', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'aa4533ee-e044-41f8-a6e7-751194fb72c3', 
            '1a1e0aa4-8aa0-4b48-a6e1-028ef4e710a4', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/l/sample/basic/index.php?tra=tiyhwlss102', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ccbd7e4b-5548-4945-9d09-bbf818ee3fcc', 
            '1a1e0aa4-8aa0-4b48-a6e1-028ef4e710a4', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/l/sample/basic/index.php?tra=tiyhwlss103', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'dc6b39d5-544f-4f85-b9fb-e8cf0133edf4', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '351c342b-b9a5-4dcd-b8e0-81d46a426ad9', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a81fb475-3fa4-452b-98f6-820169d3bf9a', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '30d99460-4115-4958-9c0f-6853c1ec3b85', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6637a1ce-b929-41e9-a14d-33df1c24af05', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'fd3a3b9f-c8ed-4b89-9d41-81bc63ac4405', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '286addf1-e23c-4127-b944-d462b2116429', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'bbd86fa3-a347-4f7c-bde5-e8ef0cd66c34', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1ec99ec2-3ca9-4751-9c98-aa3e93bc3e33', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '67d9532a-6fe1-4c56-b6b2-d09798614c54', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a44f2684-38ad-48b0-bc84-4fd7f874fb4b', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '74b26c5d-1c70-497b-bfef-21f172e380fc', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5ce10480-4d9c-4b00-a5f2-6740d30f3a2c', 
            '9ded7824-5494-477e-bdee-c589b7888fd9', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp113/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        
END $$;