"""
Grading service for auto-grading and feedback generation
"""
from typing import Dict, List, Optional
from app.models.assessment import AssessmentItem
from app.models.assignment import AssignmentSubmission


class GradingService:
    """Service for grading assignments"""
    
    def grade_mcq(self, item: AssessmentItem, student_answer: str) -> Dict:
        """Grade a multiple choice question"""
        is_correct = student_answer.strip().lower() == item.correct_answer.strip().lower()
        
        return {
            'item_id': item.id,
            'student_answer': student_answer,
            'correct_answer': item.correct_answer,
            'is_correct': is_correct,
            'points_earned': item.points if is_correct else 0,
            'max_points': item.points
        }
    
    def grade_submission(
        self,
        submission: AssignmentSubmission,
        assessment_items: List[AssessmentItem],
        answers: Dict[int, str],
        auto_grade: bool = True
    ) -> Dict:
        """Grade an entire submission"""
        total_points = 0
        max_points = sum(item.points for item in assessment_items)
        graded_items = []
        
        for item in assessment_items:
            if item.id not in answers:
                continue
            
            student_answer = answers[item.id]
            
            # Auto-grade MCQs
            if auto_grade and item.question_type == "multiple_choice":
                result = self.grade_mcq(item, student_answer)
                total_points += result['points_earned']
                graded_items.append(result)
            else:
                # Manual grading required for short/long answers
                graded_items.append({
                    'item_id': item.id,
                    'student_answer': student_answer,
                    'points_earned': None,  # To be graded manually
                    'max_points': item.points,
                    'requires_manual_grading': True
                })
        
        return {
            'submission_id': submission.id,
            'total_points': total_points,
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
