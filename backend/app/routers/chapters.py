from fastapi import APIRouter, File, Form, UploadFile, HTTPException
from typing import Dict
import uuid
import os
import tempfile
import json

from app.services.content_extraction_service import ContentExtractionService
from app.services.llm_service import LLMService

router = APIRouter()

@router.post("/upload-and-process")
async def upload_and_process(
    file: UploadFile = File(...),
    num_mcqs: int = Form(...),
    num_unit_tests: int = Form(...)
):
    """
    Multi-agent content generation using CrewAI
    
    1. Extract text from PDF
    2. Use specialized agents to generate MCQs and unit tests
    3. Return structured JSON with generated content
    """
    
    # Validate file type
    if file.content_type != "application/pdf":
        raise HTTPException(
            status_code=400, 
            detail="Only PDF files are accepted. Please upload a PDF."
        )

    # --- Step 1: Extract text from PDF ---
    print(f"📄 Processing file: {file.filename}")
    
    try:
        pdf_bytes = await file.read()
        text = ContentExtractionService.extract_text(pdf_bytes)
        
        if not text or len(text.strip()) < 100:
            raise HTTPException(
                status_code=400, 
                detail="PDF appears to be empty or contains insufficient text. Please check the file."
            )
        
        print(f"✅ Extracted {len(text)} characters from PDF")
        
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(
            status_code=400, 
            detail=f"Failed to extract text from PDF: {str(e)}"
        )

    # --- Step 2: Initialize CrewAI LLM service ---
    print("🤖 Initializing AI agents...")
    
    try:
        llm_service = LLMService()
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Failed to initialize AI service: {str(e)}"
        )

    # --- Step 3: Generate content using specialized agents ---
    print(f"🎯 Generating {num_mcqs} MCQs and {num_unit_tests} unit tests...")
    
    try:
        # Use the multi-agent method for parallel generation
        payload = llm_service.generate_mcqs_and_unit_tests(
            chapter_content=text,
            num_mcqs=num_mcqs,
            num_unit_tests=num_unit_tests
        )
        
        # Validate response structure
        if "mcqs" not in payload or "unit_tests" not in payload:
            raise HTTPException(
                status_code=502, 
                detail="AI agents returned incomplete data. Please try again."
            )
        
        # Check if we got reasonable results (markdown strings)
        mcq_markdown = payload.get("mcqs", "")
        unit_test_markdown = payload.get("unit_tests", "")
        one_nighter_markdown = payload.get("one_nighter", "")
        actual_mcq_length = len(mcq_markdown)
        actual_unit_test_length = len(unit_test_markdown)
        actual_one_nighter_length = len(one_nighter_markdown)
        
        print(f"✅ Generated MCQ markdown ({actual_mcq_length} chars), Unit Test markdown ({actual_unit_test_length} chars), and One-Nighter ({actual_one_nighter_length} chars)")
        
        # Allow partial results - don't fail if we got at least some content
        if actual_mcq_length == 0 and actual_unit_test_length == 0 and actual_one_nighter_length == 0:
            print(f"⚠️  Warning: No content generated.")
            print(f"🔍 Debug: Payload keys: {list(payload.keys())}")
            raise HTTPException(
                status_code=502,
                detail=f"AI agents failed to generate content. Check terminal logs for errors."
            )
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"❌ Error during content generation: {str(e)}")
        raise HTTPException(
            status_code=502, 
            detail=f"AI generation failed: {str(e)}"
        )

    # --- Step 4: Save output files ---
    print("💾 Saving output files...")
    
    try:
        # Create outputs directory in project root if it doesn't exist
        project_root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
        outputs_dir = os.path.join(project_root, "outputs")
        os.makedirs(outputs_dir, exist_ok=True)
        
        uid = str(uuid.uuid4())
        
        mcq_path = os.path.join(outputs_dir, f"{uid}_mcqs.md")
        unit_path = os.path.join(outputs_dir, f"{uid}_unit_tests.md")
        one_nighter_path = os.path.join(outputs_dir, f"{uid}_one_nighter.md")
        
        # Save MCQs as markdown
        with open(mcq_path, "w", encoding="utf-8") as f:
            f.write(payload.get("mcqs", ""))
        
        # Save unit tests as markdown
        with open(unit_path, "w", encoding="utf-8") as f:
            f.write(payload.get("unit_tests", ""))
        
        # Save one-nighter summary as markdown
        with open(one_nighter_path, "w", encoding="utf-8") as f:
            f.write(payload.get("one_nighter", ""))
        
        print(f"✅ Saved files: {mcq_path}, {unit_path}, {one_nighter_path}")
        
    except Exception as e:
        print(f"⚠️  Warning: Failed to write output files: {e}")
        # Continue anyway - we have the data in memory
        mcq_path = "Failed to save (data available in response)"
        unit_path = "Failed to save (data available in response)"
        one_nighter_path = "Failed to save (data available in response)"

    # --- Step 5: Return comprehensive response ---
    return {
        "message": "✅ Content generated successfully using AI agents",
        "file_info": {
            "original_filename": file.filename,
            "text_length": len(text),
            "chunks_processed": len(text) // 8000 + 1
        },
        "summary": {
            "mcqs_length": len(payload.get("mcqs", "")),
            "unit_tests_length": len(payload.get("unit_tests", "")),
            "one_nighter_length": len(payload.get("one_nighter", "")),
            "mcqs_requested": num_mcqs,
            "unit_tests_requested": num_unit_tests
        },
        "outputs": {
            "mcqs": mcq_path,
            "unit_tests": unit_path,
            "one_nighter": one_nighter_path
        },
        "data": payload,
        "models_used": {
            "mcq_generation": "Specialized MCQ Agent",
            "unit_test_generation": "Specialized Unit Test Agent",
            "note": "Different AI models optimized for each task"
        }
    }


@router.get("/health")
async def health_check():
    """Check if the service is running and configured properly"""
    try:
        from app.config import settings
        
        return {
            "status": "healthy",
            "service": "chapters-api",
            "models_configured": {
                "mcq": settings.MCQ_MODEL,
                "unit_test": settings.UNIT_TEST_MODEL,
                "summary": settings.SUMMARY_MODEL,
                "hint": settings.HINT_MODEL
            },
            "api_key_present": bool(settings.OPENAI_API_KEY)
        }
    except Exception as e:
        return {
            "status": "unhealthy",
            "error": str(e)
        }