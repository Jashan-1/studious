"""
Assignment schemas
"""
from pydantic import BaseModel
from datetime import datetime
from typing import Optional, Dict


class AssignmentBase(BaseModel):
    """Base assignment schema"""
    title: str
    description: Optional[str] = None
    class_id: Optional[str] = None
    due_date: Optional[datetime] = None
    allow_late_submission: bool = False
    max_attempts: int = 1
    auto_grade: bool = True


class AssignmentCreate(AssignmentBase):
    """Schema for creating an assignment"""
    assessment_id: int


class AssignmentResponse(AssignmentBase):
    """Schema for assignment response"""
    id: int
    assessment_id: int
    teacher_id: int
    qr_code: Optional[str] = None
    share_link: Optional[str] = None
    is_active: bool
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


class AssignmentSubmissionCreate(BaseModel):
    """Schema for submitting an assignment"""
    answers: Dict[int, str]  # {item_id: answer}


class AssignmentSubmissionResponse(BaseModel):
    """Schema for assignment submission response"""
    id: int
    assignment_id: int
    student_id: int
    score: Optional[float] = None
    max_score: Optional[float] = None
    is_graded: bool
    feedback: Optional[str] = None
    is_late: bool
    submitted_at: datetime
    graded_at: Optional[datetime] = None
    
    class Config:
        from_attributes = True
