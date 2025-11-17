"""
Service for VLM (Vision Language Model) text extraction
using Google Gemini.
"""
import google.generativeai as genai
# from pdf2image import convert_from_path # No longer needed
# from PIL import Image # No longer needed
from pathlib import Path
import io
import os
from typing import List, Union

# Configure the API key (ideally from settings)
# Make sure to set GOOGLE_API_KEY in your .env file
genai.configure(api_key=os.environ["GOOGLE_API_KEY"])

# Create the output directory if it doesn't exist
OUTPUTS_DIR = Path("grading_outputs")
OUTPUTS_DIR.mkdir(exist_ok=True)

class VisionService:
    """Service to extract text from images and PDFs using Google Gemini"""

    def __init__(self):
        self.model = genai.GenerativeModel('gemini-1.5-flash')

    def _save_extracted_text(self, submission_id: int, item_id: int, text: str) -> Path:
        """Saves extracted text to the 'grading_outputs' folder."""
        filename = f"submission_{submission_id}_item_{item_id}.txt"
        filepath = OUTPUTS_DIR / filename
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(text)
        return filepath

    def extract_text_from_file(
        self,
        file_path: Union[str, Path],
        submission_id: int,
        item_id: int,
        mime_type: str
    ) -> str:
        """
        Extracts text from an image or PDF file by passing raw bytes.
        """
        try:
            # Read file bytes directly
            with open(file_path, 'rb') as f:
                file_bytes = f.read()

            # Create the Part object for the API
            file_part = {
                "mime_type": mime_type,
                "data": file_bytes
            }

            if mime_type.startswith("image/"):
                prompt = "Extract all text from this image. This is a student's answer."
            elif mime_type == "application/pdf":
                prompt = "Extract all text from this PDF document. This is a student's answer."
            else:
                return "[Error: Unsupported file type]"

            response = self.model.generate_content([prompt, file_part])
            extracted_text = response.text

            # Save the extracted text to the "grading_outputs" folder
            self._save_extracted_text(submission_id, item_id, extracted_text)
            
            return extracted_text

        except Exception as e:
            print(f"Error during text extraction: {e}")
            # Save error message to output file
            self._save_extracted_text(submission_id, item_id, f"[Error: {e}]")
            return f"[Error processing file: {e}]"