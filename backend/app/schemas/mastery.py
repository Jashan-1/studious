"""
Mastery tracking schemas
"""
from pydantic import BaseModel
from datetime import datetime
from typing import Optional, List


class MasteryTrackingResponse(BaseModel):
    """Schema for mastery tracking response"""
    id: int
    student_id: int
    chapter_id: int
    learning_outcome: Optional[str] = None
    competency_score: Optional[float] = None
    total_attempts: int
    total_correct: int
    average_score: Optional[float] = None
    scores_history: Optional[List[float]] = None
    suggested_remediation: Optional[dict] = None
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True
