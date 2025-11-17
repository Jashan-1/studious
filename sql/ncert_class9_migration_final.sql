-- NCERT Class 10 Data Migration Script (Generated from CSV)
-- This script populates the 'books' and 'chapters' tables with NCERT metadata.
DO $$
DECLARE
    system_user_id uuid := '10000000-0000-0000-0000-000000000001';
    book_ids RECORD;
BEGIN

-- Inserting Book: Class 9 Yoga - A Healthy Way of Living

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'e7b90851-ec06-444d-b079-63ac1e0b251e', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'A Healthy Way of Living', 
        'Yoga', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Social Science - Aasri Hindustan

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'c4fbcad3-ac03-47e5-9b51-a6323563ed44', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Aasri Hindustan', 
        'Social Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Sanskrit - Abhyaswaan Bhav

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Abhyaswaan Bhav', 
        'Sanskrit', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Vocational - Animal Health Worker

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '64c21f74-887c-4603-b4d8-a32f42d67483', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Animal Health Worker', 
        'Vocational', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Social Science - Arthashastra

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '04b0b71f-24b2-4e58-a26f-c847e3a49a1e', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Arthashastra', 
        'Social Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Vocational - Assistant Beauty Therapist

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '07c64566-ee51-47ce-ab8d-99afcc2c7471', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Assistant Beauty Therapist', 
        'Vocational', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 English - Beehive English Text Book

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '97915358-c7d8-438c-a9a2-c1c1c1d50418', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Beehive English Text Book', 
        'English', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Social Science - Bharat aur Samkalin Vishwa - I

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'f3a910d2-9c28-4add-b763-14d32be7da54', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Bharat aur Samkalin Vishwa - I', 
        'Social Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Vocational - Cashier

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '2a112a3e-a2db-4897-94d3-0af1276b6d51', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Cashier', 
        'Vocational', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Social Science - Contemporary India

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'f0390baf-242c-4440-bb98-aeaf69ec75bc', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Contemporary India', 
        'Social Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Social Science - Democratic Politics

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '6052c40e-db77-4d28-9326-ff133d7f7dc8', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Democratic Politics', 
        'Social Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Urdu - Door Pass

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'def3336d-b53f-4037-b269-f93f61301ec9', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Door Pass', 
        'Urdu', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Social Science - Economics

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'ac9a29f5-aac5-44f0-9708-cc1760b32ced', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Economics', 
        'Social Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Mathematics - Ganit

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Ganit', 
        'Mathematics', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Urdu - Gulzare-e-Urdu

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Gulzare-e-Urdu', 
        'Urdu', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Vocational - Hand Embroiderer

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '8e91d672-71fb-4451-8bc3-95ee0642a324', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Hand Embroiderer', 
        'Vocational', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Vocational - Hand Embroidery (Addawala)

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '39743b46-56ef-4cdd-86d6-42a8d9c23bca', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Hand Embroidery (Addawala)', 
        'Vocational', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Health and Physical Education - Health and Physical Education

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'f97a13d2-0802-4a1f-bb55-0593164d7443', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Health and Physical Education', 
        'Health and Physical Education', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Social Science - Hindustan aur Asri Dunia - I (Urdu)

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'f98220eb-5e20-4346-aa9e-e55ab24cd766', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Hindustan aur Asri Dunia - I (Urdu)', 
        'Social Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 ICT - ICT

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'ab8bd5a8-bb6c-4d58-a9b2-d6bd4859cdb5', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'ICT', 
        'ICT', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Social Science - India and the Contempoarary World - I

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '00d0a392-c10c-4810-ae1a-45f8c35ba2dd', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'India and the Contempoarary World - I', 
        'Social Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Urdu - Jaan Pahchan

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Jaan Pahchan', 
        'Urdu', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Social Science - Jamhuri Syasat (Urdu)

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '7aebdbdb-70ab-40c5-88ca-cf541ab1455c', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Jamhuri Syasat (Urdu)', 
        'Social Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Hindi - Kritika

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'd887596f-8847-4d8f-b52a-93cb564e9383', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Kritika', 
        'Hindi', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Hindi - Kshitij

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Kshitij', 
        'Hindi', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Social Science - Loktantrik Rajniti

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '2bb7b971-2110-4727-bb5c-d9bd19dc5845', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Loktantrik Rajniti', 
        'Social Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Social Science - Mashiyat

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '9c5dce49-fe5e-40c5-a965-91ee2cc904ec', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Mashiyat', 
        'Social Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Mathematics - Mathematics

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '83b0c8a5-d147-489c-9476-710786e7816e', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Mathematics', 
        'Mathematics', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 English - Moments Supplimentary Reader

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '525a333f-e10e-4b1c-bb92-a5bae6cc3a63', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Moments Supplimentary Reader', 
        'English', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Urdu - Nawa-e-Urdu

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'd490b38b-57cf-4237-aeac-02d0281b0f25', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Nawa-e-Urdu', 
        'Urdu', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Mathematics - Riyazi (Urdu)

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Riyazi (Urdu)', 
        'Mathematics', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Urdu - Sab Rang

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '40876cd6-eb50-4f47-a725-24768069f32a', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Sab Rang', 
        'Urdu', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Social Science - Samkalin Bharat

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '654dfc88-9bab-43f8-afff-8149a27198b8', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Samkalin Bharat', 
        'Social Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Hindi - Sanchayan

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '58f46c74-85ec-4ead-8f6f-0b4536a06572', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Sanchayan', 
        'Hindi', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Science - Science

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '4fd71e43-7518-4ff2-93d9-909724ef477c', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Science', 
        'Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Science - Science (Urdu)

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '58cbff8b-1729-43f1-8a1b-901c17020e89', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Science (Urdu)', 
        'Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Sanskrit - Shemushi Prathmo Bhag

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'bf6fcffd-8488-4d66-ae17-b578fd0b33d0', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Shemushi Prathmo Bhag', 
        'Sanskrit', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Vocational - Solanaceous Crop Cultivator

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '3942448a-1d2a-4f1c-aa33-5789121dacf8', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Solanaceous Crop Cultivator', 
        'Vocational', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Hindi - Sprash

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'a6c1011a-13fa-4973-97f3-8bbcddefec15', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Sprash', 
        'Hindi', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Vocational - Store Operations Assistant

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'a542dd62-f610-4506-b37d-d42f69c34ed9', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Store Operations Assistant', 
        'Vocational', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Urdu - Urdu ki Adabi Asnaf

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Urdu ki Adabi Asnaf', 
        'Urdu', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Science - Vigyan

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Vigyan', 
        'Science', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 Sanskrit - Vyakaranavithi

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '57631347-868f-45c2-a1ac-a7ea38c94564', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Vyakaranavithi', 
        'Sanskrit', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

