"""
Scopes - FastAPI Application Entry Point
"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from app.config import settings
from app.routers import chapters, assessments, assignments, discussions, users

app = FastAPI(
    title="Studious API",
    description="Education platform for curriculum coverage, assessment generation, and mastery tracking",
    version="0.1.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(users.router, prefix="/api/v1/users", tags=["users"])
app.include_router(chapters.router, prefix="/api/v1/chapters", tags=["chapters"])
app.include_router(assessments.router, prefix="/api/v1/assessments", tags=["assessments"])
app.include_router(assignments.router, prefix="/api/v1/assignments", tags=["assignments"])
app.include_router(discussions.router, prefix="/api/v1/discussions", tags=["discussions"])


@app.get("/")
async def root():
    """Health check endpoint"""
    return JSONResponse(
        content={
            "message": "Scopes API",
            "version": "0.1.0",
            "status": "running"
        }
    )


@app.get("/health")
async def health():
    """Detailed health check"""
    return JSONResponse(
        content={
            "status": "healthy",
            "service": "scopes-api"
        }
    )


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
