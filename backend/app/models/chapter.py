"""
Chapter model
"""
from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime, Boolean, JSON
from sqlalchemy.orm import relationship
from datetime import datetime

from app.utils.database import Base


class Chapter(Base):
    """Chapter model for uploaded textbook chapters"""
    __tablename__ = "chapters"
    
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False, index=True)
    chapter_number = Column(Integer)
    subject = Column(String, index=True)
    grade_level = Column(Integer)
    textbook_name = Column(String)
    textbook_source = Column(String)  # "NCERT", "custom", etc.
    
    # Content
    content_text = Column(Text)  # Extracted text from PDF/EPUB
    content_file_url = Column(String)  # Google Drive file URL
    content_file_id = Column(String)  # Google Drive file ID
    
    # Learning Outcomes
    learning_outcomes = Column(JSON)  # List of learning outcomes/competencies
    
    # Metadata
    teacher_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    is_ncert = Column(Boolean, default=False)
    is_custom = Column(Boolean, default=True)  # Teacher-uploaded chapters
    
    # Generation status
    is_content_processed = Column(Boolean, default=False)
    is_generated = Column(Boolean, default=False)  # Whether Q&As/MCQs are generated
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    teacher = relationship("User", back_populates="chapters")
    assessments = relationship("Assessment", back_populates="chapter")
    discussions = relationship("Discussion", back_populates="chapter")
