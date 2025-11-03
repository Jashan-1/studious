"""
User schemas
"""
from pydantic import BaseModel, EmailStr
from datetime import datetime
from typing import Optional

from app.models.user import UserRole


class UserBase(BaseModel):
    """Base user schema"""
    email: EmailStr
    username: str
    full_name: Optional[str] = None
    role: UserRole = UserRole.TEACHER


class UserCreate(UserBase):
    """Schema for creating a user"""
    password: str


class UserLogin(BaseModel):
    """Schema for user login"""
    email: EmailStr
    password: str


class UserResponse(UserBase):
    """Schema for user response"""
    id: int
    is_active: bool
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True
