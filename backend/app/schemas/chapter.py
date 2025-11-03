"""
Chapter schemas
"""
from pydantic import BaseModel
from datetime import datetime
from typing import Optional, List


class ChapterBase(BaseModel):
    """Base chapter schema"""
    title: str
    chapter_number: Optional[int] = None
    subject: Optional[str] = None
    grade_level: Optional[int] = None
    textbook_name: Optional[str] = None
    textbook_source: Optional[str] = None
    learning_outcomes: Optional[List[str]] = None


class ChapterCreate(ChapterBase):
    """Schema for creating a chapter"""
    pass


class ChapterUpdate(BaseModel):
    """Schema for updating a chapter"""
    title: Optional[str] = None
    chapter_number: Optional[int] = None
    subject: Optional[str] = None
    grade_level: Optional[int] = None
    learning_outcomes: Optional[List[str]] = None


class ChapterResponse(ChapterBase):
    """Schema for chapter response"""
    id: int
    content_file_url: Optional[str] = None
    content_file_id: Optional[str] = None
    teacher_id: int
    is_ncert: bool
    is_custom: bool
    is_content_processed: bool
    is_generated: bool
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True
