"""
Content extraction service for PDF/EPUB processing
"""
from typing import Optional
import PyPDF2
import epub
import io

from app.services.google_drive_service import GoogleDriveService


class ContentExtractionService:
    """Service for extracting text content from uploaded files"""
    
    def __init__(self, drive_service: GoogleDriveService):
        self.drive_service = drive_service
    
    def extract_text_from_file(
        self,
        file_path: Optional[str] = None,
        file_content: Optional[bytes] = None,
        file_extension: str = ".pdf"
    ) -> Optional[str]:
        """Extract text content from uploaded file"""
        
        if file_extension == ".pdf":
            return self._extract_from_pdf(file_path, file_content)
        elif file_extension == ".epub":
            return self._extract_from_epub(file_path, file_content)
        else:
            raise ValueError(f"Unsupported file format: {file_extension}")
    
    def _extract_from_pdf(
        self,
        file_path: Optional[str] = None,
        file_content: Optional[bytes] = None
    ) -> Optional[str]:
        """Extract text from PDF"""
        try:
            if file_content:
                pdf_file = io.BytesIO(file_content)
                pdf_reader = PyPDF2.PdfReader(pdf_file)
            elif file_path:
                with open(file_path, 'rb') as file:
                    pdf_reader = PyPDF2.PdfReader(file)
            else:
                return None
            
            text = ""
            for page_num, page in enumerate(pdf_reader.pages):
                text += f"\n--- Page {page_num + 1} ---\n"
                text += page.extract_text()
            
            return text.strip()
        except Exception as e:
            print(f"Error extracting text from PDF: {e}")
            return None
    
    def _extract_from_epub(
        self,
        file_path: Optional[str] = None,
        file_content: Optional[bytes] = None
    ) -> Optional[str]:
        """Extract text from EPUB"""
        try:
            if file_content:
                book = epub.read_epub(io.BytesIO(file_content))
            elif file_path:
                book = epub.read_epub(file_path)
            else:
                return None
            
            text = ""
            for item in book.get_items():
                if item.get_type() == epub.ITEM_DOCUMENT:
                    text += item.get_content().decode('utf-8')
            
            return text.strip()
        except Exception as e:
            print(f"Error extracting text from EPUB: {e}")
            return None
    
    def extract_from_drive_file(self, file_id: str, file_extension: str) -> Optional[str]:
        """Extract text from a Google Drive file"""
        file_content = self.drive_service.download_file(file_id)
        if file_content:
            return self.extract_text_from_file(
                file_content=file_content,
                file_extension=file_extension
            )
        return None
    
    def identify_chapter_structure(self, text: str) -> dict:
        """Identify chapter structure from extracted text"""
        # Simplified chapter detection - in production, use more sophisticated NLP
        lines = text.split('\n')
        chapters = []
        current_chapter = None
        
        for i, line in enumerate(lines):
            # Detect chapter headers (simplified pattern matching)
            if any(keyword in line.lower() for keyword in ['chapter', 'unit', 'lesson']):
                if current_chapter:
                    chapters.append(current_chapter)
                current_chapter = {
                    'title': line.strip(),
                    'start_line': i,
                    'content': ''
                }
            elif current_chapter:
                current_chapter['content'] += line + '\n'
        
        if current_chapter:
            chapters.append(current_chapter)
        
        return {
            'total_chapters': len(chapters),
            'chapters': chapters
        }
