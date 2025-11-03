"""
Assignment models
"""
from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime, Boolean, JSON, Float
from sqlalchemy.orm import relationship
from datetime import datetime

from app.utils.database import Base


class Assignment(Base):
    """Assignment model"""
    __tablename__ = "assignments"
    
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    description = Column(Text)
    
    # Relationships
    assessment_id = Column(Integer, ForeignKey("assessments.id"), nullable=False)
    teacher_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    
    # Assignment settings
    class_id = Column(String)  # Class identifier
    due_date = Column(DateTime)
    allow_late_submission = Column(Boolean, default=False)
    max_attempts = Column(Integer, default=1)
    
    # Access
    qr_code = Column(String, unique=True, index=True)  # QR code identifier
    share_link = Column(String, unique=True, index=True)  # Shareable link
    
    # Status
    is_active = Column(Boolean, default=True)
    auto_grade = Column(Boolean, default=True)  # Auto-grade MCQs
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    assessment = relationship("Assessment", back_populates="assignments")
    teacher = relationship("User", back_populates="assignments")
    submissions = relationship("AssignmentSubmission", back_populates="assignment", cascade="all, delete-orphan")


class AssignmentSubmission(Base):
    """Student submission for an assignment"""
    __tablename__ = "assignment_submissions"
    
    id = Column(Integer, primary_key=True, index=True)
    assignment_id = Column(Integer, ForeignKey("assignments.id"), nullable=False)
    student_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    
    # Submission data
    answers = Column(JSON)  # {"item_id": "answer", ...}
    
    # Grading
    score = Column(Float)
    max_score = Column(Float)
    is_graded = Column(Boolean, default=False)
    feedback = Column(Text)
    graded_by = Column(Integer, ForeignKey("users.id"))  # Teacher who graded
    
    # Metadata
    submitted_at = Column(DateTime, default=datetime.utcnow)
    graded_at = Column(DateTime)
    is_late = Column(Boolean, default=False)
    
    # Relationships
    assignment = relationship("Assignment", back_populates="submissions")
    student = relationship("User", back_populates="submissions")
