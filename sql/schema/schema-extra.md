# 📚 STUDIOUS - REVISED DATABASE SCHEMA (Supabase + Pinecone + RabbitMQ)

## 🔄 ARCHITECTURE UPDATES

### **New Components:**
1. **RabbitMQ** - Message queue for async processing (embeddings, OCR, comparisons)
2. **BGE-M3 Model** - For student test embeddings (stored in Supabase + Pinecone)
3. **Binary Storage** - Student test images/PDFs stored with embeddings for comparison

### **Key Changes from Previous Schema:**
- Added `student_test_embeddings` table (Supabase) to store BGE-M3 vectors as bytes
- Added `test_comparisons` table for plagiarism/similarity checks
- Added `job_queue` table to track RabbitMQ job status
- Modified `ocr_results` to always include embeddings
- Added binary storage references for test files

---

## 🔐 PART 1: AUTHENTICATION & USERS (Updated)

### **Authentication (Supabase Auth)**
This is handled by Supabase's built-in `auth.users` table.

**Google OAuth Integration:**
```
Provider: Google
Scopes: email, profile
Callback URL: https://yourdomain.com/auth/callback
```

**Supabase Auth Configuration:**
- Enable email/password auth
- Enable Google OAuth provider
- Set JWT expiration: 3600 seconds (1 hour)
- Enable email confirmations

---

### **users** (Updated)
Profile layer on top of Supabase Auth.

```
id (uuid, PK)
auth_uid (uuid, FK → auth.users.id, unique) - Supabase Auth ID
org_id (uuid, FK → organizations.id, nullable) - Null until approved
username (text, unique) - User-chosen username
email (text, unique) - From auth.users
first_name (text)
last_name (text)
phone (text, nullable)
role (enum) - 'student' | 'teacher' | 'principal'
status (enum) - 'active' | 'inactive' | 'pending' | 'suspended'
is_admin (boolean, default: false) - System admin flag
slug (text, unique) - For profile URLs
meta (jsonb) - {
  preferences: {theme, language, notifications},
  onboarding_completed: boolean,
  last_login: timestamp,
  profile_pic_url: text,
  google_id: text (from OAuth)
}
created_at (timestamp)
updated_at (timestamp)
last_login_at (timestamp, nullable)
```

**Changes:**
- Added `username` field
- Added `is_admin` for system-level admins
- Added `slug` for profile URLs
- Added `last_login_at` for tracking
- `meta.google_id` to link OAuth identity

---

### **organizations** (No changes)
```
id (uuid, PK)
name (text)
slug (text, unique)
contact_email (text)
billing_email (text)
seats_total (integer)
seats_used (integer)
plan_id (uuid, FK → pricing_plans)
created_at (timestamp)
updated_at (timestamp)
```

---

## 💳 PART 2: SUBSCRIPTION SYSTEM (New Structure)

### **pricing_plans** (Subscription Details)
```
id (uuid, PK)
name (text) - "Basic", "Pro", "Enterprise"
slug (text, unique) - "basic", "pro", "enterprise"
description (text)
price_per_seat_monthly (numeric) - In INR
seats_included (integer) - Base seats included
token_limit_monthly (bigint) - Tokens per month (null = unlimited)
features (jsonb) - {
  max_uploads_per_month: integer,
  api_rate_limit: integer,
  support_level: "email" | "priority" | "dedicated",
  custom_branding: boolean,
  advanced_analytics: boolean
}
is_active (boolean, default: true)
display_order (integer) - For UI sorting
created_at (timestamp)
updated_at (timestamp)
```

---

