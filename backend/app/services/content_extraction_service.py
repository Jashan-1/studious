import fitz  # PyMuPDF
from typing import List

class ContentExtractionService:
    """
    Stateless service that turns an in-memory PDF into plain text.
    """

    @staticmethod
    def extract_text(file_bytes: bytes) -> str:
        """
        file_bytes: raw PDF bytes (e.g. file.read() from UploadFile)
        returns:  plain-text string of the whole document
        """
        doc = fitz.open(stream=file_bytes, filetype="pdf")
        text = ""
        for page in doc:
            text += page.get_text()
        doc.close()
        return text.strip()