import os
from sentence_transformers import SentenceTransformer
from typing import List, Tuple, Dict, Any
import numpy as np
import torch  # <-- Added this import

# --- CONFIGURATION ---
MODEL_NAME = "BAAI/bge-m3"
DIMENSION = 1024
MODEL = None

def initialize_embedding_service():
    """Initializes the BGE-M3 model."""
    global MODEL
    
    if MODEL:
        return  # Already initialized

    print(f"Loading {MODEL_NAME} model...")
    
    # --- CHANGED ---
    # Use 'mps' if available (for Apple Silicon), else 'cpu'
    device = 'mps' if torch.backends.mps.is_available() else 'cpu'
    print(f"Using device: {device}")
    # --- END CHANGE ---
    
    MODEL = SentenceTransformer(MODEL_NAME, device=device)
    print("Embedding Service Initialized (BGE-M3 only).")

def get_embeddings(text_chunks: List[str]) -> List[List[float]]:
    """
    Generates BGE-M3 embeddings for a list of text chunks.
    """
    if not MODEL:
        raise Exception("Embedding service not initialized.")
        
    if not text_chunks:
        return []

    print(f"Generating {len(text_chunks)} embeddings...")
    embeddings_list = MODEL.encode(text_chunks, normalize_embeddings=True).tolist()
    return embeddings_list


# --- EmbeddingService Class for Grading Service ---

class EmbeddingService:
    """Service class for generating embeddings and calculating similarities (used by grading service)"""
    
    def __init__(self):
        """Initialize the embedding model if not already initialized"""
        global MODEL
        if MODEL is None:
            # Initialize the model
            print(f"Loading {MODEL_NAME} model for EmbeddingService...")

            # --- CHANGED ---
            # Use 'mps' if available (for Apple Silicon), else 'cpu'
            device = 'mps' if torch.backends.mps.is_available() else 'cpu'
            print(f"Using device: {device}")
            # --- END CHANGE ---
            
            MODEL = SentenceTransformer(MODEL_NAME, device=device)
        self.model = MODEL
    
    def get_embedding(self, text: str) -> np.ndarray:
        """
        Generate embedding for a single text string.
        Returns a numpy array.
        """
        if not text or not text.strip():
            raise ValueError("Text cannot be empty")
        
        # Generate embedding and normalize
        embedding = self.model.encode([text], normalize_embeddings=True)[0]
        return embedding
    
    def calculate_similarity(self, embedding1: np.ndarray, embedding2: np.ndarray) -> float:
        """
        Calculate cosine similarity between two embeddings.
        Since embeddings are normalized, this is just the dot product.
        Returns a float between -1 and 1 (typically 0 to 1 for normalized embeddings).
        """
        # Convert to 1D if needed
        emb1 = embedding1.flatten() if embedding1.ndim > 1 else embedding1
        emb2 = embedding2.flatten() if embedding2.ndim > 1 else embedding2
        
        # For normalized embeddings, dot product = cosine similarity (much faster)
        similarity = np.dot(emb1, emb2)
        return float(similarity)