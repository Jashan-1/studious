"""
Configuration management for Scopes API
"""
from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import model_validator
from typing import List
import os
from pathlib import Path


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
    # Note: Settings are loaded from .env file OR environment variables
    # Priority: Environment variables > .env file > defaults
    # Create a .env file in the project root (or backend/) with:
    #   OPENAI_API_KEY=your-key-here
    #   MCQ_MODEL=gpt-4o-mini
    #   etc.
    LLM_PROVIDER: str = "openai"  # or "anthropic", etc.
    LLM_API_KEY: str = ""  # Set in .env file or environment variable
    LLM_MODEL: str = "gpt-4o-mini"  # Default model (can be overridden in .env)
    # Note: No max_tokens limit - models generate as needed
    
    # OpenAI API Key (alias for LLM_API_KEY for backward compatibility)
    OPENAI_API_KEY: str = ""
    
    # Model-specific settings for different tasks
    MCQ_MODEL: str = "gpt-4o-mini"  # Model for MCQ generation
    UNIT_TEST_MODEL: str = "gpt-4o-mini"  # Model for unit test generation
    SUMMARY_MODEL: str = "gpt-4o-mini"  # Model for summaries/one-nighters
    HINT_MODEL: str = "gpt-4o-mini"  # Model for hints and solutions
    
    @model_validator(mode='after')
    def set_openai_api_key(self):
        """Set OPENAI_API_KEY from LLM_API_KEY if not explicitly provided"""
        if not self.OPENAI_API_KEY and self.LLM_API_KEY:
            self.OPENAI_API_KEY = self.LLM_API_KEY
        return self
    
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
    
    model_config = SettingsConfigDict(
        # Look for .env in current directory, parent directory, or project root
        env_file=[
            ".env",
            "../.env",
            "../../.env",
            str(Path(__file__).parent.parent.parent / ".env"),  # project root
            str(Path(__file__).parent.parent / ".env"),  # backend/.env
        ],
        env_file_encoding="utf-8",
        case_sensitive=True,
        # Also check environment variables (default behavior)
        extra="ignore",
    )


settings = Settings()
