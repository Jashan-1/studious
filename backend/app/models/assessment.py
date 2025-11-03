"""
Assessment models
"""
from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime, Boolean, JSON, Enum as SQLEnum
from sqlalchemy.orm import relationship
from datetime import datetime
import enum

from app.utils.database import Base


class AssessmentType(str, enum.Enum):
    """Assessment types"""
    MCQ = "mcq"
    QUIZ = "quiz"
    UNIT_TEST = "unit_test"
    ONE_NIGHTER = "one_nighter"
    QA = "qa"


class DifficultyLevel(str, enum.Enum):
    """Difficulty levels"""
    EASY = "easy"
    MEDIUM = "medium"
    HARD = "hard"


class CognitiveLevel(str, enum.Enum):
    """Cognitive levels (Bloom's taxonomy)"""
    REMEMBER = "remember"
    UNDERSTAND = "understand"
    APPLY = "apply"
    ANALYZE = "analyze"
    EVALUATE = "evaluate"
    CREATE = "create"


class Assessment(Base):
    """Assessment model"""
    __tablename__ = "assessments"
    
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    description = Column(Text)
    assessment_type = Column(SQLEnum(AssessmentType), nullable=False)
    
    # Relationships
    chapter_id = Column(Integer, ForeignKey("chapters.id"), nullable=False)
    creator_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    
    # Metadata
    difficulty_level = Column(SQLEnum(DifficultyLevel))
    cognitive_level = Column(SQLEnum(CognitiveLevel))
    learning_outcomes = Column(JSON)  # List of LOs covered
    
    # Generation settings
    auto_generated = Column(Boolean, default=True)
    is_editable = Column(Boolean, default=True)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    chapter = relationship("Chapter", back_populates="assessments")
    creator = relationship("User", back_populates="assessments")
    items = relationship("AssessmentItem", back_populates="assessment", cascade="all, delete-orphan")
    assignments = relationship("Assignment", back_populates="assessment")


class AssessmentItem(Base):
    """Individual assessment item (question)"""
    __tablename__ = "assessment_items"
    
    id = Column(Integer, primary_key=True, index=True)
    assessment_id = Column(Integer, ForeignKey("assessments.id"), nullable=False)
    
    # Question content
    question_text = Column(Text, nullable=False)
    question_type = Column(String)  # "multiple_choice", "short_answer", "long_answer"
    
    # For MCQs
    options = Column(JSON)  # ["option1", "option2", ...]
    correct_answer = Column(String)
    
    # For short/long answers
    answer_key = Column(Text)
    rubric = Column(JSON)  # Grading rubric
    
    # Metadata
    difficulty = Column(SQLEnum(DifficultyLevel))
    cognitive_level = Column(SQLEnum(CognitiveLevel))
    points = Column(Integer, default=1)
    order = Column(Integer, default=0)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    assessment = relationship("Assessment", back_populates="items")