### **subscriptions** (Subscription Record)
```
id (uuid, PK)
org_id (uuid, FK → organizations.id, unique) - One subscription per org
plan_id (uuid, FK → pricing_plans.id)
user_id (uuid, FK → users.id) - Who purchased/manages subscription
approval_status (enum) - 'pending' | 'approved' | 'rejected' | 'active' | 'cancelled'
approved_by (uuid, FK → users.id, nullable) - System admin who approved
approved_at (timestamp, nullable)
seats_purchased (integer) - Additional seats beyond plan base
billing_cycle_start (date)
billing_cycle_end (date)
status (enum) - 'trialing' | 'active' | 'past_due' | 'cancelled' | 'expired'
auto_renew (boolean, default: true)
cancellation_reason (text, nullable)
cancelled_at (timestamp, nullable)
trial_ends_at (timestamp, nullable)
metadata (jsonb) - {
  payment_gateway: "razorpay" | "stripe",
  subscription_id: text (external ID),
  discount_code: text,
  notes: text
}
created_at (timestamp)
updated_at (timestamp)
```

**New Fields:**
- `approval_status` - For admin approval workflow
- `approved_by` - System admin who approved subscription
- `user_id` - Who initiated the subscription (usually principal)
- `metadata.reason` - Why subscription was created/cancelled

**Workflow:**
1. Principal signs up → creates subscription with `approval_status = 'pending'`
2. System admin reviews → sets `approval_status = 'approved'`
3. Subscription becomes `status = 'active'`
4. Billing starts from `billing_cycle_start`

---

## 📤 PART 3: STUDENT TEST UPLOADS & EMBEDDINGS (Major Updates)

### **uploads** (Updated)
```
id (uuid, PK)
org_id (uuid, FK → organizations.id)
uploaded_by (uuid, FK → users.id)
uploader_role (enum) - 'teacher' | 'student'
title (text)
description (text, nullable)
file_type (enum) - 'pdf' | 'image' | 'doc' | 'ppt'
storage_path (text) - Supabase Storage path
storage_bucket (text) - Bucket name (e.g., "student-tests", "teacher-uploads")
file_size_bytes (bigint)
source (enum) - 'user_upload' | 'teacher_textbook' | 'student_test'
status (enum) - 'pending' | 'queued' | 'processing' | 'completed' | 'error'
job_id (uuid, FK → job_queue.id, nullable) - RabbitMQ job reference
metadata (jsonb) - {
  page_count: integer,
  mime_type: text,
  original_filename: text,
  dimensions: {width, height} (for images)
}
created_at (timestamp)
processed_at (timestamp, nullable)
error_message (text, nullable)
```

**New Fields:**
- `storage_bucket` - Separate buckets for different upload types
- `file_size_bytes` - For quota tracking
- `job_id` - Links to RabbitMQ job
- `status = 'queued'` - When sent to RabbitMQ
- `error_message` - For failed processing

---

### **job_queue** (New - RabbitMQ Job Tracker)
Tracks async jobs sent to RabbitMQ.

```
id (uuid, PK)
queue_name (text) - "embedding_generation", "ocr_processing", "test_comparison"
job_type (enum) - 'generate_embeddings' | 'ocr_extraction' | 'test_comparison' | 'batch_embedding'
status (enum) - 'pending' | 'queued' | 'processing' | 'completed' | 'failed' | 'retrying'
priority (integer) - 1 (low) to 10 (high)
payload (jsonb) - Job-specific data {upload_id, source_type, etc.}
result (jsonb, nullable) - Job output after completion
attempts (integer, default: 0)
max_attempts (integer, default: 3)
error_message (text, nullable)
rabbitmq_message_id (text, nullable) - RabbitMQ message ID
created_at (timestamp)
queued_at (timestamp, nullable)
started_at (timestamp, nullable)
completed_at (timestamp, nullable)
retry_after (timestamp, nullable)
```

**Use Cases:**
- Track embedding generation jobs
- Retry failed OCR processing
- Monitor comparison job progress
- Debug async pipeline issues

**RabbitMQ Queue Structure:**
```
Queue: embedding_generation
Queue: ocr_processing
Queue: test_comparison
Queue: batch_operations
```

---

