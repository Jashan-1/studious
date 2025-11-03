"""
Discussion management routes
"""
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from app.models.discussion import Discussion, DiscussionMessage
from app.models.chapter import Chapter
from app.models.user import User
from app.schemas.discussion import (
    DiscussionCreate, DiscussionResponse,
    DiscussionMessageCreate, DiscussionMessageResponse
)
from app.routers.users import get_current_user, get_current_teacher
from app.utils.database import get_db
from app.utils.qr_code import generate_share_token, generate_share_link
from app.services.llm_service import LLMService
from app.config import settings

router = APIRouter()


@router.post("/", response_model=DiscussionResponse, status_code=status.HTTP_201_CREATED)
async def create_discussion(
    discussion_data: DiscussionCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Create a new discussion thread"""
    # Verify related entity exists
    if discussion_data.chapter_id:
        chapter = db.query(Chapter).filter(Chapter.id == discussion_data.chapter_id).first()
        if not chapter:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Chapter not found"
            )
    
    # Generate QR code and share link
    share_token = generate_share_token()
    qr_code = share_token
    share_link = generate_share_link(
        settings.APP_NAME,
        share_token,
        "discussion"
    )
    
    new_discussion = Discussion(
        **discussion_data.dict(),
        qr_code=qr_code,
        share_link=share_link,
        moderator_id=current_user.id if current_user.role.value == "teacher" else None
    )
    
    db.add(new_discussion)
    db.commit()
    db.refresh(new_discussion)
    
    return new_discussion


@router.get("/", response_model=List[DiscussionResponse])
async def list_discussions(
    chapter_id: int = None,
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db)
):
    """List discussions"""
    query = db.query(Discussion)
    
    if chapter_id:
        query = query.filter(Discussion.chapter_id == chapter_id)
    
    discussions = query.offset(skip).limit(limit).all()
    
    return discussions


@router.get("/{discussion_id}", response_model=DiscussionResponse)
async def get_discussion(
    discussion_id: int,
    db: Session = Depends(get_db)
):
    """Get discussion details"""
    discussion = db.query(Discussion).filter(Discussion.id == discussion_id).first()
    
    if not discussion:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Discussion not found"
        )
    
    return discussion


@router.post("/{discussion_id}/messages", response_model=DiscussionMessageResponse, status_code=status.HTTP_201_CREATED)
async def create_message(
    discussion_id: int,
    message_data: DiscussionMessageCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Create a message in a discussion"""
    discussion = db.query(Discussion).filter(Discussion.id == discussion_id).first()
    
    if not discussion:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Discussion not found"
        )
    
    new_message = DiscussionMessage(
        discussion_id=discussion_id,
        user_id=current_user.id,
        message_text=message_data.message_text,
        parent_message_id=message_data.parent_message_id
    )
    
    db.add(new_message)
    db.commit()
    db.refresh(new_message)
    
    return new_message


@router.post("/{discussion_id}/ai-hint")
async def generate_ai_hint(
    discussion_id: int,
    question: str,
    answer: str = None,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Generate AI hint or solution for a question"""
    discussion = db.query(Discussion).filter(Discussion.id == discussion_id).first()
    
    if not discussion:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Discussion not found"
        )
    
    llm_service = LLMService()
    
    if answer:
        solution = llm_service.generate_solution(question, answer)
        
        # Create AI-generated message
        ai_message = DiscussionMessage(
            discussion_id=discussion_id,
            user_id=current_user.id,  # Or system user
            message_text=solution,
            is_ai_generated=True
        )
        
        db.add(ai_message)
        db.commit()
        db.refresh(ai_message)
        
        return {"message": solution, "message_id": ai_message.id}
    else:
        # Generate hint only
        hint = llm_service.generate_hint(question, "")
        
        ai_message = DiscussionMessage(
            discussion_id=discussion_id,
            user_id=current_user.id,
            message_text=hint,
            is_ai_generated=True
        )
        
        db.add(ai_message)
        db.commit()
        db.refresh(ai_message)
        
        return {"hint": hint, "message_id": ai_message.id}


@router.get("/{discussion_id}/messages", response_model=List[DiscussionMessageResponse])
async def list_messages(
    discussion_id: int,
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db)
):
    """List messages in a discussion"""
    messages = db.query(DiscussionMessage).filter(
        DiscussionMessage.discussion_id == discussion_id
    ).offset(skip).limit(limit).all()
    
    return messages


@router.put("/{discussion_id}/messages/{message_id}/approve")
async def approve_message(
    discussion_id: int,
    message_id: int,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Approve a message (moderator only)"""
    discussion = db.query(Discussion).filter(
        Discussion.id == discussion_id,
        Discussion.moderator_id == current_user.id
    ).first()
    
    if not discussion:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Discussion not found or not authorized"
        )
    
    message = db.query(DiscussionMessage).filter(
        DiscussionMessage.id == message_id,
        DiscussionMessage.discussion_id == discussion_id
    ).first()
    
    if not message:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Message not found"
        )
    
    message.is_approved = True
    db.commit()
    db.refresh(message)
    
    return message
