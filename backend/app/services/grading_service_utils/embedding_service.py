"""
Service for creating and comparing text embeddings.
(Module A)
"""
from sentence_transformers import SentenceTransformer, util
import numpy as np
from typing import List

class EmbeddingService:
    """Service for embedding generation and comparison"""
    
    def __init__(self, model_name: str = 'BAAI/bge-base-en-v1.5'):
        # Load the model. This will download it on first run.
        self.model = SentenceTransformer(model_name)
        print(f"Embedding model '{model_name}' loaded.")

    def get_embedding(self, text: str) -> np.ndarray:
        """Generate an embedding for a single piece of text."""
        # The 'query' prefix is recommended for BGE models when
        # generating a query vector to compare against a corpus.
        # For general similarity, we can omit it or use a neutral prefix.
        # Here we'll just encode directly.
        return self.model.encode(text, convert_to_numpy=True)
    
    def get_embeddings(self, texts: List[str]) -> np.ndarray:
        """Generate embeddings for a list of texts in batch."""
        return self.model.encode(texts, convert_to_numpy=True)
    
    def calculate_similarity(
        self,
        embedding1: np.ndarray,
        embedding2: np.ndarray
    ) -> float:
        """Calculate cosine similarity between two embeddings."""
        # util.cos_sim returns a 2D tensor/array, so we extract the single value
        similarity_matrix = util.cos_sim(embedding1, embedding2)
        return float(similarity_matrix[0][0])