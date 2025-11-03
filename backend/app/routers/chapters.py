"""
Chapter management routes
"""
from fastapi import APIRouter, Depends, HTTPException, status, UploadFile, File
from sqlalchemy.orm import Session
from typing import List

from app.models.chapter import Chapter
from app.models.user import User
from app.schemas.chapter import ChapterCreate, ChapterResponse, ChapterUpdate
from app.routers.users import get_current_teacher
from app.utils.database import get_db
from app.services.google_drive_service import GoogleDriveService
from app.services.content_extraction_service import ContentExtractionService

router = APIRouter()


@router.post("/", response_model=ChapterResponse, status_code=status.HTTP_201_CREATED)
async def create_chapter(
    chapter_data: ChapterCreate,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Create a new chapter (teacher only)"""
    new_chapter = Chapter(
        **chapter_data.dict(),
        teacher_id=current_user.id,
        is_custom=True
    )
    
    db.add(new_chapter)
    db.commit()
    db.refresh(new_chapter)
    
    return new_chapter


@router.post("/{chapter_id}/upload", response_model=ChapterResponse)
async def upload_chapter_file(
    chapter_id: int,
    file: UploadFile = File(...),
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Upload chapter file (PDF/EPUB)"""
    chapter = db.query(Chapter).filter(
        Chapter.id == chapter_id,
        Chapter.teacher_id == current_user.id
    ).first()
    
    if not chapter:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Chapter not found"
        )
    
    # Validate file type
    file_extension = None
    if file.filename:
        file_extension = '.' + file.filename.split('.')[-1].lower()
    
    if file_extension not in [".pdf", ".epub"]:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Only PDF and EPUB files are allowed"
        )
    
    # Upload to Google Drive
    drive_service = GoogleDriveService()
    
    # Save file temporarily
    import tempfile
    import os
    
    with tempfile.NamedTemporaryFile(delete=False, suffix=file_extension) as tmp_file:
        content = await file.read()
        tmp_file.write(content)
        tmp_file_path = tmp_file.name
    
    try:
        # Upload to Drive
        drive_result = drive_service.upload_file(
            tmp_file_path,
            file.filename or f"chapter_{chapter_id}{file_extension}"
        )
        
        if drive_result:
            chapter.content_file_id = drive_result['file_id']
            chapter.content_file_url = drive_result['web_view_link']
        
        # Extract text content
        extraction_service = ContentExtractionService(drive_service)
        extracted_text = extraction_service.extract_text_from_file(
            file_path=tmp_file_path,
            file_extension=file_extension
        )
        
        if extracted_text:
            chapter.content_text = extracted_text
            chapter.is_content_processed = True
        
        db.commit()
        db.refresh(chapter)
        
        return chapter
    finally:
        # Clean up temp file
        if os.path.exists(tmp_file_path):
            os.remove(tmp_file_path)


@router.post("/{chapter_id}/generate", response_model=ChapterResponse)
async def generate_assessments_for_chapter(
    chapter_id: int,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Trigger assessment generation for a custom uploaded chapter"""
    chapter = db.query(Chapter).filter(
        Chapter.id == chapter_id,
        Chapter.teacher_id == current_user.id,
        Chapter.is_custom == True
    ).first()
    
    if not chapter:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Chapter not found or not custom"
        )
    
    if not chapter.content_text:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Chapter content not processed yet"
        )
    
    # Mark as generated (actual generation happens in assessment creation)
    chapter.is_generated = True
    db.commit()
    db.refresh(chapter)
    
    return chapter


@router.get("/", response_model=List[ChapterResponse])
async def list_chapters(
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """List all chapters (teacher's chapters)"""
    chapters = db.query(Chapter).filter(
        Chapter.teacher_id == current_user.id
    ).offset(skip).limit(limit).all()
    
    return chapters


@router.get("/{chapter_id}", response_model=ChapterResponse)
async def get_chapter(
    chapter_id: int,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Get chapter details"""
    chapter = db.query(Chapter).filter(
        Chapter.id == chapter_id,
        Chapter.teacher_id == current_user.id
    ).first()
    
    if not chapter:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Chapter not found"
        )
    
    return chapter


@router.put("/{chapter_id}", response_model=ChapterResponse)
async def update_chapter(
    chapter_id: int,
    chapter_data: ChapterUpdate,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Update chapter details"""
    chapter = db.query(Chapter).filter(
        Chapter.id == chapter_id,
        Chapter.teacher_id == current_user.id
    ).first()
    
    if not chapter:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Chapter not found"
        )
    
    # Update fields
    update_data = chapter_data.dict(exclude_unset=True)
    for field, value in update_data.items():
        setattr(chapter, field, value)
    
    db.commit()
    db.refresh(chapter)
    
    return chapter


@router.delete("/{chapter_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_chapter(
    chapter_id: int,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Delete a chapter"""
    chapter = db.query(Chapter).filter(
        Chapter.id == chapter_id,
        Chapter.teacher_id == current_user.id
    ).first()
    
    if not chapter:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Chapter not found"
        )
    
    # Delete from Google Drive if exists
    if chapter.content_file_id:
        drive_service = GoogleDriveService()
        drive_service.delete_file(chapter.content_file_id)
    
    db.delete(chapter)
    db.commit()
    
    return None