### **ocr_results** (Updated)
```
id (uuid, PK)
upload_id (uuid, FK → uploads.id, unique)
extracted_text (text) - Raw OCR output
json_output (jsonb) - Structured extraction {
  questions: [{text, options, answer_area}],
  answers: [{question_ref, student_answer}],
  metadata: {confidence_score, language_detected}
}
page_data (jsonb) - [{
  page_no: integer,
  text: text,
  confidence: float,
  bounding_boxes: [...]
}]
ocr_engine (text) - "tesseract", "google-vision", "aws-textract"
ocr_confidence (float) - Average confidence (0.0-1.0)
plagiarism_check (jsonb) - {
  web_check_status: "pending" | "completed",
  fuzzy_duplication_score: float,
  matched_sources: [{url, similarity}]
}
embedding_status (enum) - 'pending' | 'processing' | 'completed' | 'error'
embedding_job_id (uuid, FK → job_queue.id, nullable)
created_at (timestamp)
updated_at (timestamp)
```

**New Fields:**
- `ocr_engine` - Which OCR service was used
- `ocr_confidence` - Overall confidence score
- `embedding_job_id` - Links to RabbitMQ job
- `embedding_status` - Always tracked (no longer optional)

---

### **student_test_embeddings** (New - BGE-M3 Storage)
Stores embeddings generated from student test uploads using BGE-M3.

```
id (uuid, PK)
upload_id (uuid, FK → uploads.id)
ocr_result_id (uuid, FK → ocr_results.id, nullable)
student_id (uuid, FK → users.id)
org_id (uuid, FK → organizations.id)
embedding_model (text) - "bge-m3" | "bge-large-en-v1.5"
embedding_bytes (bytea) - Raw embedding vector as bytes
embedding_dimension (integer) - Vector dimension (e.g., 1024 for BGE-M3)
chunk_index (integer) - Position in document (0, 1, 2...)
chunk_text (text) - Actual text chunk (for debugging)
chunk_token_count (integer)
metadata (jsonb) - {
  page_no: integer,
  question_number: integer,
  answer_text: text,
  section_type: "question" | "answer" | "other"
}
pinecone_vector_id (text, unique, nullable) - Also stored in Pinecone
pinecone_namespace (text) - "org_{org_id}_student_tests"
created_at (timestamp)
```

**Why Store Embeddings in Supabase AND Pinecone?**
1. **Supabase (bytea)**: For direct comparison queries without API calls
2. **Pinecone**: For fast semantic search across large datasets
3. **Hybrid approach**: Use Supabase for small-scale comparisons, Pinecone for RAG

