"""
Configuration management for Scopes API
"""
from pydantic_settings import BaseSettings
from typing import List


class Settings(BaseSettings):
    """Application settings"""
    
    # App settings
    APP_NAME: str = "Scopes API"
    DEBUG: bool = False
    CORS_ORIGINS: List[str] = ["*"]
    
    # Database
    DATABASE_URL: str = "sqlite:///./scopes.db"
    
    # Google Drive
    GOOGLE_DRIVE_CREDENTIALS_PATH: str = "./credentials.json"
    GOOGLE_DRIVE_FOLDER_ID: str = ""
    
    # LLM Settings
    LLM_PROVIDER: str = "openai"  # or "anthropic", etc.
    LLM_API_KEY: str = ""
    LLM_MODEL: str = "gpt-4o-mini"
    LLM_MAX_TOKENS: int = 4096
    
    # Security
    SECRET_KEY: str = "your-secret-key-change-in-production"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    
    # Assessment Settings
    DEFAULT_DIFFICULTY_LEVELS: List[str] = ["easy", "medium", "hard"]
    DEFAULT_COGNITIVE_LEVELS: List[str] = ["remember", "understand", "apply", "analyze", "evaluate", "create"]
    
    # File Upload
    MAX_UPLOAD_SIZE: int = 50 * 1024 * 1024  # 50MB
    ALLOWED_EXTENSIONS: List[str] = [".pdf", ".epub"]
    
    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()
