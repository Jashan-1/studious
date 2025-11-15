"""
Grading service for auto-grading and feedback generation
"""
from typing import Dict, List, Optional
# --- Mock Models (Replace with your actual imports) ---
# Using mocks to make the file self-contained for review
class AssignmentSubmission:
    def __init__(self, id, student_id, assignment_id, status, score=None):
        self.id = id
        self.student_id = student_id
        self.assignment_id = assignment_id
        self.status = status
        self.score = score

class AssessmentItem:
    def __init__(self, id, question_type, points, correct_answer):
        self.id = id
        self.question_type = question_type
        self.points = points
        self.correct_answer = correct_answer
# --- End Mock Models ---


# --- Service Imports ---
from .vision_service import VisionService
from .embedding_service import EmbeddingService
from .originality_service import OriginalityService
# --------------------

class GradingService:
    """Service for grading assignments"""
    
    def __init__(self):
        """
        Initialize the grading service and its AI sub-services.
        In a production FastAPI app, these might be injected.
        """
        self.vision_service = VisionService()
        self.embedding_service = EmbeddingService()
        self.originality_service = OriginalityService(self.embedding_service)

    def grade_mcq(self, item: AssessmentItem, student_answer: str) -> Dict:
        """Grade a multiple choice question"""
        is_correct = student_answer.strip().lower() == item.correct_answer.strip().lower()
        
        return {
            'item_id': item.id,
            'student_answer': student_answer,
            'correct_answer': item.correct_answer,
            'is_correct': is_correct,
            'points_earned': item.points if is_correct else 0,
            'max_points': item.points,
            'requires_manual_grading': False
        }

    def _grade_with_ai(
        self,
        submission_id: int,
        item: AssessmentItem,
        file_path: str, # Path to the uploaded file
        file_mime_type: str, # e.g., 'application/pdf'
        other_student_texts: List[str], # For Module B
        chapter_context_text: str # For Module A
    ) -> Dict:
        """
        Run the full AI pre-grading pipeline for a single item.
        This provides data for a teacher to review.
        """
        # 1. Module VLM: Extract text from image/PDF
        # This also saves the output to "grading_outputs/"
        extracted_text = self.vision_service.extract_text_from_file(
            file_path=file_path,
            submission_id=submission_id,
            item_id=item.id,
            mime_type=file_mime_type
        )
        
        if extracted_text.startswith("[Error"):
            return {
                'item_id': item.id,
                'student_answer_path': file_path,
                'points_earned': None,
                'max_points': item.points,
                'requires_manual_grading': True,
                'ai_assistance': {"error": extracted_text}
            }

        # This will be the dict returned to the teacher
        ai_assistance = {
            "extracted_text_file": f"grading_outputs/submission_{submission_id}_item_{item.id}.txt"
        }
        
        # 2. Module A: Embedding Similarity
        # Compare student's answer to the "model answer" (rubric)
        # and the broader "chapter context"
        
        model_answer_embedding = self.embedding_service.get_embedding(item.correct_answer)
        student_answer_embedding = self.embedding_service.get_embedding(extracted_text)
        
        ai_assistance["similarity_to_model_answer"] = self.embedding_service.calculate_similarity(
            student_answer_embedding, model_answer_embedding
        )
        
        # Compare to chapter context
        chapter_context_embedding = self.embedding_service.get_embedding(chapter_context_text)
        ai_assistance["relevance_to_chapter"] = self.embedding_service.calculate_similarity(
            student_answer_embedding, chapter_context_embedding
        )
        
        # 3. Module B: Fuzzy Duplicate Detection (Student-to-Student)
        ai_assistance["student_duplicates"] = self.originality_service.check_student_similarity(
            target_text=extracted_text,
            other_texts=other_student_texts
        )
        
        # 4. Module C: Web Snippet Check
        ai_assistance["web_plagiarism_report"] = self.originality_service.check_web_plagiarism(
            student_text=extracted_text
        )
        
        return {
            'item_id': item.id,
            'student_answer_path': file_path,
            'points_earned': None,  # Still needs manual review
            'max_points': item.points,
            'requires_manual_grading': True, # AI provides assistance, not final grade
            'ai_assistance': ai_assistance # This is the new data for the teacher
        }

    
    def grade_submission(
        self,
        submission: AssignmentSubmission,
        assessment_items: List[AssessmentItem],
        answers: Dict[int, str],
        # --- NEW PARAMETERS from background task ---
        file_mime_types: Dict[int, str],
        all_submission_texts_map: Dict[int, List[str]]
        # -------------------------------------------
    ) -> Dict:
        """
        Grade an entire submission.
        - MCQs are auto-graded.
        - Other types are sent to the AI pipeline for pre-grading analysis.
        
        :param submission: The submission DB object
        :param assessment_items: List of all item objects for this assignment
        :param answers: Dict mapping {item_id: "student_answer"}.
                        For MCQs, this is the choice (e.g., "A").
                        For files, this is the file_path (e.g., "temp_uploads/...")
        :param file_mime_types: Dict mapping {item_id: "mime_type"}
        :param all_submission_texts_map: Dict mapping {item_id: [list of other texts]}
        :return: A dictionary with the full grading result.
        """
        total_points = 0 # This will only track auto-graded points
        max_points = sum(item.points for item in assessment_items)
        graded_items = []

        for item in assessment_items:
            if item.id not in answers:
                # Item was not answered
                graded_items.append({
                    'item_id': item.id,
                    'student_answer': None,
                    'points_earned': 0,
                    'max_points': item.points,
                    'requires_manual_grading': False,
                    'ai_assistance': {"error": "No answer provided."}
                })
                continue
            
            student_answer = answers[item.id]
            
            # Auto-grade MCQs
            if item.question_type == "multiple_choice":
                result = self.grade_mcq(item, student_answer)
                total_points += result['points_earned']
                graded_items.append(result)
            
            # Send file-based answers to the AI pipeline
            else:
                # Get the mime_type for this specific file
                item_mime_type = file_mime_types.get(item.id, "application/octet-stream")
                
                # Get other student texts for this specific item
                other_texts_for_item = all_submission_texts_map.get(item.id, [])

                # This is a placeholder. In a real app, you would fetch
                # the chapter text associated with this item from your DB.
                chapter_context = "Text from the chapter this item relates to..." 

                ai_result = self._grade_with_ai(
                    submission_id=submission.id,
                    item=item,
                    file_path=student_answer, # This is the path to the temp file
                    file_mime_type=item_mime_type,
                    other_student_texts=other_texts_for_item,
                    chapter_context_text=chapter_context
                )
                graded_items.append(ai_result)
        
        return {
            'submission_id': submission.id,
            'total_points': total_points, # Note: This is only the auto-graded score
            'max_points': max_points,
            'score_percentage': (total_points / max_points * 100) if max_points > 0 else 0,
            'graded_items': graded_items,
            'requires_manual_grading': any(
                item.get('requires_manual_grading', False) 
                for item in graded_items
            )
        }
    
    def generate_feedback(
        self,
        submission_id: int,
        score: float,
        max_score: float,
        weak_areas: Optional[List[str]] = None
    ) -> str:
        """Generate feedback for a submission"""
        percentage = (score / max_score * 100) if max_score > 0 else 0
        
        feedback = f"Score: {score:.1f}/{max_score:.1f} ({percentage:.1f}%)\n\n"
        
        if percentage >= 80:
            feedback += "Excellent work! You have a strong understanding of the concepts."
        elif percentage >= 60:
            feedback += "Good effort! Review the areas you missed to strengthen your understanding."
        else:
            feedback += "Keep practicing! Focus on reviewing the chapter content and attempting more questions."
        
        if weak_areas:
            feedback += "\n\nAreas to focus on:\n"
            for area in weak_areas:
                feedback += f"- {area}\n"
        
        return feedback
    
    def calculate_mastery_metrics(
        self,
        student_id: int,
        chapter_id: int,
        submissions: List[AssignmentSubmission]
    ) -> Dict:
        """Calculate mastery metrics from submission history"""
        if not submissions:
            return {
                'student_id': student_id,
                'chapter_id': chapter_id,
                'total_attempts': 0,
                'average_score': 0,
                'improvement_trend': []
            }
        
        scores = [s.score for s in submissions if s.score is not None]
        total_attempts = len(submissions)
        average_score = sum(scores) / len(scores) if scores else 0
        
        # Calculate improvement trend (simplified)
        improvement_trend = scores[:]  # In production, track over time periods
        
        return {
            'student_id': student_id,
            'chapter_id': chapter_id,
            'total_attempts': total_attempts,
            'average_score': average_score,
            'improvement_trend': improvement_trend,
            'weak_areas': []  # To be calculated based on item-level analysis
        }