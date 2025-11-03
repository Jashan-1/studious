# Studious

**From access to action** — Transform textbooks into actionable assessments, assignments, and insights.

> ⚠️ **Warning**: Project is experimental and not intended for daily use or production use yet.

## Overview

Studious is an education technology platform designed for **India-first conditions** that helps teachers create, assign, grade, and analyze assessments based on curriculum textbooks. Unlike traditional platforms that only provide access to reading materials, Scopes enables teachers to generate content, track mastery, and facilitate discussions—all optimized for low-bandwidth and offline scenarios.

## Key Features

### 📚 Curriculum Coverage
- Supports **NCERT** and teacher-uploaded textbooks
- Mapped to chapters and learning outcomes
- Chapter-level upload (not entire books) to respect LLM context windows

### 🤖 Auto-Generation
- **Q&As**: Question-answer sets editable by teachers
- **MCQs**: Multiple choice questions with difficulty and cognitive level mapping
- **Unit Tests**: Blueprinted assessments by chapter/learning outcome
- **One-Nighters**: Concise summary materials for quick revision


### 📝 Assign & Grade
- Distribute assignments to classes
- Auto-grade objective items (MCQs)
- Manual grading with rubrics for short-answer questions
- Fast feedback delivery

### 📊 Mastery Tracking
- Dashboards by chapter and learning outcome
- Growth tracking over time
- Weak area identification
- Suggested remediation paths

### 💬 Discussions
- Threaded chats per item/chapter
- Teacher moderation
- AI-drafted hints and solutions

### 🔗 Quick Access
- QR codes for instant classroom access
- Share links for assignments and discussions
- Offline-ready architecture

## Why Studious?

**vs. e-Pathshala/DIKSHA:**
- ✅ **From access to action**: Create, assign, grade, and analyze—not just read
- ✅ **Rapid iteration**: Classroom-level customization vs. curated pipelines
- ✅ **Any textbook**: Support for teacher-uploaded materials
- ✅ **Competency-focused**: Aligned with PARAKH-style balanced assessments

## Primary Users & Benefits

### 👨‍🏫 Teachers
- Save hours weekly on paper-setting and evaluation
- Instant mastery insights to guide remediation
- Streamlined workflow from upload to feedback

### 👨‍🎓 Students
- Structured practice materials
- Instant feedback on assessments
- Active revision with "one-nighters"
- Targeted remediation

### 🏫 Schools
- Consistent assessment quality
- Visibility into learning outcomes
- Readiness for competency-based reforms

## Technical Stack

- **Backend**: FastAPI (Python)
- **Storage**: Google Drive (MVP)
- **Architecture**: Designed for low-bandwidth, offline-ready operation

## Project Structure

```
studious/
├── backend/
│   ├── app/
│   │   ├── main.py          # FastAPI application entry point
│   │   ├── models/          # Database models
│   │   ├── routers/         # API route handlers
│   │   ├── services/        # Business logic (Drive, LLM, grading)
│   │   ├── schemas/         # Pydantic schemas for validation
│   │   ├── config.py        # Configuration management
│   │   └── utils/           # Utility functions
│   └── requirements.txt
└── README.md
```

## Getting Started

### Prerequisites
- Python 3.9+
- Google Drive API credentials

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Jashan-1/studious.git
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Set up environment variables:
```bash
# Create .env file with:
GOOGLE_DRIVE_CREDENTIALS_PATH=path/to/credentials.json
DATABASE_URL=sqlite:///./studious.db  # or your preferred DB
```

4. Run the application:
```bash
cd backend
uvicorn app.main:app --reload
```

## MVP Limitations

- Google Drive used for file storage (will be replaced in production)
- Chapter-level upload only (not full books)
- Auto-generation only for custom uploaded chapters

## Roadmap

- [ ] Full database integration (PostgreSQL)
- [ ] Advanced analytics dashboard
- [ ] Mobile app for offline access
- [ ] Integration with existing NCERT/DIKSHA APIs
- [ ] Multi-language support
