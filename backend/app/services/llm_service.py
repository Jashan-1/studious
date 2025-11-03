"""
LLM service for auto-generating assessments
"""
from typing import List, Dict, Optional
import openai
from anthropic import Anthropic

from app.config import settings
from app.models.assessment import AssessmentType, DifficultyLevel, CognitiveLevel


class LLMService:
    """Service for LLM-based content generation"""
    
    def __init__(self):
        self.provider = settings.LLM_PROVIDER
        self.model = settings.LLM_MODEL
        self.max_tokens = settings.LLM_MAX_TOKENS
        
        if self.provider == "openai":
            openai.api_key = settings.LLM_API_KEY
        elif self.provider == "anthropic":
            self.client = Anthropic(api_key=settings.LLM_API_KEY)
    
    def generate_assessment(
        self,
        chapter_content: str,
        assessment_type: AssessmentType,
        num_questions: int = 10,
        difficulty: Optional[DifficultyLevel] = None,
        cognitive_level: Optional[CognitiveLevel] = None,
        learning_outcomes: Optional[List[str]] = None
    ) -> List[Dict]:
        """Generate assessment items based on chapter content"""
        
        prompt = self._build_assessment_prompt(
            chapter_content,
            assessment_type,
            num_questions,
            difficulty,
            cognitive_level,
            learning_outcomes
        )
        
        if self.provider == "openai":
            return self._generate_with_openai(prompt, assessment_type)
        elif self.provider == "anthropic":
            return self._generate_with_anthropic(prompt, assessment_type)
        else:
            raise ValueError(f"Unsupported LLM provider: {self.provider}")
    
    def _build_assessment_prompt(
        self,
        content: str,
        assessment_type: AssessmentType,
        num_questions: int,
        difficulty: Optional[DifficultyLevel],
        cognitive_level: Optional[CognitiveLevel],
        learning_outcomes: Optional[List[str]]
    ) -> str:
        """Build prompt for assessment generation"""
        
        prompt = f"""Generate {num_questions} {assessment_type.value} questions based on the following chapter content:

{content[:3000]}  # Truncate to respect context window

Requirements:
- Assessment type: {assessment_type.value}
"""
        
        if difficulty:
            prompt += f"- Difficulty level: {difficulty.value}\n"
        
        if cognitive_level:
            prompt += f"- Cognitive level: {cognitive_level.value}\n"
        
        if learning_outcomes:
            prompt += f"- Learning outcomes to cover: {', '.join(learning_outcomes)}\n"
        
        if assessment_type == AssessmentType.MCQ:
            prompt += """
For each question:
- Provide the question text
- Provide 4 options (labeled A, B, C, D)
- Indicate the correct answer
- Explain why it's correct
"""
        elif assessment_type == AssessmentType.QA:
            prompt += """
For each question:
- Provide the question text
- Provide a comprehensive answer
- Include key points to cover
"""
        elif assessment_type == AssessmentType.ONE_NIGHTER:
            prompt += """
Create a concise summary/one-nighter covering:
- Key concepts
- Important formulas/definitions
- Quick revision points
- Common question types
"""
        
        prompt += "\nReturn the response in a structured JSON format."
        
        return prompt
    
    def _generate_with_openai(self, prompt: str, assessment_type: AssessmentType) -> List[Dict]:
        """Generate using OpenAI"""
        try:
            response = openai.chat.completions.create(
                model=self.model,
                messages=[
                    {"role": "system", "content": "You are an expert educational content generator. Always return valid JSON."},
                    {"role": "user", "content": prompt}
                ],
                max_tokens=self.max_tokens,
                temperature=0.7
            )
            
            content = response.choices[0].message.content
            # Parse JSON response (simplified - in production, use proper JSON parsing)
            return self._parse_llm_response(content, assessment_type)
        except Exception as e:
            print(f"Error generating with OpenAI: {e}")
            return []
    
    def _generate_with_anthropic(self, prompt: str, assessment_type: AssessmentType) -> List[Dict]:
        """Generate using Anthropic"""
        try:
            message = self.client.messages.create(
                model=self.model,
                max_tokens=self.max_tokens,
                messages=[
                    {"role": "user", "content": prompt}
                ]
            )
            
            content = message.content[0].text
            return self._parse_llm_response(content, assessment_type)
        except Exception as e:
            print(f"Error generating with Anthropic: {e}")
            return []
    
    def _parse_llm_response(self, content: str, assessment_type: AssessmentType) -> List[Dict]:
        """Parse LLM response into structured format"""
        # Simplified parsing - in production, implement robust JSON parsing
        # This is a placeholder that returns mock structure
        import json
        
        try:
            # Try to extract JSON from response
            if "```json" in content:
                json_start = content.find("```json") + 7
                json_end = content.find("```", json_start)
                content = content[json_start:json_end].strip()
            elif "```" in content:
                json_start = content.find("```") + 3
                json_end = content.find("```", json_start)
                content = content[json_start:json_end].strip()
            
            data = json.loads(content)
            if isinstance(data, list):
                return data
            elif isinstance(data, dict) and "questions" in data:
                return data["questions"]
            else:
                return []
        except Exception:
            # Fallback to empty list if parsing fails
            return []
    
    def generate_hint(self, question: str, answer: str) -> str:
        """Generate AI hint for a question"""
        prompt = f"""Generate a helpful hint (not the full answer) for this question:
        
Question: {question}
Answer: {answer}

Provide a hint that guides the student toward the answer without giving it away."""
        
        if self.provider == "openai":
            response = openai.chat.completions.create(
                model=self.model,
                messages=[{"role": "user", "content": prompt}],
                max_tokens=200,
                temperature=0.7
            )
            return response.choices[0].message.content
        elif self.provider == "anthropic":
            message = self.client.messages.create(
                model=self.model,
                max_tokens=200,
                messages=[{"role": "user", "content": prompt}]
            )
            return message.content[0].text
        
        return ""
    
    def generate_solution(self, question: str, answer: str) -> str:
        """Generate detailed solution explanation"""
        prompt = f"""Provide a detailed solution explanation for:
        
Question: {question}
Answer: {answer}

Explain the reasoning step by step."""
        
        if self.provider == "openai":
            response = openai.chat.completions.create(
                model=self.model,
                messages=[{"role": "user", "content": prompt}],
                max_tokens=500,
                temperature=0.7
            )
            return response.choices[0].message.content
        elif self.provider == "anthropic":
            message = self.client.messages.create(
                model=self.model,
                max_tokens=500,
                messages=[{"role": "user", "content": prompt}]
            )
            return message.content[0].text
        
        return ""
