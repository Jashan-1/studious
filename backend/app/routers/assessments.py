"""
Assessment generation and management routes
"""
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from app.models.assessment import Assessment, AssessmentItem, AssessmentType
from app.models.chapter import Chapter
from app.models.user import User
from app.schemas.assessment import AssessmentCreate, AssessmentResponse, AssessmentItemCreate
from app.routers.users import get_current_teacher
from app.utils.database import get_db
from app.services.llm_service import LLMService

router = APIRouter()


@router.post("/", response_model=AssessmentResponse, status_code=status.HTTP_201_CREATED)
async def create_assessment(
    assessment_data: AssessmentCreate,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Create a new assessment"""
    # Verify chapter exists and belongs to teacher
    chapter = db.query(Chapter).filter(
        Chapter.id == assessment_data.chapter_id,
        Chapter.teacher_id == current_user.id
    ).first()
    
    if not chapter:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Chapter not found"
        )
    
    # Only generate for custom uploaded chapters
    if not chapter.is_custom or not chapter.content_text:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Assessment generation only available for custom uploaded chapters with processed content"
        )
    
    # Create assessment
    assessment_dict = assessment_data.dict(exclude={'items', 'chapter_id'})
    new_assessment = Assessment(
        **assessment_dict,
        chapter_id=assessment_data.chapter_id,
        creator_id=current_user.id,
        auto_generated=True
    )
    
    db.add(new_assessment)
    db.flush()
    
    # Auto-generate items if chapter content is available
    if chapter.content_text:
        llm_service = LLMService()
        generated_items = llm_service.generate_assessment(
            chapter_content=chapter.content_text,
            assessment_type=assessment_data.assessment_type,
            num_questions=10,  # Default
            difficulty=assessment_data.difficulty_level,
            cognitive_level=assessment_data.cognitive_level,
            learning_outcomes=assessment_data.learning_outcomes
        )
        
        # Create assessment items from generated content
        for idx, item_data in enumerate(generated_items):
            assessment_item = AssessmentItem(
                assessment_id=new_assessment.id,
                question_text=item_data.get('question_text', ''),
                question_type='multiple_choice' if assessment_data.assessment_type == AssessmentType.MCQ else 'short_answer',
                options=item_data.get('options', []),
                correct_answer=item_data.get('correct_answer', ''),
                difficulty=assessment_data.difficulty_level,
                cognitive_level=assessment_data.cognitive_level,
                points=item_data.get('points', 1),
                order=idx
            )
            db.add(assessment_item)
    
    # Add manually created items if provided
    if assessment_data.items:
        for item_data in assessment_data.items:
            item_dict = item_data.dict() if hasattr(item_data, 'dict') else item_data
            assessment_item = AssessmentItem(
                assessment_id=new_assessment.id,
                **item_dict
            )
            db.add(assessment_item)
    
    db.commit()
    db.refresh(new_assessment)
    
    return new_assessment


@router.get("/", response_model=List[AssessmentResponse])
async def list_assessments(
    chapter_id: int = None,
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """List assessments"""
    query = db.query(Assessment).filter(Assessment.creator_id == current_user.id)
    
    if chapter_id:
        query = query.filter(Assessment.chapter_id == chapter_id)
    
    assessments = query.offset(skip).limit(limit).all()
    
    return assessments


@router.get("/{assessment_id}", response_model=AssessmentResponse)
async def get_assessment(
    assessment_id: int,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Get assessment details"""
    assessment = db.query(Assessment).filter(
        Assessment.id == assessment_id,
        Assessment.creator_id == current_user.id
    ).first()
    
    if not assessment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Assessment not found"
        )
    
    return assessment


@router.put("/{assessment_id}/items/{item_id}")
async def update_assessment_item(
    assessment_id: int,
    item_id: int,
    item_data: AssessmentItemCreate,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Update an assessment item"""
    assessment = db.query(Assessment).filter(
        Assessment.id == assessment_id,
        Assessment.creator_id == current_user.id
    ).first()
    
    if not assessment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Assessment not found"
        )
    
    item = db.query(AssessmentItem).filter(
        AssessmentItem.id == item_id,
        AssessmentItem.assessment_id == assessment_id
    ).first()
    
    if not item:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Assessment item not found"
        )
    
    # Update item
    update_data = item_data.dict(exclude_unset=True)
    for field, value in update_data.items():
        setattr(item, field, value)
    
    db.commit()
    db.refresh(item)
    
    return item


@router.delete("/{assessment_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_assessment(
    assessment_id: int,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Delete an assessment"""
    assessment = db.query(Assessment).filter(
        Assessment.id == assessment_id,
        Assessment.creator_id == current_user.id
    ).first()
    
    if not assessment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Assessment not found"
        )
    
    db.delete(assessment)
    db.commit()
    
    return None
