"""
Service for checking originality (Modules B & C)
- Module B: Fuzzy Duplicate Detection (datasketch MinHash)
- Module C: Web Snippet Check (DuckDuckGo)
"""
from datasketch import MinHash, MinHashLSH
from duckduckgo_search import DDGS
import requests
from bs4 import BeautifulSoup
from typing import List, Dict, Optional
from .embedding_service import EmbeddingService

class OriginalityService:
    """Service to check for plagiarism and duplicates"""
    
    def __init__(self, embedding_service: EmbeddingService):
        self.embedding_service = embedding_service
        self.ddgs = DDGS()

    # --- Module B: Fuzzy Duplicate Detection ---
    
    def _create_minhash(self, text: str, num_perm: int = 128) -> MinHash:
        """Create a MinHash signature for a text."""
        minhash = MinHash(num_perm=num_perm)
        # Split text into shingles (e.g., 5-grams)
        shingles = set(text[i:i+5] for i in range(len(text) - 4))
        for s in shingles:
            minhash.update(s.encode('utf8'))
        return minhash

    def check_student_similarity(
        self,
        target_text: str,
        other_texts: List[str],
        threshold: float = 0.80
    ) -> List[Dict]:
        """
        Compare target_text against a list of other student texts
        using MinHash Jaccard similarity.
        """
        if not other_texts:
            return []
            
        target_minhash = self._create_minhash(target_text)
        similar_submissions = []
        
        for i, other_text in enumerate(other_texts):
            other_minhash = self._create_minhash(other_text)
            jaccard_similarity = target_minhash.jaccard(other_minhash)
            
            if jaccard_similarity >= threshold:
                similar_submissions.append({
                    "other_submission_index": i, # Or a real ID
                    "similarity_score": jaccard_similarity
                })
        
        return similar_submissions

    # --- Module C: Web Snippet Check ---

    def _fetch_web_content(self, url: str) -> str:
        """Fetch and parse text content from a URL."""
        try:
            response = requests.get(url, timeout=5, headers={'User-Agent': 'Mozilla/5.0'})
            if response.status_code == 200:
                soup = BeautifulSoup(response.text, 'html.parser')
                # Get all text from the body
                paragraphs = soup.find_all('p')
                return " ".join([p.get_text() for p in paragraphs])
            return ""
        except Exception:
            return ""

    def check_web_plagiarism(
        self,
        student_text: str,
        num_results: int = 3,
        similarity_threshold: float = 0.85
    ) -> List[Dict]:
        """
        Check for web plagiarism using DuckDuckGo and embedding similarity.
        """
        # Use a key snippet from the text to search
        snippet = student_text[:250]
        try:
            search_results = self.ddgs.text(snippet, max_results=num_results)
            if not search_results:
                return []
        except Exception:
            return [] # DDGS failed
            
        student_embedding = self.embedding_service.get_embedding(student_text)
        plagiarized_sources = []

        for result in search_results:
            web_content = self._fetch_web_content(result['href'])
            if not web_content:
                continue
                
            # Compare student answer to the *entire* web page text
            web_embedding = self.embedding_service.get_embedding(web_content)
            web_similarity = self.embedding_service.calculate_similarity(
                student_embedding, web_embedding
            )
            
            if web_similarity >= similarity_threshold:
                plagiarized_sources.append({
                    "source_url": result['href'],
                    "source_title": result['title'],
                    "similarity_score": web_similarity,
                    "web_snippet": result['body']
                })
        
        return plagiarized_sources