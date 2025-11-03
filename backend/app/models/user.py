"""
User model
"""
from sqlalchemy import Column, Integer, String, Boolean, DateTime, Enum as SQLEnum
from sqlalchemy.orm import relationship
from datetime import datetime
import enum

from app.utils.database import Base


class UserRole(str, enum.Enum):
    """User roles"""
    TEACHER = "teacher"
    STUDENT = "student"
    ADMIN = "admin"


class User(Base):
    """User model"""
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    username = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    full_name = Column(String)
    role = Column(SQLEnum(UserRole), default=UserRole.TEACHER)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    chapters = relationship("Chapter", back_populates="teacher")
    assessments = relationship("Assessment", back_populates="creator")
    assignments = relationship("Assignment", back_populates="teacher")
    submissions = relationship("AssignmentSubmission", back_populates="student")
