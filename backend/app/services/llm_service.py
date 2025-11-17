"""
CrewAI-based LLM service for multi-agent content generation
Each task gets its own specialized agent with the right model
"""
from typing import List, Dict, Optional
import json
import re
from crewai import Agent, Task, Crew, Process
from langchain_openai import ChatOpenAI
from langchain_anthropic import ChatAnthropic
from langchain_text_splitters import RecursiveCharacterTextSplitter

from app.config import settings
from app.models.assessment import AssessmentType, DifficultyLevel, CognitiveLevel


class LLMService:
    """Multi-agent service using CrewAI for specialized content generation"""
    
    def __init__(self):
        self.text_splitter = RecursiveCharacterTextSplitter(
            chunk_size=8000,
            chunk_overlap=400,
            length_function=len,
            is_separator_regex=False,
        )
        
        # Initialize different LLMs for different tasks
        self._init_llms()
    
    def _init_llms(self):
        """Initialize different LLM configurations for different agents"""
        
        # Get API key - use OPENAI_API_KEY if set, otherwise fall back to LLM_API_KEY
        api_key = settings.OPENAI_API_KEY or settings.LLM_API_KEY
        
        if not api_key:
            error_msg = (
                "OPENAI_API_KEY or LLM_API_KEY must be set.\n\n"
                "To fix this, create a .env file in your project root (or backend/) directory with:\n"
                "  OPENAI_API_KEY=your-openai-api-key-here\n\n"
                "Or set it as an environment variable:\n"
                "  export OPENAI_API_KEY=your-openai-api-key-here\n\n"
                "You can get your API key from: https://platform.openai.com/api-keys"
            )
            raise ValueError(error_msg)
        
        # MCQ Generator - needs creativity and accuracy
        # Note: No max_tokens limit - let the model generate as needed
        self.mcq_llm = ChatOpenAI(
            model=settings.MCQ_MODEL,
            temperature=0.7,
            openai_api_key=api_key,
            # No max_tokens - unlimited output
        )
        
        # Unit Test Generator - needs depth and reasoning
        self.unit_test_llm = ChatOpenAI(
            model=settings.UNIT_TEST_MODEL,
            temperature=0.6,
            openai_api_key=api_key,
            # No max_tokens - unlimited output
        )
        
        # One-Nighter/Summary Generator - needs conciseness
        self.summary_llm = ChatOpenAI(
            model=settings.SUMMARY_MODEL,
            temperature=0.5,
            openai_api_key=api_key,
            # No max_tokens - unlimited output
        )
        
        # Hint/Solution Generator - needs pedagogical skills
        self.hint_llm = ChatOpenAI(
            model=settings.HINT_MODEL,
            temperature=0.7,
            openai_api_key=api_key,
            # No max_tokens - unlimited output
        )
    
    def _chunk_content(self, chapter_content: str) -> List[str]:
        """Split chapter content into manageable chunks"""
        if not chapter_content:
            return []
        return self.text_splitter.split_text(chapter_content)
    
    def _create_mcq_agent(self) -> Agent:
        """Create specialized MCQ generation agent"""
        return Agent(
            role="MCQ Assessment Designer",
            goal="Create high-quality multiple-choice questions that test deep understanding",
            backstory="""You are an expert assessment designer with 20 years of experience 
            creating engaging multiple-choice questions. You understand Bloom's taxonomy and 
            create questions that test not just recall, but application and analysis.""",
            llm=self.mcq_llm,
            verbose=True,
            allow_delegation=False
        )
    
    def _create_unit_test_agent(self) -> Agent:
        """Create specialized unit test question agent"""
        return Agent(
            role="Unit Test Question Designer",
            goal="Create comprehensive short-answer questions that assess mastery",
            backstory="""You are a veteran educator who specializes in creating questions 
            that require students to demonstrate their understanding through written responses. 
            Your questions are clear, focused, and require thoughtful answers.""",
            llm=self.unit_test_llm,
            verbose=True,
            allow_delegation=False
        )
    
    def _create_summary_agent(self) -> Agent:
        """Create specialized summary/one-nighter agent"""
        return Agent(
            role="One-Nighter Summary Wizard",
            goal="Distil the chapter into a cram-ready, high-yield cheat sheet",
            backstory="You are the student's best friend the night before the exam. "
                      "You extract ONLY the formulas, key definitions, and likely exam hooks.",
            llm=self.summary_llm,
            verbose=True,
            allow_delegation=False
        )
    
    def _create_hint_agent(self) -> Agent:
        """Create specialized hint/solution agent"""
        return Agent(
            role="Tutoring Assistant",
            goal="Provide helpful hints and clear explanations that guide learning",
            backstory="""You are a patient tutor who knows how to give just the right 
            amount of help. Your hints guide students without giving away answers, and 
            your explanations break down complex problems into understandable steps.""",
            llm=self.hint_llm,
            verbose=True,
            allow_delegation=False
        )
    
    def generate_mcqs_and_unit_tests(
        self,
        chapter_content: str,
        num_mcqs: int = 10,
        num_unit_tests: int = 5
    ) -> Dict:
        """
        Generate both MCQs and unit tests using multi-agent approach
        """
        
        # Chunk content if needed
        chunks = self._chunk_content(chapter_content)
        if not chunks:
            print("Warning: Chapter content is empty.")
            return {"mcqs": [], "unit_tests": []}
        
        # Use first chunk or combine if small enough
        content_to_use = chunks[0] if len(chunks) == 1 else "\n\n".join(chunks[:2])
        
        # Create specialized agents
        mcq_agent = self._create_mcq_agent()
        unit_test_agent = self._create_unit_test_agent()
        
        # Create MCQ generation task
        mcq_task = Task(
            description=f"""
            Based on the following educational content, generate {num_mcqs} high-quality 
            multiple-choice questions.
            
            Content:
            {content_to_use}
            
            Requirements:
            - Each question should have exactly 4 options (A, B, C, D)
            - Options should be plausible and test understanding
            - Include brief explanations for correct answers
            - Cover different topics from the content
            - Vary difficulty levels
            
            Return the questions in MARKDOWN format (not JSON) as follows:
            
            # Multiple Choice Questions
            
            ## Question 1
            [Question text here]
            
            A. Option 1
            B. Option 2
            C. Option 3
            D. Option 4
            
            **Answer:** A
            **Explanation:** [Brief explanation of why A is correct]
            
            ## Question 2
            [Continue with same format...]
            """,
            agent=mcq_agent,
            expected_output="Markdown formatted multiple choice questions"
        )
        
        # Create unit test generation task
        unit_test_task = Task(
            description=f"""
            Based on the following educational content, generate {num_unit_tests} 
            short-answer unit test questions.
            
            Content:
            {content_to_use}
            
            Requirements:
            - Questions should require 2-4 sentence answers
            - Test deeper understanding and application
            - Include comprehensive model answers
            - Provide key points that should be covered
            
            Return the questions in MARKDOWN format (not JSON) as follows:
            
            # Unit Test Questions
            
            ## Question 1
            [Question text here]
            
            **Model Answer:**
            [Comprehensive answer here]
            
            **Key Points:**
            - Key point 1
            - Key point 2
            - Key point 3
            
            ## Question 2
            [Continue with same format...]
            """,
            agent=unit_test_agent,
            expected_output="Markdown formatted unit test questions"
        )
        
        # Create summary agent and task
        summary_agent = self._create_summary_agent()
        
        summary_task = Task(
            description=f"""
            Create a **one-nighter** summary from the content below.
            Create a ONE-PAGE "one-nighter" cheat sheet from the text below and use bullet points, tables, or bold terms
            so it can be skimmed in 5-10 minutes. Make it to around 500-600 words.
            
            Content:
            {content_to_use}
            
            Return ONLY markdown format (not JSON). Start with:
            # One-Nighter Summary
            
            Then include:
            - Bullet points or very short sentences only
            - Formulas in `code` blocks
            - Bold the terms that might be asked in an exam
            - Maximum 500 words
            - NO introduction, NO conclusion, NO meta-commentary
            - Key formulas and equations
            - Important definitions
            - Critical concepts
            - Exam-ready highlights
            - Quick reference points
            
            Make it concise and scannable.
            """,
            agent=summary_agent,
            expected_output="Markdown cheat-sheet"
        )
        
        # Create and run crew with all three agents
        crew = Crew(
            agents=[mcq_agent, unit_test_agent, summary_agent],
            tasks=[mcq_task, unit_test_task, summary_task],
            process=Process.sequential,
            verbose=True
        )
        
        try:
            result = crew.kickoff()
            
            # Debug: Print raw outputs
            print(f"\n🔍 Debug: MCQ Task Output Length: {len(mcq_task.output.raw)}")
            print(f"🔍 Debug: Unit Test Task Output Length: {len(unit_test_task.output.raw)}")
            print(f"🔍 Debug: Summary Task Output Length: {len(summary_task.output.raw)}")
            
            # Get markdown outputs directly (no JSON parsing needed)
            mcq_markdown = mcq_task.output.raw if mcq_task.output.raw else ""
            unit_test_markdown = unit_test_task.output.raw if unit_test_task.output.raw else ""
            one_nighter_markdown = summary_task.output.raw if summary_task.output.raw else ""
            
            print(f"✅ Generated MCQ markdown ({len(mcq_markdown)} chars), Unit Test markdown ({len(unit_test_markdown)} chars), and One-Nighter ({len(one_nighter_markdown)} chars)")
            
            return {
                "mcqs": mcq_markdown,
                "unit_tests": unit_test_markdown,
                "one_nighter": one_nighter_markdown
            }
            
        except Exception as e:
            print(f"❌ Error in crew execution: {e}")
            import traceback
            traceback.print_exc()
            return {"mcqs": "", "unit_tests": "", "one_nighter": ""}
    
    def generate_assessment(
        self,
        chapter_content: str,
        assessment_type: AssessmentType,
        num_questions: int = 10,
        difficulty: Optional[DifficultyLevel] = None,
        cognitive_level: Optional[CognitiveLevel] = None,
        learning_outcomes: Optional[List[str]] = None
    ) -> List[Dict]:
        """
        Generate assessment items using specialized agents
        """
        
        chunks = self._chunk_content(chapter_content)
        if not chunks:
            return []
        
        content_to_use = chunks[0] if len(chunks) == 1 else "\n\n".join(chunks[:2])
        
        # Select appropriate agent and create task
        if assessment_type == AssessmentType.MCQ:
            agent = self._create_mcq_agent()
            prompt = self._build_mcq_prompt(content_to_use, num_questions, difficulty, cognitive_level)
        elif assessment_type == AssessmentType.QA:
            agent = self._create_unit_test_agent()
            prompt = self._build_qa_prompt(content_to_use, num_questions, difficulty)
        elif assessment_type == AssessmentType.ONE_NIGHTER:
            agent = self._create_summary_agent()
            prompt = self._build_summary_prompt(content_to_use)
        else:
            raise ValueError(f"Unsupported assessment type: {assessment_type}")
        
        task = Task(
            description=prompt,
            agent=agent,
            expected_output="JSON formatted assessment content"
        )
        
        crew = Crew(
            agents=[agent],
            tasks=[task],
            process=Process.sequential,
            verbose=True
        )
        
        try:
            result = crew.kickoff()
            parsed_output = self._parse_json_from_text(task.output.raw)
            
            if "items" in parsed_output:
                return parsed_output["items"]
            elif isinstance(parsed_output, list):
                return parsed_output
            elif isinstance(parsed_output, dict):
                return [parsed_output]
            else:
                return []
                
        except Exception as e:
            print(f"Error generating assessment: {e}")
            return []
    
    def generate_simple_content(self, prompt: str) -> Dict:
        """
        Simple content generation for custom prompts
        Uses the most general agent
        """
        agent = Agent(
            role="Educational Content Generator",
            goal="Generate educational content based on provided instructions",
            backstory="You are an experienced educator who creates clear, accurate educational materials.",
            llm=self.mcq_llm,  # Use MCQ model as default
            verbose=True,
            allow_delegation=False
        )
        
        task = Task(
            description=prompt,
            agent=agent,
            expected_output="JSON formatted content"
        )
        
        crew = Crew(
            agents=[agent],
            tasks=[task],
            process=Process.sequential,
            verbose=True
        )
        
        try:
            result = crew.kickoff()
            return self._parse_json_from_text(task.output.raw)
        except Exception as e:
            print(f"Error generating content: {e}")
            raise
    
    def generate_hint(self, question: str, answer: str) -> str:
        """Generate hint using specialized hint agent"""
        agent = self._create_hint_agent()
        
        task = Task(
            description=f"""
            Generate a helpful hint for this question WITHOUT giving away the answer:
            
            Question: {question}
            Answer: {answer}
            
            The hint should:
            - Guide the student's thinking
            - Not reveal the answer directly
            - Be encouraging and constructive
            
            Return just the hint text (no JSON needed).
            """,
            agent=agent,
            expected_output="Hint text"
        )
        
        crew = Crew(
            agents=[agent],
            tasks=[task],
            process=Process.sequential,
            verbose=False
        )
        
        try:
            result = crew.kickoff()
            return task.output.raw
        except Exception as e:
            print(f"Error generating hint: {e}")
            return ""
    
    def generate_solution(self, question: str, answer: str) -> str:
        """Generate detailed solution using hint agent"""
        agent = self._create_hint_agent()
        
        task = Task(
            description=f"""
            Provide a detailed step-by-step solution for:
            
            Question: {question}
            Answer: {answer}
            
            Explain the reasoning clearly and break it down into steps.
            Return just the solution explanation (no JSON needed).
            """,
            agent=agent,
            expected_output="Solution explanation"
        )
        
        crew = Crew(
            agents=[agent],
            tasks=[task],
            process=Process.sequential,
            verbose=False
        )
        
        try:
            result = crew.kickoff()
            return task.output.raw
        except Exception as e:
            print(f"Error generating solution: {e}")
            return ""
    
    # Helper methods for building prompts
    
    def _build_mcq_prompt(self, content: str, num: int, difficulty, cognitive_level) -> str:
        return f"""
        Generate {num} multiple-choice questions from this content:
        
        {content}
        
        {f'Difficulty: {difficulty.value}' if difficulty else ''}
        {f'Cognitive Level: {cognitive_level.value}' if cognitive_level else ''}
        
        Return JSON: {{"items": [{{"question": "...", "options": [...], "answer": "A", "explanation": "..."}}]}}
        """
    
    def _build_qa_prompt(self, content: str, num: int, difficulty) -> str:
        return f"""
        Generate {num} short-answer questions from this content:
        
        {content}
        
        {f'Difficulty: {difficulty.value}' if difficulty else ''}
        
        Return JSON: {{"items": [{{"question": "...", "answer": "...", "key_points": [...]}}]}}
        """
    
    def _build_summary_prompt(self, content: str) -> str:
        return f"""
        Create a study guide from this content:
        
        {content}
        
        Return JSON: {{"key_concepts": [...], "formulas_definitions": [...], "revision_points": [...]}}
        """
    
    def _parse_json_from_text(self, text: str) -> Dict:
        """Extract and parse JSON from text that might contain extra content"""
        if not text:
            print("⚠️  Warning: Empty text provided to parser")
            return {}
        
        # Try multiple JSON extraction strategies
        # Strategy 1: Direct parse
        try:
            return json.loads(text)
        except json.JSONDecodeError:
            pass
        
        # Strategy 2: Find JSON between ```json and ```
        json_code_block = re.search(r'```json\s*(\{.*?\}|\[.*?\])\s*```', text, re.DOTALL)
        if json_code_block:
            try:
                return json.loads(json_code_block.group(1))
            except json.JSONDecodeError:
                pass
        
        # Strategy 3: Find JSON between ``` and ```
        code_block = re.search(r'```\s*(\{.*?\}|\[.*?\])\s*```', text, re.DOTALL)
        if code_block:
            try:
                return json.loads(code_block.group(1))
            except json.JSONDecodeError:
                pass
        
        # Strategy 4: Find first complete JSON object (handles nested structures)
        # Count braces to find complete JSON objects
        brace_count = 0
        start_idx = text.find('{')
        if start_idx != -1:
            for i in range(start_idx, len(text)):
                if text[i] == '{':
                    brace_count += 1
                elif text[i] == '}':
                    brace_count -= 1
                    if brace_count == 0:
                        try:
                            return json.loads(text[start_idx:i+1])
                        except json.JSONDecodeError:
                            break
        
        # Strategy 5: Find first complete JSON array
        bracket_count = 0
        start_idx = text.find('[')
        if start_idx != -1:
            for i in range(start_idx, len(text)):
                if text[i] == '[':
                    bracket_count += 1
                elif text[i] == ']':
                    bracket_count -= 1
                    if bracket_count == 0:
                        try:
                            return json.loads(text[start_idx:i+1])
                        except json.JSONDecodeError:
                            break
        
        # If all strategies fail, print debug info
        print(f"❌ Failed to parse JSON from text")
        print(f"📝 Text preview (first 1000 chars): {text[:1000]}")
        print(f"📝 Text preview (last 500 chars): {text[-500:] if len(text) > 500 else text}")
        
        # Try to extract any structured data manually
        try:
            # Look for common patterns
            if '"mcqs"' in text.lower() or '"questions"' in text.lower():
                # Try to find the array after "mcqs" or "questions"
                mcq_match = re.search(r'"(?:mcqs|questions)"\s*:\s*(\[.*?\])', text, re.DOTALL | re.IGNORECASE)
                if mcq_match:
                    return {"mcqs": json.loads(mcq_match.group(1))}
            
            if '"unit_tests"' in text.lower() or '"unit_tests"' in text.lower():
                ut_match = re.search(r'"(?:unit_tests|unit tests)"\s*:\s*(\[.*?\])', text, re.DOTALL | re.IGNORECASE)
                if ut_match:
                    return {"unit_tests": json.loads(ut_match.group(1))}
        except Exception as e:
            print(f"⚠️  Manual extraction also failed: {e}")
        
        return {}