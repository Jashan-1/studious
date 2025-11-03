"""
Mastery tracking model
"""
from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, Float, JSON
from sqlalchemy.orm import relationship
from datetime import datetime

from app.utils.database import Base


class MasteryTracking(Base):
    """Mastery tracking by learning outcome and chapter"""
    __tablename__ = "mastery_tracking"
    
    id = Column(Integer, primary_key=True, index=True)
    student_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    chapter_id = Column(Integer, ForeignKey("chapters.id"), nullable=False)
    
    # Learning outcome tracking
    learning_outcome = Column(String)
    competency_score = Column(Float)  # 0.0 to 1.0
    
    # Aggregated metrics
    total_attempts = Column(Integer, default=0)
    total_correct = Column(Integer, default=0)
    average_score = Column(Float)
    
    # Growth tracking
    scores_history = Column(JSON)  # List of historical scores
    
    # Recommendations
    suggested_remediation = Column(JSON)  # AI-suggested remediation paths
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    student = relationship("User")
    chapter = relationship("Chapter")
