"""
Discussion schemas
"""
from pydantic import BaseModel
from datetime import datetime
from typing import Optional


class DiscussionMessageBase(BaseModel):
    """Base discussion message schema"""
    message_text: str


class DiscussionMessageCreate(DiscussionMessageBase):
    """Schema for creating a discussion message"""
    parent_message_id: Optional[int] = None


class DiscussionMessageResponse(DiscussionMessageBase):
    """Schema for discussion message response"""
    id: int
    discussion_id: int
    user_id: int
    parent_message_id: Optional[int] = None
    is_ai_generated: bool
    is_approved: bool
    is_pinned: bool
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


class DiscussionBase(BaseModel):
    """Base discussion schema"""
    title: str


class DiscussionCreate(DiscussionBase):
    """Schema for creating a discussion"""
    chapter_id: Optional[int] = None
    assessment_id: Optional[int] = None
    assignment_id: Optional[int] = None
    item_id: Optional[int] = None


class DiscussionResponse(DiscussionBase):
    """Schema for discussion response"""
    id: int
    chapter_id: Optional[int] = None
    assessment_id: Optional[int] = None
    assignment_id: Optional[int] = None
    item_id: Optional[int] = None
    qr_code: Optional[str] = None
    share_link: Optional[str] = None
    is_moderated: bool
    messages: list[DiscussionMessageResponse] = []
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True
