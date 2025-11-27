import os
import pinecone
from sentence_transformers import SentenceTransformer
from typing import List, Dict

# --- CONFIGURATION ---
PINECONE_INDEX_NAME = "studious"
MODEL_NAME = "BAAI/bge-m3" 
MODEL = None
PINECONE_INDEX = None

def initialize_search_service():
    """Initializes the BGE-M3 model and Pinecone client for search."""
    global MODEL, PINECONE_INDEX
    
    if MODEL and PINECONE_INDEX:
        return # Already initialized

    print("Initializing Search Service...")
    pinecone.init(api_key=os.environ.get('PINECONE_API_KEY'), environment=os.environ.get('PINECONE_ENVIRONMENT'))
    PINECONE_INDEX = pinecone.Index(PINECONE_INDEX_NAME)
    
    device = 'cuda' if os.environ.get('CUDA_VISIBLE_DEVICES') else 'cpu'
    MODEL = SentenceTransformer(MODEL_NAME, device=device)
    print("Search Service Initialized.")

def query_secure_embeddings(
    query_text: str, 
    current_org_id: str, # The authenticated user's organization UUID
    top_k_global: int = 3,
    top_k_private: int = 3
) -> List[Dict]:
    """
    Queries both global (NCERT) and private (tenant) namespaces,
    respecting RLS.
    """
    if not MODEL or not PINECONE_INDEX:
        raise Exception("Search service not initialized.")

    # 1. Generate Query Embedding
    query_vector = MODEL.encode(query_text, normalize_embeddings=True).tolist()

    # --- 2. Query 1: Global NCERT Content ---
    # Everyone can access this. No filter needed.
    try:
        global_results = PINECONE_INDEX.query(
            vector=query_vector,
            top_k=top_k_global,
            namespace='ncert-global',
            include_metadata=True
        )
    except Exception as e:
        print(f"Error querying ncert-global: {e}")
        global_results = {'matches': []}

    # --- 3. Query 2: Private Tenant Content ---
    # RLS is enforced here with a metadata filter.
    try:
        private_filter = {'org_id': {'$eq': current_org_id}}
        
        private_results = PINECONE_INDEX.query(
            vector=query_vector,
            top_k=top_k_private,
            namespace='tenant-private',
            filter=private_filter, # <-- RLS FILTER
            include_metadata=True
        )
    except Exception as e:
        print(f"Error querying tenant-private: {e}")
        private_results = {'matches': []}

    # --- 4. Combine and Format Results ---
    combined_context = []
    
    def format_match(match, source_ns):
        return {
            'score': match['score'],
            'source_namespace': source_ns,
            'metadata': match.get('metadata', {})
        }

    for match in global_results.get('matches', []):
        combined_context.append(format_match(match, 'ncert-global'))
        
    for match in private_results.get('matches', []):
        combined_context.append(format_match(match, 'tenant-private'))

    # Re-sort the combined list by score (highest first)
    combined_context.sort(key=lambda x: x['score'], reverse=True)
    
    # Your RAG (Retrieval-Augmented Generation) logic would then
    # take this context and send it to an LLM (Gemini, OpenAI)
    
    return combined_context

# --- Example Usage (How your API endpoint would use it) ---
# initialize_search_service()
# query_text = "What is the Euclidean Division Lemma?"
# org_id = "org-uuid-springfield"
# context = query_secure_embeddings(query_text, org_id)
# print(context)