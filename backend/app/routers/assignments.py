"""
Assignment management and grading routes
"""
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from app.models.assignment import Assignment, AssignmentSubmission
from app.models.assessment import Assessment
from app.models.user import User, UserRole
from app.schemas.assignment import (
    AssignmentCreate, AssignmentResponse,
    AssignmentSubmissionCreate, AssignmentSubmissionResponse
)
from app.routers.users import get_current_user, get_current_teacher
from app.utils.database import get_db
from app.utils.qr_code import generate_share_token, generate_share_link
from app.services.grading_service import GradingService
from app.config import settings

router = APIRouter()


@router.post("/", response_model=AssignmentResponse, status_code=status.HTTP_201_CREATED)
async def create_assignment(
    assignment_data: AssignmentCreate,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Create a new assignment"""
    # Verify assessment exists and belongs to teacher
    assessment = db.query(Assessment).filter(
        Assessment.id == assignment_data.assessment_id,
        Assessment.creator_id == current_user.id
    ).first()
    
    if not assessment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Assessment not found"
        )
    
    # Generate QR code and share link
    share_token = generate_share_token()
    qr_code = share_token
    share_link = generate_share_link(
        settings.APP_NAME,  # Base URL from settings
        share_token,
        "assignment"
    )
    
    new_assignment = Assignment(
        **assignment_data.dict(),
        teacher_id=current_user.id,
        qr_code=qr_code,
        share_link=share_link
    )
    
    db.add(new_assignment)
    db.commit()
    db.refresh(new_assignment)
    
    return new_assignment


@router.get("/", response_model=List[AssignmentResponse])
async def list_assignments(
    class_id: str = None,
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """List assignments"""
    query = db.query(Assignment)
    
    if current_user.role == UserRole.TEACHER:
        query = query.filter(Assignment.teacher_id == current_user.id)
    
    if class_id:
        query = query.filter(Assignment.class_id == class_id)
    
    assignments = query.offset(skip).limit(limit).all()
    
    return assignments


@router.get("/{assignment_id}", response_model=AssignmentResponse)
async def get_assignment(
    assignment_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get assignment details"""
    assignment = db.query(Assignment).filter(Assignment.id == assignment_id).first()
    
    if not assignment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Assignment not found"
        )
    
    # Verify access
    if current_user.role == UserRole.TEACHER and assignment.teacher_id != current_user.id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Not authorized"
        )
    
    return assignment


@router.get("/qr/{qr_code}", response_model=AssignmentResponse)
async def get_assignment_by_qr(
    qr_code: str,
    db: Session = Depends(get_db)
):
    """Get assignment by QR code (public endpoint)"""
    assignment = db.query(Assignment).filter(Assignment.qr_code == qr_code).first()
    
    if not assignment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Assignment not found"
        )
    
    if not assignment.is_active:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Assignment is not active"
        )
    
    return assignment


@router.post("/{assignment_id}/submit", response_model=AssignmentSubmissionResponse, status_code=status.HTTP_201_CREATED)
async def submit_assignment(
    assignment_id: int,
    submission_data: AssignmentSubmissionCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Submit an assignment"""
    assignment = db.query(Assignment).filter(Assignment.id == assignment_id).first()
    
    if not assignment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Assignment not found"
        )
    
    if not assignment.is_active:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Assignment is not active"
        )
    
    # Check if student has already submitted max attempts
    existing_submissions = db.query(AssignmentSubmission).filter(
        AssignmentSubmission.assignment_id == assignment_id,
        AssignmentSubmission.student_id == current_user.id
    ).count()
    
    if existing_submissions >= assignment.max_attempts:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Maximum attempts exceeded"
        )
    
    # Create submission
    new_submission = AssignmentSubmission(
        assignment_id=assignment_id,
        student_id=current_user.id,
        answers=submission_data.answers
    )
    
    # Check if late
    if assignment.due_date and not assignment.allow_late_submission:
        from datetime import datetime
        if datetime.utcnow() > assignment.due_date:
            new_submission.is_late = True
    
    db.add(new_submission)
    db.flush()
    
    # Auto-grade if enabled
    if assignment.auto_grade:
        grading_service = GradingService()
        assessment = db.query(Assessment).filter(Assessment.id == assignment.assessment_id).first()
        
        if assessment:
            items = assessment.items
            grading_result = grading_service.grade_submission(
                new_submission,
                items,
                submission_data.answers,
                auto_grade=True
            )
            
            new_submission.score = grading_result['total_points']
            new_submission.max_score = grading_result['max_points']
            new_submission.is_graded = not grading_result['requires_manual_grading']
            
            if new_submission.is_graded:
                new_submission.feedback = grading_service.generate_feedback(
                    new_submission.id,
                    grading_result['total_points'],
                    grading_result['max_points']
                )
    
    db.commit()
    db.refresh(new_submission)
    
    return new_submission


@router.get("/{assignment_id}/submissions", response_model=List[AssignmentSubmissionResponse])
async def list_submissions(
    assignment_id: int,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """List submissions for an assignment (teacher only)"""
    assignment = db.query(Assignment).filter(
        Assignment.id == assignment_id,
        Assignment.teacher_id == current_user.id
    ).first()
    
    if not assignment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Assignment not found"
        )
    
    submissions = db.query(AssignmentSubmission).filter(
        AssignmentSubmission.assignment_id == assignment_id
    ).all()
    
    return submissions


@router.post("/{assignment_id}/submissions/{submission_id}/grade")
async def grade_submission(
    assignment_id: int,
    submission_id: int,
    score: float,
    feedback: str = None,
    current_user: User = Depends(get_current_teacher),
    db: Session = Depends(get_db)
):
    """Grade a submission manually (teacher only)"""
    assignment = db.query(Assignment).filter(
        Assignment.id == assignment_id,
        Assignment.teacher_id == current_user.id
    ).first()
    
    if not assignment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Assignment not found"
        )
    
    submission = db.query(AssignmentSubmission).filter(
        AssignmentSubmission.id == submission_id,
        AssignmentSubmission.assignment_id == assignment_id
    ).first()
    
    if not submission:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Submission not found"
        )
    
    # Update grading
    assessment = db.query(Assessment).filter(Assessment.id == assignment.assessment_id).first()
    max_score = sum(item.points for item in assessment.items) if assessment else score
    
    submission.score = score
    submission.max_score = max_score
    submission.is_graded = True
    submission.feedback = feedback
    submission.graded_by = current_user.id
    from datetime import datetime
    submission.graded_at = datetime.utcnow()
    
    db.commit()
    db.refresh(submission)
    
    return submission