**BGE-M3 Model Details:**
- Dimension: 1024
- Type: Dense + Sparse embeddings (we'll store dense in bytea)
- Use case: Multilingual, good for short-form content (test answers)

---

### **test_comparisons** (New - Plagiarism/Similarity Results)
Stores results of comparing student tests with:
1. Chapter content embeddings
2. Other students' test submissions

```
id (uuid, PK)
student_test_id (uuid, FK → uploads.id) - The test being analyzed
student_id (uuid, FK → users.id)
org_id (uuid, FK → organizations.id)
comparison_type (enum) - 'chapter_similarity' | 'student_plagiarism' | 'answer_quality'
comparison_target_type (enum) - 'chapter' | 'student_test'
comparison_target_id (uuid) - ID of chapter or another upload
similarity_score (float) - 0.0 to 1.0 (cosine similarity)
matched_chunks (jsonb) - [{
  student_chunk_index: integer,
  target_chunk_index: integer,
  similarity: float,
  student_text: text,
  target_text: text
}]
analysis_result (jsonb) - {
  overall_verdict: "original" | "suspicious" | "plagiarized",
  confidence: float,
  recommendations: [text],
  key_matches: [...]
}
job_id (uuid, FK → job_queue.id, nullable)
created_at (timestamp)
updated_at (timestamp)
```

**Use Cases:**

**1. Chapter Similarity Check:**
- Compare student's test answers with chapter embeddings
- Identify which concepts the student understands
- Result: "80% match with Chapter 3: Real Numbers"

**2. Student Plagiarism Detection:**
- Compare student A's test with student B's test
- Flag suspicious similarities
- Result: "Student A and Student B have 95% similar answers on Q3-Q5"

**3. Answer Quality Assessment:**
- Compare with model answers (if available)
- Grade based on semantic similarity
- Result: "Student answer is 70% similar to ideal answer"

---

### **test_comparison_queue** (New - Batch Processing)
When a student submits a test, we need to compare it with:
- Chapter content (1 comparison)
- All other students in the same class (N comparisons)

This table queues those comparisons.

```
id (uuid, PK)
student_test_id (uuid, FK → uploads.id)
comparison_type (enum) - 'chapter_similarity' | 'student_plagiarism'
target_id (uuid) - chapter_id or another upload_id
status (enum) - 'pending' | 'processing' | 'completed' | 'failed'
priority (integer, default: 5)
job_id (uuid, FK → job_queue.id, nullable)
result_id (uuid, FK → test_comparisons.id, nullable) - Once completed
created_at (timestamp)
started_at (timestamp, nullable)
completed_at (timestamp, nullable)
```

**Workflow:**
1. Student uploads test → `uploads` record created
2. RabbitMQ job: Generate embeddings → `student_test_embeddings` populated
3. System creates comparison tasks:
   - 1 record for chapter comparison
   - N records for other students in class
4. RabbitMQ workers process comparisons
5. Results stored in `test_comparisons`

---

## 🧠 PART 4: EMBEDDINGS METADATA (Updated)

### **embeddings** (Updated)
Metadata for all non-test embeddings (NCERT, teacher textbooks, student notes).

```
id (uuid, PK)
org_id (uuid, FK → organizations.id, nullable) - NULL for NCERT
user_id (uuid, FK → users.id, nullable) - Who triggered embedding
source_type (enum) - 'ncert_chapter' | 'teacher_textbook' | 'student_upload'
source_id (uuid) - chapter.id or upload.id
vector_id (text, unique) - Pinecone vector ID
namespace (text) - Pinecone namespace
chunk_index (integer)
chunk_text (text, nullable) - Store for debugging (optional)
chunk_token_count (integer)
embedding_model (text) - "text-embedding-3-small" | "bge-m3"
metadata (jsonb) - {
  page_no: integer,
  section_title: text,
  book_title: text,
  chapter_title: text
}
created_at (timestamp)
```

**Key Difference from `student_test_embeddings`:**
- This table: OpenAI embeddings for RAG (stored only in Pinecone)
- `student_test_embeddings`: BGE-M3 embeddings (stored in both Supabase + Pinecone)

---

## 🎯 PART 5: PINECONE STRUCTURE (Updated)

### **Pinecone Indexes**

**Index 1: `studious-rag-production`**
```
Purpose: RAG retrieval (NCERT, teacher textbooks, student notes)
Model: OpenAI text-embedding-3-small
Dimensions: 1536
Metric: cosine
```

**Namespaces:**
- `ncert_shared` - NCERT chapters (shared across all orgs)
- `org_{org_id}_textbook` - Teacher-uploaded textbooks
- `org_{org_id}_uploads` - Student notes/uploads

---

**Index 2: `studious-tests-production`**
```
Purpose: Student test comparisons
Model: BGE-M3
Dimensions: 1024
Metric: cosine
```

**Namespaces:**
- `org_{org_id}_student_tests` - All student test submissions for an org

---

### **Pinecone Metadata Schema**

**For RAG Index:**
```json
{
  "id": "emb_uuid",
  "values": [0.123, ...], // 1536-dim
  "metadata": {
    "org_id": "uuid or null",
    "source_type": "ncert_chapter",
    "source_id": "chapter_uuid",
    "book_title": "Mathematics Class 10",
    "chapter_title": "Real Numbers",
    "page_no": 42,
    "chunk_index": 3,
    "created_at": "2024-01-15T10:30:00Z"
  }
}
```

**For Test Index:**
```json
{
  "id": "test_emb_uuid",
  "values": [0.456, ...], // 1024-dim
  "metadata": {
    "org_id": "uuid",
    "student_id": "uuid",
    "upload_id": "uuid",
    "question_number": 3,
    "section_type": "answer",
    "submission_date": "2024-01-15",
    "class_id": "uuid"
  }
}
```

---

## 🔄 PART 6: RABBITMQ WORKFLOW

### **Queue Configuration**

**Queue 1: `embedding_generation`**
```json
{
  "upload_id": "uuid",
  "source_type": "student_test",
  "model": "bge-m3",
  "priority": 8
}
```

**Queue 2: `ocr_processing`**
```json
{
  "upload_id": "uuid",
  "ocr_engine": "tesseract",
  "language": "eng+hin"
}
```

**Queue 3: `test_comparison`**
```json
{
  "student_test_id": "uuid",
  "comparison_type": "chapter_similarity",
  "target_id": "chapter_uuid",
  "class_id": "uuid"
}
```

**Queue 4: `batch_comparison`**
```json
{
  "student_test_id": "uuid",
  "class_id": "uuid",
  "compare_with_students": ["student_uuid_1", "student_uuid_2"]
}
```

---

### **Processing Flow: Student Test Submission**

```
1. Student uploads PDF/images → uploads.status = 'pending'

2. Backend publishes to RabbitMQ:
   - Queue: ocr_processing
   - Job: Extract text from test
   - Updates: job_queue.status = 'queued'

3. OCR Worker:
   - Processes PDF/images
   - Stores result in ocr_results
   - Updates: uploads.status = 'processing'

4. Backend publishes to RabbitMQ:
   - Queue: embedding_generation
   - Job: Generate BGE-M3 embeddings
   
5. Embedding Worker:
   - Generates embeddings for each chunk
   - Stores in student_test_embeddings (Supabase bytea)
   - Uploads to Pinecone (org_{org_id}_student_tests namespace)
   - Updates: uploads.status = 'completed'

6. Backend triggers comparison jobs:
   - Creates N records in test_comparison_queue
   - Publishes to batch_comparison queue

7. Comparison Worker:
   - Fetches embeddings from Supabase OR queries Pinecone
   - Calculates cosine similarity
   - Stores results in test_comparisons
   - Updates: test_comparison_queue.status = 'completed'

8. Student sees results:
   - Overall similarity with chapter
   - Plagiarism flags (if any)
   - Answer quality scores
```

---

## 📊 PART 7: COMPARISON QUERIES

### **Binary Embedding Comparison (Supabase)**
For small-scale comparisons (e.g., comparing 2 specific tests):

```sql
-- Pseudo-SQL (using pgvector extension)
SELECT 
  a.id as student_a_test,
  b.id as student_b_test,
  1 - (a.embedding_bytes <=> b.embedding_bytes) as similarity
FROM student_test_embeddings a
CROSS JOIN student_test_embeddings b
WHERE a.student_id != b.student_id
  AND a.org_id = 'xyz'
  AND b.org_id = 'xyz'
  AND a.chunk_index = b.chunk_index
ORDER BY similarity DESC
LIMIT 10;
```

**Note:** Requires `pgvector` extension for Supabase.

---

### **Semantic Search (Pinecone)**
For large-scale RAG queries:

```python
# Find similar test answers across entire class
results = pinecone_index.query(
    namespace=f"org_{org_id}_student_tests",
    vector=test_embedding_vector,
    filter={
        "class_id": "class_uuid",
        "question_number": 3
    },
    top_k=10,
    include_metadata=True
)

# Compare with chapter content
results = rag_index.query(
    namespace="ncert_shared",
    vector=test_answer_embedding,
    filter={
        "chapter_id": "chapter_uuid"
    },
    top_k=5
)
```

---

## 🔐 PART 8: GOOGLE OAUTH INTEGRATION

### **Supabase Auth Setup**

**1. Enable Google Provider:**
```
Dashboard → Authentication → Providers → Google
Client ID: [from Google Cloud Console]
Client Secret: [from Google Cloud Console]
Authorized redirect URI: https://[project-ref].supabase.co/auth/v1/callback
```

**2. Google Cloud Console Setup:**
```
1. Create OAuth 2.0 Client ID
2. Authorized JavaScript origins:
   - http://localhost:3000 (dev)
   - https://yourdomain.com (prod)
3. Authorized redirect URIs:
   - https://[project-ref].supabase.co/auth/v1/callback
4. Scopes: email, profile
```

**3. Frontend Implementation:**
```javascript
// Sign in with Google
const { data, error } = await supabase.auth.signInWithOAuth({
  provider: 'google',
  options: {
    redirectTo: 'https://yourdomain.com/auth/callback',
    scopes: 'email profile'
  }
})

// After callback, create user profile
const { data: { user } } = await supabase.auth.getUser()
await supabase.from('users').insert({
  auth_uid: user.id,
  email: user.email,
  first_name: user.user_metadata.full_name.split(' ')[0],
  last_name: user.user_metadata.full_name.split(' ').slice(1).join(' '),
  meta: {
    google_id: user.user_metadata.sub,
    profile_pic_url: user.user_metadata.avatar_url
  }
})
```

**4. Handle Existing Users:**
```javascript
// If user signs in with Google but email exists
const existingUser = await supabase
  .from('users')
  .select('*')
  .eq('email', user.email)
  .single()

if (existingUser) {
  // Link Google account to existing user
  await supabase.from('users').update({
    auth_uid: user.id,
    'meta.google_id': user.user_metadata.sub
  }).eq('id', existingUser.id)
}
```

---

## 📋 UPDATED IMPLEMENTATION CHECKLIST

### **Phase 1: Core Setup**
- [ ] Supabase project + enable Google OAuth
- [ ] Create two Pinecone indexes (RAG + Tests)
- [ ] Set up RabbitMQ (local dev: Docker, prod: CloudAMQP)
- [ ] Install pgvector extension in Supabase

### **Phase 2: Authentication**
- [ ] Implement Google OAuth flow
- [ ] Create user registration with pending approval
- [ ] Build principal approval dashboard
- [ ] Seat counting triggers

### **Phase 3: Test Upload Pipeline**
- [ ] File upload to Supabase Storage
- [ ] RabbitMQ job: OCR processing
- [ ] RabbitMQ job: BGE-M3 embedding generation
- [ ] Store embeddings in both Supabase (bytea) and Pinecone

### **Phase 4: Comparison Engine**
- [ ] Chapter similarity comparison
- [ ] Student-to-student plagiarism check
- [ ] Answer quality scoring
- [ ] Batch comparison queue processing

### **Phase 5: Results Dashboard**
- [ ] Student test results page
- [ ] Teacher plagiarism alerts
- [ ] Principal analytics overview

---

## 🎯 KEY DESIGN DECISIONS

### **Why Store Embeddings in Both Supabase AND Pinecone?**
1. **Supabase (bytea)**: 
   - Fast direct comparisons (no API latency)
   - Cost-effective for small queries
   - Enables SQL-based analytics
   
2. **Pinecone**:
   - Scalable semantic search
   - Fast approximate nearest neighbor (ANN)
   - Better for large-scale RAG

### **Why Separate Tables for Test Embeddings?**
- Different embedding models (BGE-M3 vs OpenAI)
- Different dimensions (1024 vs 1536)
- Different use cases (comparison vs RAG)
- Easier to manage lifecycle (tests deleted after semester)

### **Why RabbitMQ Instead of Direct Processing?**
- **Async processing**: Don't block user uploads
- **Scalability**: Add more workers as load increases
- **Reliability**: Retry failed jobs automatically
- **Prioritization**: Process teacher uploads before student notes

---

## ✅ SCHEMA COMPLETE

This schema now fully supports:
1. ✅ Google OAuth + JWT authentication
2. ✅ Subscription approval workflow
3. ✅ Student test uploads with binary storage
4. ✅ BGE-M3 embeddings stored in Supabase (bytea) + Pinecone
5. ✅ RabbitMQ async pipeline tracking
6. ✅ Chapter similarity comparisons
7. ✅ Student plagiarism detection
8. ✅ Answer quality scoring
9. ✅ Batch comparison processing

**Ready for SQL DDL generation?** Let me know if you want the full Supabase SQL schema + RLS policies! 🚀