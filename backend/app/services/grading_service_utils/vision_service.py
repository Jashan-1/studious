"""
Service for VLM (Vision Language Model) text extraction
using Google Gemini.
"""
import google.generativeai as genai
from pdf2image import convert_from_path
from PIL import Image
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
        self.model = genai.GenerativeModel('gemini-pro-vision')

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
        Extracts text from an image or PDF file and saves it to a file.
        
        :param file_path: Path to the uploaded file (image or PDF)
        :param submission_id: ID of the submission for naming the output
        :param item_id: ID of the assessment item for naming the output
        :param mime_type: Mime type of the file (e.g., 'image/png', 'application/pdf')
        :return: Extracted text
        """
        try:
            if mime_type.startswith("image/"):
                img = Image.open(file_path)
                prompt = "Extract all text from this image. This is a student's answer."
                response = self.model.generate_content([prompt, img])
                extracted_text = response.text
                
            elif mime_type == "application/pdf":
                # Convert PDF pages to images
                images = convert_from_path(file_path)
                extracted_texts = []
                
                for i, page_img in enumerate(images):
                    # Convert PIL image to bytes for the API
                    img_byte_arr = io.BytesIO()
                    page_img.save(img_byte_arr, format='PNG')
                    img_byte_arr = img_byte_arr.getvalue()
                    
                    img_part = {"mime_type": "image/png", "data": img_byte_arr}
                    prompt = f"Extract text from this document page ({i+1}/{len(images)}). This is a student's answer."
                    
                    response = self.model.generate_content([prompt, img_part])
                    extracted_texts.append(response.text)
                
                extracted_text = "\n\n--- Page Break ---\n\n".join(extracted_texts)
                
            else:
                return "[Error: Unsupported file type]"

            # Save the extracted text to the "grading_outputs" folder
            self._save_extracted_text(submission_id, item_id, extracted_text)
            
            return extracted_text

        except Exception as e:
            print(f"Error during text extraction: {e}")
            # Save error message to output file
            self._save_extracted_text(submission_id, item_id, f"[Error: {e}]")
            return f"[Error processing file: {e}]"