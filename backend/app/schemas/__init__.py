"""
Pydantic schemas for request/response validation
"""
from app.schemas.user import UserCreate, UserResponse, UserLogin
from app.schemas.chapter import ChapterCreate, ChapterResponse, ChapterUpdate
from app.schemas.assessment import AssessmentCreate, AssessmentResponse, AssessmentItemCreate, AssessmentItemResponse
from app.schemas.assignment import AssignmentCreate, AssignmentResponse, AssignmentSubmissionCreate, AssignmentSubmissionResponse
from app.schemas.discussion import DiscussionCreate, DiscussionResponse, DiscussionMessageCreate, DiscussionMessageResponse
from app.schemas.mastery import MasteryTrackingResponse

__all__ = [
    "UserCreate",
    "UserResponse",
    "UserLogin",
    "ChapterCreate",
    "ChapterResponse",
    "ChapterUpdate",
    "AssessmentCreate",
    "AssessmentResponse",
    "AssessmentItemCreate",
    "AssessmentItemResponse",
    "AssignmentCreate",
    "AssignmentResponse",
    "AssignmentSubmissionCreate",
    "AssignmentSubmissionResponse",
    "DiscussionCreate",
    "DiscussionResponse",
    "DiscussionMessageCreate",
    "DiscussionMessageResponse",
    "MasteryTrackingResponse",
]