-- Inserting Book: Class 9 English - Words and Expressions

    INSERT INTO public.books (id, org_id, uploaded_by, title, subject, class, language, source, metadata) 
    VALUES (
        '766e82da-44b0-4957-bcd3-80b9d686dc22', 
        NULL, -- NCERT books are shared (org_id is NULL)
        system_user_id, 
        'Words and Expressions', 
        'English', 
        9, 
        'English', 
        'ncert',
        '{ "edition": "2024-25" }'
    );
    

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '40ff471c-f339-44ad-a084-c72cd434678d', 
            '97915358-c7d8-438c-a9a2-c1c1c1d50418', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0959-Beehive%20English%20Textbook/iebe101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8855b6cd-db63-4deb-96f0-32d213e6c2a4', 
            '97915358-c7d8-438c-a9a2-c1c1c1d50418', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0959-Beehive%20English%20Textbook/iebe102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8d8160f3-7212-4a50-8a88-adef6499a8b9', 
            '97915358-c7d8-438c-a9a2-c1c1c1d50418', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0959-Beehive%20English%20Textbook/iebe103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1020c8da-9c79-4ddf-88ba-09a1697dfd0a', 
            '97915358-c7d8-438c-a9a2-c1c1c1d50418', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0959-Beehive%20English%20Textbook/iebe104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'eaa26acd-6d46-40f2-ad04-aa5efc07ebb2', 
            '97915358-c7d8-438c-a9a2-c1c1c1d50418', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0959-Beehive%20English%20Textbook/iebe105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ec647587-ba3d-4c12-a73b-8e5ff13a8e3d', 
            '97915358-c7d8-438c-a9a2-c1c1c1d50418', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0959-Beehive%20English%20Textbook/iebe106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '327188a6-dafb-40fb-ad33-9025690b6f47', 
            '97915358-c7d8-438c-a9a2-c1c1c1d50418', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0959-Beehive%20English%20Textbook/iebe107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '942513a1-49a5-4723-bcc4-b8dd5ffb5c92', 
            '97915358-c7d8-438c-a9a2-c1c1c1d50418', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0959-Beehive%20English%20Textbook/iebe108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0bba6542-1423-4b55-a061-723a05cb43cf', 
            '97915358-c7d8-438c-a9a2-c1c1c1d50418', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0959-Beehive%20English%20Textbook/iebe109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4c316c90-6f55-406a-b7c1-d674cbcbb254', 
            '525a333f-e10e-4b1c-bb92-a5bae6cc3a63', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0960-Moments-English%20Suppl.%20Reader%20Course-B/iemo101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f48ab913-af92-4a0e-a4d7-c8e6938de776', 
            '525a333f-e10e-4b1c-bb92-a5bae6cc3a63', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0960-Moments-English%20Suppl.%20Reader%20Course-B/iemo102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a8aeadf1-19f8-48f5-a989-acc31c874a67', 
            '525a333f-e10e-4b1c-bb92-a5bae6cc3a63', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0960-Moments-English%20Suppl.%20Reader%20Course-B/iemo103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c7334521-5577-4107-b489-cc3640f72bef', 
            '525a333f-e10e-4b1c-bb92-a5bae6cc3a63', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0960-Moments-English%20Suppl.%20Reader%20Course-B/iemo104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '67cc44da-703c-4e5b-82b0-5614bfa6ed12', 
            '525a333f-e10e-4b1c-bb92-a5bae6cc3a63', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0960-Moments-English%20Suppl.%20Reader%20Course-B/iemo105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'df63f895-ec05-4cfe-a8ba-f2f55f455437', 
            '525a333f-e10e-4b1c-bb92-a5bae6cc3a63', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0960-Moments-English%20Suppl.%20Reader%20Course-B/iemo106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '242deffe-b777-4ae6-ae85-c636dfc2cd82', 
            '525a333f-e10e-4b1c-bb92-a5bae6cc3a63', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0960-Moments-English%20Suppl.%20Reader%20Course-B/iemo107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5b9622f2-70af-476b-b361-003c4f44c442', 
            '525a333f-e10e-4b1c-bb92-a5bae6cc3a63', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0960-Moments-English%20Suppl.%20Reader%20Course-B/iemo108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd21a0ac6-7c9b-4003-b7e9-bb72d567f988', 
            '525a333f-e10e-4b1c-bb92-a5bae6cc3a63', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0960-Moments-English%20Suppl.%20Reader%20Course-B/iemo109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5c66a7a6-7352-476c-bf84-7c54a46f785e', 
            '766e82da-44b0-4957-bcd3-80b9d686dc22', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0976Words%20and%20Expressions/iewe101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cb98b1a2-1390-4430-8aba-fda9600c67fd', 
            '766e82da-44b0-4957-bcd3-80b9d686dc22', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0976Words%20and%20Expressions/iewe102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5632eba5-18ef-4c00-8a18-2205262fdd54', 
            '766e82da-44b0-4957-bcd3-80b9d686dc22', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0976Words%20and%20Expressions/iewe103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cac85088-9b60-49f6-bfbb-7e2bffcdcd82', 
            '766e82da-44b0-4957-bcd3-80b9d686dc22', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0976Words%20and%20Expressions/iewe104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '563bded7-e774-4dd4-ba73-638badca85d4', 
            '766e82da-44b0-4957-bcd3-80b9d686dc22', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0976Words%20and%20Expressions/iewe105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f049eb3b-0bb8-4982-8415-316397d128e3', 
            '766e82da-44b0-4957-bcd3-80b9d686dc22', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0976Words%20and%20Expressions/iewe106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3a7e985d-6ab3-46c0-9387-67371f1af5b8', 
            '766e82da-44b0-4957-bcd3-80b9d686dc22', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0976Words%20and%20Expressions/iewe107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '15ded707-2ece-4389-b288-5f1278e56801', 
            '766e82da-44b0-4957-bcd3-80b9d686dc22', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0976Words%20and%20Expressions/iewe108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b42ce63c-5fd1-4ae2-a508-0f3de53b3e40', 
            '766e82da-44b0-4957-bcd3-80b9d686dc22', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0976Words%20and%20Expressions/iewe109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e8c8e493-6a81-4eb3-90ef-856610485dc5', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2b19db4b-d6f8-4265-8ec7-a3acf5209793', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0e3e1725-9172-487d-bc28-70fbe4a624bd', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '49283929-ebd2-4172-93ff-947ddb59b407', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9659990d-d17b-47dc-a54e-33ea15b622a3', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '21057153-f573-45f7-a1c1-522558c052c3', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '29455167-b769-49fd-a2ec-124c5e85bb33', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8cbf3bbc-38b4-4bec-a902-fe4e15131919', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'bb945b8a-8e18-4172-9a63-d2f5153757cf', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '295fe094-8739-4a78-aad0-10c48798367b', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a61a7b8d-a180-4f44-a7a3-420a5cd817b2', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c1bad371-9412-4393-97ca-04ef91dcd39a', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '919de04c-94a2-43b1-94f8-edcce158acd2', 
            '6f4b391d-0fb0-4199-80df-dea96ac154d9', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0955-Kshitiz%20Bhag-1/ihks113/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4eb801a1-940b-4599-acf9-246dc9cb51e2', 
            'a6c1011a-13fa-4973-97f3-8bbcddefec15', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0957-Sparsh%20Bhag-1/ihsp101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ae0eaf00-a686-4acf-abef-88d223a8160d', 
            'a6c1011a-13fa-4973-97f3-8bbcddefec15', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0957-Sparsh%20Bhag-1/ihsp102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6affabc2-f8db-45c3-a3a5-4fe1d3f95a2d', 
            'a6c1011a-13fa-4973-97f3-8bbcddefec15', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0957-Sparsh%20Bhag-1/ihsp103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e10d209c-85d6-4d28-81bc-77df7b59253e', 
            'a6c1011a-13fa-4973-97f3-8bbcddefec15', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0957-Sparsh%20Bhag-1/ihsp104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0f052deb-8c39-42b4-ab4a-e530ec9a788a', 
            'a6c1011a-13fa-4973-97f3-8bbcddefec15', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0957-Sparsh%20Bhag-1/ihsp105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c141747b-f115-4841-a02a-231357cade5a', 
            'a6c1011a-13fa-4973-97f3-8bbcddefec15', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0957-Sparsh%20Bhag-1/ihsp106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e96efed0-8ae7-4631-9d94-73e67a845c07', 
            'a6c1011a-13fa-4973-97f3-8bbcddefec15', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0957-Sparsh%20Bhag-1/ihsp107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1c0d6a2b-c0ff-4c54-83d3-9eabe5acc42f', 
            'a6c1011a-13fa-4973-97f3-8bbcddefec15', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0957-Sparsh%20Bhag-1/ihsp108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1c09f129-9a2d-4504-a86f-2774bca1d1f9', 
            'a6c1011a-13fa-4973-97f3-8bbcddefec15', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0957-Sparsh%20Bhag-1/ihsp109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '69cad3ac-be5c-4a6d-b6c1-6f1367007d4f', 
            'a6c1011a-13fa-4973-97f3-8bbcddefec15', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0957-Sparsh%20Bhag-1/ihsp110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '36d93f36-c0ca-4556-8e28-d73e2f9d7b8c', 
            'd887596f-8847-4d8f-b52a-93cb564e9383', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0956-Kritika%20Bhag-1/ihkr101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '17f5d185-a00c-479d-a2fa-3703432e0040', 
            'd887596f-8847-4d8f-b52a-93cb564e9383', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0956-Kritika%20Bhag-1/ihkr102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0fed7b08-242d-455b-8f13-7d22ef34915b', 
            'd887596f-8847-4d8f-b52a-93cb564e9383', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0956-Kritika%20Bhag-1/ihkr103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '19a327d3-c26a-4deb-9d18-dca19b887cf1', 
            '58f46c74-85ec-4ead-8f6f-0b4536a06572', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0958-Sanchayan%20Bhg-1/ihsa101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3a4db49f-e86b-470b-b676-81759193a902', 
            '58f46c74-85ec-4ead-8f6f-0b4536a06572', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0958-Sanchayan%20Bhg-1/ihsa102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8a23cff0-2137-42be-a882-438eeae23b85', 
            '58f46c74-85ec-4ead-8f6f-0b4536a06572', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0958-Sanchayan%20Bhg-1/ihsa103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2e1b2734-8633-4f9e-ae18-5f820ef54e1e', 
            '58f46c74-85ec-4ead-8f6f-0b4536a06572', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0958-Sanchayan%20Bhg-1/ihsa104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd9bdacac-ed3c-40de-84fe-ab06f4f5599c', 
            'bf6fcffd-8488-4d66-ae17-b578fd0b33d0', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0961-Shemusi%20-%20Sanskrit/ihsh101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '59cbc2a2-09dd-4b9f-b9ff-15047a612087', 
            'bf6fcffd-8488-4d66-ae17-b578fd0b33d0', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0961-Shemusi%20-%20Sanskrit/ihsh102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd22e7688-620a-4818-b7f3-22852a7a701b', 
            'bf6fcffd-8488-4d66-ae17-b578fd0b33d0', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0961-Shemusi%20-%20Sanskrit/ihsh103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '99ae5a3b-00b4-4140-809e-0027a2243483', 
            'bf6fcffd-8488-4d66-ae17-b578fd0b33d0', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0961-Shemusi%20-%20Sanskrit/ihsh104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1a3730fa-cb08-4db5-ad76-e732e50a785b', 
            'bf6fcffd-8488-4d66-ae17-b578fd0b33d0', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0961-Shemusi%20-%20Sanskrit/ihsh105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ea41d84b-c3e8-40fc-b737-ef1339415bff', 
            'bf6fcffd-8488-4d66-ae17-b578fd0b33d0', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0961-Shemusi%20-%20Sanskrit/ihsh106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e912a10a-5ef8-438c-950a-01ad8636cab2', 
            'bf6fcffd-8488-4d66-ae17-b578fd0b33d0', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0961-Shemusi%20-%20Sanskrit/ihsh107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '81238418-a836-402b-b84a-d9bb3e337d61', 
            'bf6fcffd-8488-4d66-ae17-b578fd0b33d0', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0961-Shemusi%20-%20Sanskrit/ihsh108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3435372b-d423-4b4d-b618-f43fac072d98', 
            'bf6fcffd-8488-4d66-ae17-b578fd0b33d0', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0961-Shemusi%20-%20Sanskrit/ihsh109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9deaa4f1-6fa6-4ab1-851a-8964503b144d', 
            'bf6fcffd-8488-4d66-ae17-b578fd0b33d0', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0961-Shemusi%20-%20Sanskrit/ihsh110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a527aaeb-3fe5-467a-b32c-56f410ec17e6', 
            '57631347-868f-45c2-a1ac-a7ea38c94564', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '18e21bd5-dbec-4094-8e8f-12d1ba38171c', 
            '57631347-868f-45c2-a1ac-a7ea38c94564', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c6af0561-cd53-46c6-a64c-779ff79ee61d', 
            '57631347-868f-45c2-a1ac-a7ea38c94564', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5ff64735-a468-46ce-b3fe-517f91657bd4', 
            '57631347-868f-45c2-a1ac-a7ea38c94564', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7c526acd-f4cc-4d8f-85ea-6166189e42b8', 
            '57631347-868f-45c2-a1ac-a7ea38c94564', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '93573cea-1e8c-476f-a66f-807355842046', 
            '57631347-868f-45c2-a1ac-a7ea38c94564', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '512bfed8-13a1-43e1-93f6-d02465d471ff', 
            '57631347-868f-45c2-a1ac-a7ea38c94564', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '08636ab3-a5ad-419f-92f6-754bc1fc1655', 
            '57631347-868f-45c2-a1ac-a7ea38c94564', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '394b8214-4571-461c-bf5b-719011b1cc9a', 
            '57631347-868f-45c2-a1ac-a7ea38c94564', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ef24c875-54eb-472b-a98f-4f604c9e4d34', 
            '57631347-868f-45c2-a1ac-a7ea38c94564', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6ff24e8b-c96e-4839-8736-ed47bd35485b', 
            '57631347-868f-45c2-a1ac-a7ea38c94564', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f626025a-a6dd-4914-a747-5ebfed4d9c65', 
            '57631347-868f-45c2-a1ac-a7ea38c94564', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '51f66295-73f5-4f51-b27c-3e9d5beafa7c', 
            'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0975Abhyaswaan%20Bhav/isab101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6354106d-54ab-4248-ac4a-064e79130929', 
            'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0975Abhyaswaan%20Bhav/isab102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3bf92c67-5e2d-47da-b1b2-2179a76f7bfd', 
            'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0975Abhyaswaan%20Bhav/isab103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1b6d2471-9af5-4a6b-9118-e172546faab5', 
            'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0975Abhyaswaan%20Bhav/isab104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e83768fb-34b3-48a8-918e-91e35373c2a4', 
            'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0975Abhyaswaan%20Bhav/isab105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'bda44678-d806-46f5-9c83-075762e82f4d', 
            'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0975Abhyaswaan%20Bhav/isab106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2a5260ad-6554-496b-8e23-98d5cf61fc64', 
            'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0975Abhyaswaan%20Bhav/isab107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b23e1b3b-caff-47f7-83d7-20332c8d28ab', 
            'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0975Abhyaswaan%20Bhav/isab108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a503b6cc-5bdd-42e6-8dc7-ae39d16ecafa', 
            'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0975Abhyaswaan%20Bhav/isab109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '817c9611-6524-4ab2-83d2-9456f26e7a10', 
            'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0975Abhyaswaan%20Bhav/isab110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd5d80434-8831-4d13-b207-0e2304b4f9e6', 
            'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0975Abhyaswaan%20Bhav/isab111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'eddf79b2-7722-4125-ac51-3b3ed415bf52', 
            'd0d8bdb2-b9a9-45cb-96a4-02a2bff8af20', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0975Abhyaswaan%20Bhav/isab112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd6a2d931-1f6f-47eb-9185-9c8ac3d1750c', 
            '83b0c8a5-d147-489c-9476-710786e7816e', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0962-Mathematics/iemh101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e937f0dc-bb97-433a-bc5a-38b5556ddb99', 
            '83b0c8a5-d147-489c-9476-710786e7816e', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0962-Mathematics/iemh102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4d118648-80a4-43de-bd02-9b9cdb26892a', 
            '83b0c8a5-d147-489c-9476-710786e7816e', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0962-Mathematics/iemh103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '26b827ce-eb43-4038-b7da-bf59120c0dc6', 
            '83b0c8a5-d147-489c-9476-710786e7816e', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0962-Mathematics/iemh104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5759a300-4d81-4ace-b30c-45465cb158ec', 
            '83b0c8a5-d147-489c-9476-710786e7816e', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0962-Mathematics/iemh105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '64805584-2e6b-44e2-858a-c26ce7850b73', 
            '83b0c8a5-d147-489c-9476-710786e7816e', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0962-Mathematics/iemh106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2b7a49a1-f558-4d96-9ea4-99c77b955e56', 
            '83b0c8a5-d147-489c-9476-710786e7816e', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0962-Mathematics/iemh107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a7508f79-8c81-4b93-9532-0815526a2fa8', 
            '83b0c8a5-d147-489c-9476-710786e7816e', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0962-Mathematics/iemh108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd3208580-925c-4aa1-8b47-1bc4ab8b2032', 
            '83b0c8a5-d147-489c-9476-710786e7816e', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0962-Mathematics/iemh109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd2c03c9b-b8d4-4bcc-8a2d-e9116600257d', 
            '83b0c8a5-d147-489c-9476-710786e7816e', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0962-Mathematics/iemh110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '13b5da6b-7306-4f31-a4c5-b81e8a4e463b', 
            '83b0c8a5-d147-489c-9476-710786e7816e', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0962-Mathematics/iemh111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2ebeda38-a9d7-411a-bb82-26c9063f0666', 
            '83b0c8a5-d147-489c-9476-710786e7816e', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0962-Mathematics/iemh112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6d93dc4f-f039-4502-9de8-e2e0bf336233', 
            'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0963-Ganit/ihmh101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8c2c13dc-4809-4ccc-8a7e-9b68b423484f', 
            'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0963-Ganit/ihmh102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '072b51c5-dd19-426e-9fe1-749dde224938', 
            'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0963-Ganit/ihmh103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '869597f7-83bb-44d7-9279-a0ba2d69e812', 
            'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0963-Ganit/ihmh104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '78d2c6a0-8a05-4376-bd2a-965944c8672e', 
            'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0963-Ganit/ihmh105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c64530ce-94a0-4fbf-aec2-9978bdb7c9b9', 
            'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0963-Ganit/ihmh106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0f8a5a31-0451-449d-9781-1f67b96b3ed1', 
            'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0963-Ganit/ihmh107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7804a35c-3fec-47e6-9ddb-4b781f02a473', 
            'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0963-Ganit/ihmh108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'befeba78-559f-4d61-815d-cbac18c7c185', 
            'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0963-Ganit/ihmh109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '662842b4-5e88-409a-b95f-8496518a23ac', 
            'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0963-Ganit/ihmh110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e3258476-6276-4d33-a288-958b093df3d1', 
            'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0963-Ganit/ihmh111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '56d30ca2-e6f8-4d76-9042-4a7b73ef8770', 
            'dfdade85-86b3-40f6-acb3-b9ad28511e7f', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0963-Ganit/ihmh112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1bb2224f-e9f6-438f-b5eb-4930f8e1afed', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_01', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a19b7cd4-d078-4123-b929-f361664afe65', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_02', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '147359eb-972c-4428-acc5-161787eadba6', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_03', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cb68fe4c-6237-440e-8b1e-ae4f086cc6c2', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_04', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '39c6ddbb-2028-44c4-a7b9-725fc6e7c939', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_05', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4454bdbf-c122-4be3-bbd6-ea1720996410', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_06', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1e598a39-400c-4293-bb63-52c93ece6859', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_07', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7703174f-eebc-403d-ab7a-a9ca7ecec0f7', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_08', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f8259248-cda3-4a0d-8045-85c82c781a9f', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_09', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9b0498d1-5f92-428a-bca9-9412f853ac34', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_10', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9f024b5f-acf2-4981-8108-7e4ae2c4205c', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_11', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '80c29dda-95ec-4e06-a15f-3f9a60957da8', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_12', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '232a45d6-2c83-46b6-88cc-8ce61ee3b2ca', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_13', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '854c492c-9935-4022-8af6-f549fb58ee44', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_14', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8edd9d94-953b-47c2-9fd1-9f07123f385b', 
            '7225aa14-07fc-4b51-9e16-bc6e60370e39', 
            '» Chapter 15', 
            15, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4915-RIYAZI/Ch_15', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3e3730b6-42af-4ce8-9a43-f9301f135215', 
            '4fd71e43-7518-4ff2-93d9-909724ef477c', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0964-Science/iesc101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9ca23c14-3b39-4c9e-bf24-ae460d27433c', 
            '4fd71e43-7518-4ff2-93d9-909724ef477c', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0964-Science/iesc102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '808ac230-9770-4005-b756-3b34382f0a88', 
            '4fd71e43-7518-4ff2-93d9-909724ef477c', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0964-Science/iesc103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '63b90618-afa1-4e7b-8378-f2b3756f2883', 
            '4fd71e43-7518-4ff2-93d9-909724ef477c', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0964-Science/iesc104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b5f0f444-4b66-4b72-8925-cae8d550acfd', 
            '4fd71e43-7518-4ff2-93d9-909724ef477c', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0964-Science/iesc105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '32775e94-b907-433f-b235-0e388d228555', 
            '4fd71e43-7518-4ff2-93d9-909724ef477c', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0964-Science/iesc106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7c0d8af4-587e-4458-a53a-de6b3d5b1b3f', 
            '4fd71e43-7518-4ff2-93d9-909724ef477c', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0964-Science/iesc107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5a89ea0e-6171-4257-9c0d-7e9ec437e51a', 
            '4fd71e43-7518-4ff2-93d9-909724ef477c', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0964-Science/iesc108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'acee1f75-1a4a-43b1-bd79-843c952d062b', 
            '4fd71e43-7518-4ff2-93d9-909724ef477c', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0964-Science/iesc109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1c759a1c-fd03-42ab-a2ec-d9be98c82ad2', 
            '4fd71e43-7518-4ff2-93d9-909724ef477c', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0964-Science/iesc110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a10840ac-0bc9-4e32-9965-f4159d5a6de0', 
            '4fd71e43-7518-4ff2-93d9-909724ef477c', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0964-Science/iesc111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c88e0efb-873f-490e-9599-304c551baca4', 
            '4fd71e43-7518-4ff2-93d9-909724ef477c', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0964-Science/iesc112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ae73ca5d-fb61-45fb-86a7-b7008df76021', 
            'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0965-Vigyan/ihsc101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cce3ef0d-ffe6-4ec0-acd5-d8c152ace4ee', 
            'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0965-Vigyan/ihsc102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b823cea1-c1e2-4392-ab61-6b343272668e', 
            'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0965-Vigyan/ihsc103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b2faf675-8aef-45d6-9d54-ff808d06bd10', 
            'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0965-Vigyan/ihsc104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3efcd065-8a08-41db-97d8-d4c75322533a', 
            'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0965-Vigyan/ihsc105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'dd2d25ef-46d9-480f-aea3-e7963ae7c08d', 
            'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0965-Vigyan/ihsc106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd6c43001-094e-4ad5-8941-52fedebbe093', 
            'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0965-Vigyan/ihsc107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9d894cd8-a7a4-4b9b-a7d4-50681f8ea495', 
            'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0965-Vigyan/ihsc108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1e53d84d-492a-461e-9afd-fc8c92b5682b', 
            'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0965-Vigyan/ihsc109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3115c36c-b8f3-4e69-9cd1-a37bb5ba47ed', 
            'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0965-Vigyan/ihsc110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '637ae7d4-18cf-49fa-b887-b667c0255975', 
            'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0965-Vigyan/ihsc111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a1b0b8ca-f45a-4cbc-911a-fb4d0cd6a2d3', 
            'a1f5ea9d-35d1-4245-860e-7b7e5c882846', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0965-Vigyan/ihsc112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'edbd11f3-a716-47a5-959d-1c75168da8eb', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter1/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '55c1b2b0-2e8f-484f-a305-8ac45401a2ee', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter2/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9c1c9d94-dbd2-48b9-a046-dbe60338bd83', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter3/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c2f48fa2-0dd0-4cb1-a4ab-3d38cab68292', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter4/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a21dc85d-c921-477f-bd52-aff1bb560375', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter5/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'dcb3c815-f185-4b0c-85e1-06d7b4c9595a', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter6/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '850ddbe4-3251-4145-ba0e-c436192e4530', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter7/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '756c41ab-2d5a-41e4-b749-5ef0ad06f098', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter8/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3c5f4936-4855-47b1-8b2a-5e8c3cf0729a', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter9/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9a059d8e-83c9-4305-bf60-c32a58660868', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter10/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c523c6d4-3629-44bb-9105-ed79576e1480', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter11/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cfc3ac2e-b6d6-4baa-9fde-ba13b4ca2af5', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter12/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4f960c0a-db93-486c-b61c-e28b2c48f389', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter13/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cb7a100b-20a8-49f4-bcb7-562dbb43b7f0', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter14/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '45df0f50-a36c-414a-ad12-a734c8497706', 
            '58cbff8b-1729-43f1-8a1b-901c17020e89', 
            '» Chapter 15', 
            15, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4916Science/chapter15/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f1a88e8d-e719-4b1f-9a00-6507d1ebf35e', 
            '6052c40e-db77-4d28-9326-ff133d7f7dc8', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0972-Democratic%20Poltics/iess401/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4e4ec0d8-fd41-40da-a193-14c95a2bc7d4', 
            '6052c40e-db77-4d28-9326-ff133d7f7dc8', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0972-Democratic%20Poltics/iess402/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0915d57f-11e2-46d4-965b-1b9678163330', 
            '6052c40e-db77-4d28-9326-ff133d7f7dc8', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0972-Democratic%20Poltics/iess403/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a97681a6-f0b8-49ec-bb9b-41198e5483fe', 
            '6052c40e-db77-4d28-9326-ff133d7f7dc8', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0972-Democratic%20Poltics/iess404/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd0bdc5ac-0e90-4e41-a9ea-3ff84a2dea98', 
            '6052c40e-db77-4d28-9326-ff133d7f7dc8', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0972-Democratic%20Poltics/iess405/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1af5214a-de2d-4c0c-bd12-80bad77a070c', 
            '2bb7b971-2110-4727-bb5c-d9bd19dc5845', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0973-Loktantrik%20Rajniti/ihss401/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '15366764-c971-431e-9322-8dd8743e35db', 
            '2bb7b971-2110-4727-bb5c-d9bd19dc5845', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0973-Loktantrik%20Rajniti/ihss402/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b1f51250-84d4-46fb-8c6b-75b449276fb3', 
            '2bb7b971-2110-4727-bb5c-d9bd19dc5845', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0973-Loktantrik%20Rajniti/ihss403/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0570d6d0-62fc-4b59-82e0-c835e994f2ac', 
            '2bb7b971-2110-4727-bb5c-d9bd19dc5845', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0973-Loktantrik%20Rajniti/ihss404/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'fafbe3cd-5868-47e2-a9df-6e1be1fc9dc8', 
            '2bb7b971-2110-4727-bb5c-d9bd19dc5845', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0973-Loktantrik%20Rajniti/ihss405/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f65eaf18-643f-4577-8917-1998988af266', 
            'f0390baf-242c-4440-bb98-aeaf69ec75bc', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0968-ContemporaryIndiaIGeography/iess101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2a74c828-8325-4f1a-bda4-9d5b21723ee3', 
            'f0390baf-242c-4440-bb98-aeaf69ec75bc', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0968-ContemporaryIndiaIGeography/iess102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0a093926-83b1-4a56-8e93-84e5c5706ad5', 
            'f0390baf-242c-4440-bb98-aeaf69ec75bc', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0968-ContemporaryIndiaIGeography/iess103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c6001fc1-83be-4f52-8771-62fd23d09c8c', 
            'f0390baf-242c-4440-bb98-aeaf69ec75bc', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0968-ContemporaryIndiaIGeography/iess104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e30346c6-964b-4cdf-87ce-f1596d6e15ef', 
            'f0390baf-242c-4440-bb98-aeaf69ec75bc', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0968-ContemporaryIndiaIGeography/iess105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6c053c64-5eb1-47af-8919-4f7f499ca71b', 
            'f0390baf-242c-4440-bb98-aeaf69ec75bc', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0968-ContemporaryIndiaIGeography/iess106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '030aa709-422e-43ea-8c6b-d36690c53982', 
            '654dfc88-9bab-43f8-afff-8149a27198b8', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0969-Samkalin%20Bharat%20-%20Bhugol/ihss101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '91f7a0f1-cb3d-4fd0-83af-a18d3426924f', 
            '654dfc88-9bab-43f8-afff-8149a27198b8', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0969-Samkalin%20Bharat%20-%20Bhugol/ihss102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e638677c-c916-4e04-9082-ea56040c3976', 
            '654dfc88-9bab-43f8-afff-8149a27198b8', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0969-Samkalin%20Bharat%20-%20Bhugol/ihss103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '824d3324-b3c1-445d-abee-0201457d42ff', 
            '654dfc88-9bab-43f8-afff-8149a27198b8', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0969-Samkalin%20Bharat%20-%20Bhugol/ihss104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'fa1868b8-9d2f-4bda-aecb-0c0d01bf8590', 
            '654dfc88-9bab-43f8-afff-8149a27198b8', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0969-Samkalin%20Bharat%20-%20Bhugol/ihss105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7d2a7218-73cd-48a7-adf6-271f6023a3ab', 
            '654dfc88-9bab-43f8-afff-8149a27198b8', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0969-Samkalin%20Bharat%20-%20Bhugol/ihss106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'fca268bb-880a-414c-b362-80149191c409', 
            '04b0b71f-24b2-4e58-a26f-c847e3a49a1e', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0971-Arthashastra/ihss201/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '88b127a6-985c-47db-bc72-10db47bd7ab4', 
            '04b0b71f-24b2-4e58-a26f-c847e3a49a1e', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0971-Arthashastra/ihss202/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '335b9f75-af49-49b2-a144-85ea71899672', 
            '04b0b71f-24b2-4e58-a26f-c847e3a49a1e', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0971-Arthashastra/ihss203/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1afb5b91-24d1-4bee-bec6-3c6c647f7d50', 
            '04b0b71f-24b2-4e58-a26f-c847e3a49a1e', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0971-Arthashastra/ihss204/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '643efcbe-dd5d-4c66-a2c5-79bcd7b401de', 
            'ac9a29f5-aac5-44f0-9708-cc1760b32ced', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0970-Economics/iess201/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c08d770c-b7aa-48c0-a480-1dab1a95a483', 
            'ac9a29f5-aac5-44f0-9708-cc1760b32ced', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0970-Economics/iess202/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '86f6e6a8-891e-4c1d-929f-22608e2f7f3c', 
            'ac9a29f5-aac5-44f0-9708-cc1760b32ced', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0970-Economics/iess203/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f26af30c-2f8b-4b2b-a3b8-4bdd642f9cad', 
            'ac9a29f5-aac5-44f0-9708-cc1760b32ced', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0970-Economics/iess204/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3d9ebbcc-9c0f-4e14-8051-5da1453d608a', 
            '00d0a392-c10c-4810-ae1a-45f8c35ba2dd', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0966-Indian%20and%20the%20Contemporary%20World-%20History/iess301/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c45df686-d446-415c-a16e-05d2ddb8946b', 
            '00d0a392-c10c-4810-ae1a-45f8c35ba2dd', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0966-Indian%20and%20the%20Contemporary%20World-%20History/iess302/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '49dbcaec-a7cb-4216-8810-4f6f564ed7fa', 
            '00d0a392-c10c-4810-ae1a-45f8c35ba2dd', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0966-Indian%20and%20the%20Contemporary%20World-%20History/iess303/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '72500504-9a2b-466e-ad65-12fcd9acf85d', 
            '00d0a392-c10c-4810-ae1a-45f8c35ba2dd', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0966-Indian%20and%20the%20Contemporary%20World-%20History/iess304/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '113b3ad2-2944-4824-8f06-0a008c8a3bfa', 
            '00d0a392-c10c-4810-ae1a-45f8c35ba2dd', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0966-Indian%20and%20the%20Contemporary%20World-%20History/iess305/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2939a9e5-c2b1-421c-8333-9adb0d77085d', 
            'f3a910d2-9c28-4add-b763-14d32be7da54', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0967-Bharat%20Aur%20Samkalin%20Viswa-Itihas/ihss301/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e19a0c2e-073b-46ba-855c-e504df1aef3d', 
            'f3a910d2-9c28-4add-b763-14d32be7da54', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0967-Bharat%20Aur%20Samkalin%20Viswa-Itihas/ihss302/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f092a8ca-f61c-4a24-a28a-81307b063adc', 
            'f3a910d2-9c28-4add-b763-14d32be7da54', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0967-Bharat%20Aur%20Samkalin%20Viswa-Itihas/ihss303/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7805f066-d398-441e-bf03-572a7a84d56b', 
            'f3a910d2-9c28-4add-b763-14d32be7da54', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0967-Bharat%20Aur%20Samkalin%20Viswa-Itihas/ihss304/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8a0d659a-ac10-40d2-82d1-fcc9affc13e3', 
            'f3a910d2-9c28-4add-b763-14d32be7da54', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/0967-Bharat%20Aur%20Samkalin%20Viswa-Itihas/ihss305/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4f48ea53-4d66-470b-a893-ada1609c5fb2', 
            '7aebdbdb-70ab-40c5-88ca-cf541ab1455c', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4921-Jamhoori%20Siyaasat/Chap-01', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7f78d0a7-a546-4bcb-9c44-8b1934752f39', 
            '7aebdbdb-70ab-40c5-88ca-cf541ab1455c', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4921-Jamhoori%20Siyaasat/Chap-02', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c33911ec-476a-4af2-9fbc-5318914d38e0', 
            '7aebdbdb-70ab-40c5-88ca-cf541ab1455c', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4921-Jamhoori%20Siyaasat/Chap-03', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '04e98eae-0062-407e-9a8f-4dd88af2ce60', 
            '7aebdbdb-70ab-40c5-88ca-cf541ab1455c', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4921-Jamhoori%20Siyaasat/Chap-04', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '14cfe229-4a2e-42a6-81b2-96d7719a6227', 
            '7aebdbdb-70ab-40c5-88ca-cf541ab1455c', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4921-Jamhoori%20Siyaasat/Chap-05', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ddd6b90e-6007-4d86-827f-8842411ec42d', 
            '7aebdbdb-70ab-40c5-88ca-cf541ab1455c', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4921-Jamhoori%20Siyaasat/Chap-06', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2ed90323-0574-4a64-9db8-daef91a4411f', 
            'f98220eb-5e20-4346-aa9e-e55ab24cd766', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4917-Hindustan%20Aur%20Asri%20Duniya-I/iuhi101', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '756c33b2-2a06-45d7-bc23-63d19c5e1919', 
            'f98220eb-5e20-4346-aa9e-e55ab24cd766', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4917-Hindustan%20Aur%20Asri%20Duniya-I/iuhi102', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '752da179-b815-4ba7-95c0-f7321739ae28', 
            'f98220eb-5e20-4346-aa9e-e55ab24cd766', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4917-Hindustan%20Aur%20Asri%20Duniya-I/iuhi103', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '128d07f7-dce0-4251-b7fc-87df86c4246e', 
            'f98220eb-5e20-4346-aa9e-e55ab24cd766', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4917-Hindustan%20Aur%20Asri%20Duniya-I/iuhi104', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9d74abd9-ab38-4bd3-9cbe-ece7108d79e4', 
            'f98220eb-5e20-4346-aa9e-e55ab24cd766', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4917-Hindustan%20Aur%20Asri%20Duniya-I/iuhi105', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '16db01ea-6950-42a7-b772-5f1df3fe5eac', 
            'c4fbcad3-ac03-47e5-9b51-a6323563ed44', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4918-Asri%20Hindustan-I%20(Contemporary%20India-I)/iuss101', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0289b333-8c43-40f1-948d-dca76c7ef598', 
            'c4fbcad3-ac03-47e5-9b51-a6323563ed44', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4918-Asri%20Hindustan-I%20(Contemporary%20India-I)/iuss102', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd927dc4c-d379-4b7b-8fc0-0bcdb7d0ac4f', 
            'c4fbcad3-ac03-47e5-9b51-a6323563ed44', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4918-Asri%20Hindustan-I%20(Contemporary%20India-I)/iuss103', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '37c17b29-7c5f-4842-8dea-bb97989a0bf1', 
            'c4fbcad3-ac03-47e5-9b51-a6323563ed44', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4918-Asri%20Hindustan-I%20(Contemporary%20India-I)/iuss104', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4623a3bb-ecd7-4cab-9d8f-537e80ece534', 
            'c4fbcad3-ac03-47e5-9b51-a6323563ed44', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4918-Asri%20Hindustan-I%20(Contemporary%20India-I)/iuss105', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'fb701858-3df2-4919-ad1d-8a9ea0670329', 
            'c4fbcad3-ac03-47e5-9b51-a6323563ed44', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4918-Asri%20Hindustan-I%20(Contemporary%20India-I)/iuss106', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ca92bc32-138c-43e8-8754-02d4d8ba1e94', 
            '9c5dce49-fe5e-40c5-a965-91ee2cc904ec', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4919-Maashiyat%20(Economic)%20Class-IX_PDF/iuss201', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'dd939973-0e05-4418-bb94-df44099be4a8', 
            '9c5dce49-fe5e-40c5-a965-91ee2cc904ec', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4919-Maashiyat%20(Economic)%20Class-IX_PDF/iuss202', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0fd14de1-b0d4-40c8-ba0d-2091fe7b5d30', 
            '9c5dce49-fe5e-40c5-a965-91ee2cc904ec', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4919-Maashiyat%20(Economic)%20Class-IX_PDF/iuss203', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0550d18a-6b28-4a02-8b42-8ffd8fe1afc7', 
            '9c5dce49-fe5e-40c5-a965-91ee2cc904ec', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4919-Maashiyat%20(Economic)%20Class-IX_PDF/iuss204', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c5eb47af-9cc8-44c8-8a94-574d8530c0f0', 
            'e7b90851-ec06-444d-b079-63ac1e0b251e', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/l/sample/basic/index.php?tra=tiyhwlss101', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '44bfd140-f1d8-4927-a4d9-182bdfa03ded', 
            'e7b90851-ec06-444d-b079-63ac1e0b251e', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/l/sample/basic/index.php?tra=tiyhwlss102', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ad8d41a5-d326-47c4-9f0d-99727626bca3', 
            'e7b90851-ec06-444d-b079-63ac1e0b251e', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/l/sample/basic/index.php?tra=tiyhwlss103', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '00a073a7-bf78-457e-b10f-0078badf1f2b', 
            '40876cd6-eb50-4f47-a725-24768069f32a', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4924/Chap-01', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '370fddd0-0dae-4036-af34-2242966243b7', 
            '40876cd6-eb50-4f47-a725-24768069f32a', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4924/Chap-02', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd5f4c1fe-f472-487e-9cc1-a9ef25bcf64f', 
            '40876cd6-eb50-4f47-a725-24768069f32a', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4924/Chap-03', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ecde2608-e031-4cc3-b0b3-a6f9c1bbaa80', 
            '40876cd6-eb50-4f47-a725-24768069f32a', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4924/Chap-04', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8208642c-a8b8-4a3c-910a-4510775893cd', 
            '40876cd6-eb50-4f47-a725-24768069f32a', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4924/Chap-05', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '045e98ef-7e35-4180-a359-80710f7e2ff3', 
            '40876cd6-eb50-4f47-a725-24768069f32a', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4924/Chap-06', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f472254a-9fc7-4637-b3f1-65c534dbe627', 
            '40876cd6-eb50-4f47-a725-24768069f32a', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4924/Chap-07', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '91593b49-682f-4a4f-8223-2ef3f3a554f9', 
            '40876cd6-eb50-4f47-a725-24768069f32a', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4924/Chap-08', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8bebae2b-4aa3-48e2-b5e5-15729d064af1', 
            '40876cd6-eb50-4f47-a725-24768069f32a', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4924/Chap-09', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1a8ef283-a614-44e4-81b9-47cec7f3f371', 
            '40876cd6-eb50-4f47-a725-24768069f32a', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4924/Chap-10', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '78177732-7eb6-4a06-b946-823724013d9f', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau101', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ffa84d0c-e60f-47b4-af21-3d5f1e138372', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau102', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0afef4e8-5156-47c7-a9a3-1ee8fc3eaab2', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau103', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c512b039-af94-4870-bca0-9ee13638c8ba', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau104', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '77a86eed-a66a-401b-a486-f7c6d36a8b17', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau105', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f7455881-5bcc-4938-b5e1-68b142c8db72', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau106', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '155795a7-7475-4a61-ae47-33d2c27cc62e', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau107', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '103af106-ca4f-4a05-83da-7bfff698ceba', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau108', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f175bad4-5d53-4d65-ac7e-9c5e3a36cb0c', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau109', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a68c2d94-5817-4825-8393-99b4f1163bc2', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau110', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '42d41e4a-f7f7-4e73-a380-7075e2c4c618', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau111', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1e08719f-2a98-4e86-9530-4150b561f06f', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau112', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1914c186-3657-4d4a-a22b-3205f18a42a4', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau113', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'adb500dc-90ee-4741-ba1b-51fe7ef634c8', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau114', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '15f87858-0ac5-4a8a-b968-f25817a7985b', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 15', 
            15, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau115', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '007d6136-fc28-4e72-a922-e59e36c54482', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 16', 
            16, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau116', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cc347955-58f4-47a0-a17c-3f7ce74d0006', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 17', 
            17, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau117', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '96a8ed2d-86e7-4dd4-8c5e-a061fd40dbf8', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 18', 
            18, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau118', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cace67dd-f6f4-48e6-8619-c83bbb007e27', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 19', 
            19, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau119', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2cdac7df-d742-4ce9-b456-8e576ec2bbfc', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 20', 
            20, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau120', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'dff9bac5-c660-443f-b606-8c31754670ad', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 21', 
            21, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau121', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b452b5ca-4e23-4971-8c4c-8cb3c710ec3c', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 22', 
            22, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau122', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9ce2369d-73c7-4ab0-8b3e-47868b8ec46e', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 23', 
            23, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau123', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7fe95a7e-ff1c-4aea-9ec0-fa6c6a2fd956', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 24', 
            24, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau124', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '73027d1a-3f24-4bba-8cc2-90603b505dbb', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 25', 
            25, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau125', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e65cefb6-a4fd-491b-babb-d71975089905', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 26', 
            26, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau126', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '791bb3b0-2207-4408-83f7-10ff9fa9e4cd', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 27', 
            27, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau127', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '6dea2d8d-c43d-4ae9-8640-55f9b1911157', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 28', 
            28, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau128', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'fc6e1bb8-5c3e-4bf8-81d8-e56814895911', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 29', 
            29, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau129', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '730c846a-2346-4650-a083-362ed74d6579', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 30', 
            30, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau130', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e4ab30d4-f03d-4e09-9a56-6e4281982815', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 31', 
            31, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau131', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '97026fa5-98c4-48d2-a640-018cc8ab13a7', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 32', 
            32, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau132', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '41d7d64d-50a4-4a1c-a250-d4a7e1a001ac', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 33', 
            33, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau133', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '45321d1a-0a06-4b97-ab63-1c326a038b0c', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 34', 
            34, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau134', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e66f0472-658e-4b74-9ac0-cf0024c0a9ce', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 35', 
            35, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau135', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '39f97362-35dd-4de8-bc31-013a7dfe0361', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 36', 
            36, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau136', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2f3b7ea7-400d-4509-bc1a-86a6548b3e67', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 37', 
            37, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau137', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '712a5d67-e274-4695-9384-469468aa02bb', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 38', 
            38, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau138', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0a1d5ccd-9d47-40a5-86dc-44a0913b0e3d', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 39', 
            39, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau139', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '22ce4335-99bf-433a-bdf9-d2d80ae88edb', 
            'e559283f-9cf0-4666-ad42-fca858d7cfe0', 
            '» Chapter 40', 
            40, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4925-Urdu%20ki%20Adbi%20Asnaf/iuau140', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'eb604e45-fc36-4523-b5a5-7848d1713791', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-01', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '20effd47-93a4-4e9e-b283-abe61ddcb838', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-02', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ddc6b17a-fa24-4479-8aac-2e55bcb97ffb', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-03', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '57b1cd53-1840-447e-b307-236e6b2bf1df', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-04', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9841967b-7602-4d67-8998-a38c41274169', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-05', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4e1dcb16-cae4-4b31-a8d0-1dbcfd13e1f5', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-06', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3f801178-1abf-42b4-8d94-4a7736f23ec6', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-07', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cf0f4b40-7e10-44a0-be5a-df2ceaf062f4', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-08', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd6b723be-be97-442a-9a24-ded11d71e30a', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-09', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '969bc67a-3089-437f-a636-b1b32feb0332', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-10', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '28948472-0675-46fb-bda3-96c5c4d8ae45', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-11', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f2a09dd5-0703-43b2-9575-b2c4226375cb', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-12', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b4d08103-0e91-4c31-84e6-2ff50ceaebf6', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-13', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4203f210-f89a-4b31-a8d9-74eb14dc3431', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-14', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '64574d38-9ac7-479b-bfb9-a39b5391160b', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 15', 
            15, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-15', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '255b815a-b538-41d7-a70e-debe9d15dddc', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 16', 
            16, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-16', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '30ab85c1-3645-4ff6-9259-416721fb08cc', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 17', 
            17, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-17', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a5063c5d-6884-4b9d-903f-287b4aff3da0', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 18', 
            18, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-18', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e415eb32-940d-4a40-9e42-ed09b19b1996', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 19', 
            19, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-19', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '76ebc04b-d433-437b-b20b-d57e90f0c0c7', 
            'def3336d-b53f-4037-b269-f93f61301ec9', 
            '» Chapter 20', 
            20, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4923-Door%20Pass%20(Class%20IX)/Chap-20', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '24b3db5c-caf7-4ea6-b9e1-1253c0d0510a', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_01', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8ce6c404-8d70-4475-8710-0034dcdd9d95', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_02', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1b6d5a8b-dcb4-416b-889c-9b270fa9f69e', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_03', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e426aa0b-c976-4309-842a-06a4d4da2af5', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_04', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7ea7e360-05ee-4c55-a204-2ce384369bf1', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_05', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9301036a-d1ba-4308-9d19-3604dc5003da', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_06', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1308cbbd-50cb-4285-b574-65eb4a0a603c', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_07', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '931965a8-e600-4b4d-ac35-5f91aed65eeb', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_08', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '934d8d0a-75e1-405a-a0e6-db71033fe8af', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_09', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4d8233db-c18d-4772-a4eb-3e12cb0ee5d1', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_10', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '16376dd8-b1c1-4982-9363-5cc098f5e1f8', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_11', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ca22b217-96e8-4ddf-afe6-5cd153934b57', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_12', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f9d103f8-7c90-45ba-a43e-3f8da7004508', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_13', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1f110773-0c4d-410f-86dd-9b13b5a4f376', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_14', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2f12e702-7b53-4b91-8ef3-bd61a11ac1b2', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 15', 
            15, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_15', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '110c9cef-404f-4d7b-8aab-2fde2694c089', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 16', 
            16, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_16', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0a3c4af4-7cfd-445a-874c-2abd36f0c910', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 17', 
            17, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_17', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7ba8eb40-12b5-4c6d-8b11-36247b7fd140', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 18', 
            18, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_18', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '290014d8-c515-48cc-9b40-bd29125596ee', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 19', 
            19, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_19', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '593bc55d-1e8a-420e-a208-d24080341767', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 20', 
            20, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_20', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '81173eb0-941d-4403-a000-d62fd94ead63', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 21', 
            21, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_21', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd4f87751-bb58-46f2-9727-014295a959f5', 
            'b5792799-61db-4a20-b62d-5dbbd2e6241c', 
            '» Chapter 22', 
            22, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4922-Jan%20Pehchan%20Class%20IX%20IInd%20Language/Ch_22', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '20179cf1-c171-4fd7-8eb5-62b34c017b42', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-01', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f1ab16e1-bb43-4c2b-ac3a-030f21abc5bc', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-02', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ffee636c-c31a-404e-a009-9d3fa14cb783', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-03', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0bbf727c-d9a9-4322-823c-fe9d537ca3c8', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-04', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f13ad4c4-bd07-4d51-9718-165a79b51c64', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-05', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '60d5e908-05f3-46b4-8a70-c2862bcba986', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-06', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ce131997-e5ac-40cc-83ee-0d6d3868b382', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-07', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '52feb853-21ce-4946-b4e1-3d1c9b6ccc81', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-08', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e55cfd34-a1c2-4404-953f-90498be75645', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-09', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f1b49929-9053-4cf5-b524-f8456534ed52', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-10', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a901fc26-cddb-48cd-9b79-69cce794c756', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-11', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '35d983a9-57fd-4a12-b9b5-d14c69157174', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-12', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b92bedac-f7b5-4fa5-94fd-d22e58c15a41', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-13', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b48e6356-4a40-4bb9-99dc-bc1c57be9593', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-14', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '189b2a1c-bf95-4611-819b-04f58286df28', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 15', 
            15, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-15', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '24894e07-518c-4fd0-bc60-c6375f6a7d35', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 16', 
            16, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-16', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4ff6ace4-7112-4b21-9a09-a320232ce8fb', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 17', 
            17, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-17', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2c60fc9b-3bc0-4ca6-bced-45ca9825b610', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 18', 
            18, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-18', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7ced2c8a-afd1-4b06-a23e-3f776ee9c78d', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 19', 
            19, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-19', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '73297ff4-8f0b-4de0-b910-54a2ad80f287', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 20', 
            20, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-20', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f0617ed3-e5f1-49c3-8104-c5fc42122a80', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 21', 
            21, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-21', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd11a4dc9-3b78-4d28-b6f4-ceeff84748ee', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 22', 
            22, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-22', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2bf4f4f5-f2f6-4cd9-acf7-7a94f4fe3802', 
            'd490b38b-57cf-4237-aeac-02d0281b0f25', 
            '» Chapter 23', 
            23, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4914-Nawa-e-Urdu/Chap-23', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b3ba0470-0a40-4320-a1cc-f5ab7898d726', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch01', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '09a83abe-5c0a-4014-bf2c-155885c8238c', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch02', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '3298c7e8-2189-4506-bc0c-b3d3334bfaab', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch03', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'fc40d9ae-8439-49d8-b0d5-9440c78c406e', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch04', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'afe8dd0c-8ee8-458c-ae68-4e04b87ccca7', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch05', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e20a5f63-9384-48ca-87c4-73d586ba42de', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch06', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'aee49df3-d463-4c78-bb6c-3151f79f3cfd', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch07', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'd4ca9de8-1f3d-4bf3-83f2-e93427dd9a02', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch08', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'bdbeab2d-2b19-4e64-a257-0b9dbea6ae04', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch09', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ddeec776-f83e-4c90-b4d0-864ae3cc067b', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch10', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '127a0ea0-f5ea-4fca-98be-605b881d248c', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch11', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '431b133e-bc61-48c1-8792-b60a92cfae11', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch12', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '60847f3d-65ea-47b7-acc3-155cd6706e23', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch13', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0b0ca99f-5348-4b14-9088-33e2eb323933', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch14', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a236f392-5728-4554-8be8-2d677dbf91c2', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 15', 
            15, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch15', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '20b0261b-a937-4a0d-95a6-0122d8d5b793', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 16', 
            16, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch16', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '9482f070-956e-4785-b8de-5e2d34a242b5', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 17', 
            17, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch17', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a1c64d36-93e1-449e-96a5-a697d9bc188d', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 18', 
            18, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch18', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8b43f862-ccc4-4396-81ba-431a12c684d8', 
            'bf1fa4d3-3228-435b-adb5-c00abdd39b58', 
            '» Chapter 19', 
            19, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/4920-Gulzar-e-Urdu/Ch19', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '420a72c1-593c-420d-8a45-4ba4dc3537bf', 
            '39743b46-56ef-4cdd-86d6-42a8d9c23bca', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17914Hand%20Embroidery%20(Addawala)/Unit1/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b5c70c1f-fe38-4fe2-9257-f642963c6540', 
            '39743b46-56ef-4cdd-86d6-42a8d9c23bca', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17914Hand%20Embroidery%20(Addawala)/Unit2/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '873a2faf-388f-4872-a446-29e54a1ed3f0', 
            '39743b46-56ef-4cdd-86d6-42a8d9c23bca', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17914Hand%20Embroidery%20(Addawala)/Unit3/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2ec8d075-05a1-478e-b704-6180dd703c76', 
            '39743b46-56ef-4cdd-86d6-42a8d9c23bca', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17914Hand%20Embroidery%20(Addawala)/Unit4/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e882192f-d9ab-4378-a90a-391408d77825', 
            '39743b46-56ef-4cdd-86d6-42a8d9c23bca', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17914Hand%20Embroidery%20(Addawala)/Unit5/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '8a8fc988-7df0-4760-bbb7-0202a4f99f1f', 
            '3942448a-1d2a-4f1c-aa33-5789121dacf8', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17902Solanaceous%20Crop%20Cultivator/Chapter-1/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1895ff48-76d7-4b57-af56-5eaae3dea4b3', 
            '3942448a-1d2a-4f1c-aa33-5789121dacf8', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17902Solanaceous%20Crop%20Cultivator/Chapter-2/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'c4ee6dc0-710b-4b37-a4dc-df0bf73da41b', 
            '3942448a-1d2a-4f1c-aa33-5789121dacf8', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17902Solanaceous%20Crop%20Cultivator/Chapter-3/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '94419dbc-6353-42b9-8a6a-040c08b8c78d', 
            '3942448a-1d2a-4f1c-aa33-5789121dacf8', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17902Solanaceous%20Crop%20Cultivator/Chapter-4/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '99ab5630-e135-40c0-ab34-80978253c71b', 
            '3942448a-1d2a-4f1c-aa33-5789121dacf8', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17902Solanaceous%20Crop%20Cultivator/Chapter-5/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1af3ec95-1995-4a78-b1e6-dfcb25cb466e', 
            '64c21f74-887c-4603-b4d8-a32f42d67483', 
            '» Prelims', 
            378, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17903Animal%20Health%20Worker/Prelims/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a3e0f168-5718-4f70-8a09-098e7044ece5', 
            '8e91d672-71fb-4451-8bc3-95ee0642a324', 
            '» Prelims', 
            379, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17913Hand%20Embroiderer/Prelims/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f25d4d54-7b1f-4636-ba5b-55e8026329c8', 
            '07c64566-ee51-47ce-ab8d-99afcc2c7471', 
            '» Prelims', 
            380, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17918Assistant%20Beauty%20Therapist/p/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ea4c71d2-8929-4545-acda-849ac2e2c41b', 
            'a542dd62-f610-4506-b37d-d42f69c34ed9', 
            '» Prelims', 
            381, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17945Store%20Operations%20Assistant%20(Retail)/p/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a21e6f23-eb9b-4f53-8fec-431ec64e9d3e', 
            '2a112a3e-a2db-4897-94d3-0af1276b6d51', 
            '» Prelims', 
            382, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/17946Cashier/Prelims/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '67903eee-e83c-4d98-95b9-ba0f8f9e2cf2', 
            'ab8bd5a8-bb6c-4d58-a9b2-d6bd4859cdb5', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/ict/iict101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '17f51597-84d9-4d80-a486-d1c5b7e75bb1', 
            'ab8bd5a8-bb6c-4d58-a9b2-d6bd4859cdb5', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/ict/iict102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '2d6079ed-5fa9-45ba-87b4-b106d3e05cec', 
            'ab8bd5a8-bb6c-4d58-a9b2-d6bd4859cdb5', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/ict/iict103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '0d6f06c6-53e6-473e-aedd-7228a0ef348a', 
            'ab8bd5a8-bb6c-4d58-a9b2-d6bd4859cdb5', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/ict/iict104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e60d2588-e18b-43c6-9edd-86be7039391c', 
            'ab8bd5a8-bb6c-4d58-a9b2-d6bd4859cdb5', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/ict/iict105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'f9d5c778-50ee-45cb-ae72-3645356af45f', 
            'ab8bd5a8-bb6c-4d58-a9b2-d6bd4859cdb5', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/ict/iict106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e1599820-7724-43bf-9960-6015630edd3b', 
            'ab8bd5a8-bb6c-4d58-a9b2-d6bd4859cdb5', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/ict/iict107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '1829eac5-2a28-4412-8bed-fb906de16341', 
            'ab8bd5a8-bb6c-4d58-a9b2-d6bd4859cdb5', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/ict/iict108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'a73eec1b-bb2d-4613-8f10-eddcafb4b483', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 1', 
            1, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp101/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '5b8cada3-2f51-4917-933c-f8ad58d01451', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 2', 
            2, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp102/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'de316d24-ca17-4071-aed7-720e9f5c91b4', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 3', 
            3, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp103/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'cf6a392e-9c04-4e0e-b8ba-915aac7972e9', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 4', 
            4, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp104/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '78b058a1-590a-4878-b63d-65674c8e9648', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 5', 
            5, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp105/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '951cdc3a-9d30-4877-bd56-1a208eab12ec', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 6', 
            6, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp106/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '4b3eba1a-9afa-48d4-9a7b-3fa01a0f1406', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 7', 
            7, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp107/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '564f0443-49d8-40cb-ad77-843d452ad12c', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 8', 
            8, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp108/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '02c6cb0c-a055-45f8-9ba6-dce3300ddfcb', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 9', 
            9, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp109/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '7e0e4414-a7dd-4c6e-8c6f-6712afa5fef1', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 10', 
            10, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp110/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'ff678881-764c-4795-8a84-7b535e5c85b5', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 11', 
            11, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp111/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            '91ebf36b-ed7c-4859-ad8e-5eb325f446d0', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 12', 
            12, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp112/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'b0acfbed-4ae8-4b52-b444-d2f3c41bf662', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 13', 
            13, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp113/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        

        INSERT INTO public.chapters (id, book_id, title, chapter_number, storage_path, metadata, embedding_status) 
        VALUES (
            'e19d2b92-7078-46ad-81ff-302481dfb943', 
            'f97a13d2-0802-4a1f-bb55-0593164d7443', 
            '» Chapter 14', 
            14, 
            'https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX/Health%20and%20Physical%20Education_iehp/iehp114/index.html', 
            '{}', 
            'not_started' -- This is the trigger for the embedding pipeline
        );
        
END $$;