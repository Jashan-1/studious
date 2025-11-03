"""
Discussion models
"""
from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime, Boolean
from sqlalchemy.orm import relationship
from datetime import datetime

from app.utils.database import Base


class Discussion(Base):
    """Discussion thread model"""
    __tablename__ = "discussions"
    
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    
    # Relationships
    chapter_id = Column(Integer, ForeignKey("chapters.id"))
    assessment_id = Column(Integer, ForeignKey("assessments.id"))
    assignment_id = Column(Integer, ForeignKey("assignments.id"))
    item_id = Column(Integer, ForeignKey("assessment_items.id"))  # Specific question discussion
    
    # Access
    qr_code = Column(String, unique=True, index=True)
    share_link = Column(String, unique=True, index=True)
    
    # Moderation
    is_moderated = Column(Boolean, default=True)
    moderator_id = Column(Integer, ForeignKey("users.id"))
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    chapter = relationship("Chapter", back_populates="discussions")
    messages = relationship("DiscussionMessage", back_populates="discussion", cascade="all, delete-orphan")


class DiscussionMessage(Base):
    """Individual message in a discussion"""
    __tablename__ = "discussion_messages"
    
    id = Column(Integer, primary_key=True, index=True)
    discussion_id = Column(Integer, ForeignKey("discussions.id"), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    parent_message_id = Column(Integer, ForeignKey("discussion_messages.id"))  # For threaded replies
    
    # Content
    message_text = Column(Text, nullable=False)
    is_ai_generated = Column(Boolean, default=False)  # AI hints/solutions
    
    # Moderation
    is_approved = Column(Boolean, default=True)
    is_pinned = Column(Boolean, default=False)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    discussion = relationship("Discussion", back_populates="messages", foreign_keys=[discussion_id])
    user = relationship("User")
    parent = relationship("DiscussionMessage", remote_side=[id])
