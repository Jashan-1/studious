"""
Assessment schemas
"""
from pydantic import BaseModel
from datetime import datetime
from typing import Optional, List

from app.models.assessment import AssessmentType, DifficultyLevel, CognitiveLevel


class AssessmentItemBase(BaseModel):
    """Base assessment item schema"""
    question_text: str
    question_type: str
    options: Optional[List[str]] = None
    correct_answer: Optional[str] = None
    answer_key: Optional[str] = None
    rubric: Optional[dict] = None
    difficulty: Optional[DifficultyLevel] = None
    cognitive_level: Optional[CognitiveLevel] = None
    points: int = 1
    order: int = 0


class AssessmentItemCreate(AssessmentItemBase):
    """Schema for creating an assessment item"""
    pass


class AssessmentItemResponse(AssessmentItemBase):
    """Schema for assessment item response"""
    id: int
    assessment_id: int
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


class AssessmentBase(BaseModel):
    """Base assessment schema"""
    title: str
    description: Optional[str] = None
    assessment_type: AssessmentType
    difficulty_level: Optional[DifficultyLevel] = None
    cognitive_level: Optional[CognitiveLevel] = None
    learning_outcomes: Optional[List[str]] = None


class AssessmentCreate(AssessmentBase):
    """Schema for creating an assessment"""
    chapter_id: int
    items: Optional[List[AssessmentItemCreate]] = None


class AssessmentResponse(AssessmentBase):
    """Schema for assessment response"""
    id: int
    chapter_id: int
    creator_id: int
    auto_generated: bool
    is_editable: bool
    items: List[AssessmentItemResponse] = []
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True
