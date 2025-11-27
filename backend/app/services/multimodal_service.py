# Create a new file: multimodal_service.py

import torch
from PIL import Image
from transformers import AutoModel, AutoTokenizer
from io import BytesIO

MODEL = None
TOKENIZER = None

def initialize_multimodal_service():
    """Initializes the MiniCPM-V 4.5 model."""
    global MODEL, TOKENIZER
    if MODEL:
        return

    print("Loading MiniCPM-V 4.5 model...")
    model_path = 'openbmb/MiniCPM-Llama3-V-2_5'
    TOKENIZER = AutoTokenizer.from_pretrained(model_path, trust_remote_code=True)
    MODEL = AutoModel.from_pretrained(
        model_path,
        torch_dtype=torch.float16,
        device_map='auto',
        trust_remote_code=True
    )
    print("Multimodal Service Initialized (MiniCPM-V).")

def get_description_for_image_bytes(image_bytes: bytes) -> str:
    """
    Generates a text description for an image using MiniCPM-V.
    """
    if not MODEL:
        raise Exception("Multimodal service not initialized.")
    
    try:
        image = Image.open(BytesIO(image_bytes)).convert('RGB')
        
        # This is a specific prompt for MiniCPM-V
        # We ask it to be descriptive for RAG
        prompt = (
            "Describe this image in detail. "
            "If it is a diagram or figure, explain what it shows. "
            "If it is a table, transcribe its content in a structured way."
        )
        
        msgs = [{'role': 'user', 'content': prompt}]
        
        # Model-specific call
        res = MODEL.chat(
            image=image,
            msgs=msgs,
            tokenizer=TOKENIZER,
            sampling=True, 
            temperature=0.7,
            system_prompt="You are a helpful assistant."
        )
        
        return res
    except Exception as e:
        print(f"Error generating image description: {e}")
        return "[Error: Could not describe image]"