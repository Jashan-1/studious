import os
import pinecone
from sentence_transformers import SentenceTransformer
from typing import List, Tuple, Dict, Any
import uuid
import numpy as np

# --- CONFIGURATION ---
PINECONE_INDEX_NAME = "studious"
MODEL_NAME = "BAAI/bge-m3" 
DIMENSION = 1024 

MODEL = None
PINECONE_INDEX = None

def initialize_embedding_service():
    """Initializes the BGE-M3 model and Pinecone client."""
    global MODEL, PINECONE_INDEX
    
    if MODEL and PINECONE_INDEX:
        return # Already initialized

    print("Initializing Embedding Service...")
    pinecone.init(
        api_key=os.environ.get('PINECONE_API_KEY'),
        environment=os.environ.get('PINECONE_ENVIRONMENT')
    )
    if PINECONE_INDEX_NAME not in pinecone.list_indexes():
        raise ValueError(f"Pinecone index '{PINECONE_INDEX_NAME}' does not exist.")
    
    PINECONE_INDEX = pinecone.Index(PINECONE_INDEX_NAME)
    
    print(f"Loading {MODEL_NAME} model...")
    device = 'cuda' if os.environ.get('CUDA_VISIBLE_DEVICES') else 'cpu'
    MODEL = SentenceTransformer(MODEL_NAME, device=device)
    print("Embedding Service Initialized.")


def generate_and_upsert_embeddings(
    item_id: uuid.UUID, 
    text_chunks: List[str],
    base_metadata: Dict[str, Any], # e.g., {'org_id': '...', 'source': '...'}
    namespace: str, # e.g., 'ncert-global' or 'tenant-private'
    log_key: str # 'chapter_id' or 'upload_id'
) -> List[Dict[str, Any]]:
    """
    Generates BGE-M3 embeddings and upserts them to the specified Pinecone namespace.
    Returns a list of dicts to be logged in the public.embeddings table.
    """
    if not MODEL or not PINECONE_INDEX:
        raise Exception("Embedding service not initialized.")

    print(f"Generating {len(text_chunks)} embeddings for {log_key} {item_id} in namespace '{namespace}'...")
    
    # --- 1. Generate Embeddings ---
    embeddings_list = MODEL.encode(text_chunks, normalize_embeddings=True).tolist()
    
    upsert_data = []
    metadata_log = [] # For public.embeddings

    # --- 2. Prepare Data ---
    for i, (chunk, vector) in enumerate(zip(text_chunks, embeddings_list)):
        
        # Unique Pinecone ID
        pinecone_vector_id = f"{log_key}-{item_id}-chunk-{i}"
        
        # Build the final metadata for Pinecone
        pinecone_metadata = base_metadata.copy()
        pinecone_metadata.update({
            'chunk_index': i,
            'text_snippet': chunk[:250] # Store a snippet for context
        })
        
        upsert_data.append((
            pinecone_vector_id, 
            vector,
            pinecone_metadata
        ))
        
        # Build the log for the public.embeddings SQL table
        db_row = {
            'pinecone_id': pinecone_vector_id,
            'vector_dimension': DIMENSION,
            'chunk_index': i,
            log_key: item_id # Dynamically sets 'chapter_id' or 'upload_id'
        }
        metadata_log.append(db_row)

    # --- 3. Upsert to Pinecone ---
    try:
        # Upsert in batches (Pinecone has a limit, e.g., 100 per request)
        batch_size = 100
        for i in range(0, len(upsert_data), batch_size):
            batch = upsert_data[i:i + batch_size]
            PINECONE_INDEX.upsert(vectors=batch, namespace=namespace)
            
        print(f"Successfully upserted {len(upsert_data)} vectors to namespace '{namespace}'.")
        return metadata_log

    except Exception as e:
        print(f"Error during Pinecone upsert to {namespace}: {e}")
        raise e


# --- EmbeddingService Class for Grading Service ---

class EmbeddingService:
    """Service class for generating embeddings and calculating similarities (used by grading service)"""
    
    def __init__(self):
        """Initialize the embedding model if not already initialized"""
        global MODEL
        if MODEL is None:
            # Initialize the model
            print(f"Loading {MODEL_NAME} model for EmbeddingService...")
            device = 'cuda' if os.environ.get('CUDA_VISIBLE_DEVICES') else 'cpu'
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