"""
Google Drive service for file storage and management
"""
from google.oauth2.credentials import Credentials
from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload, MediaIoBaseDownload, MediaIoBaseUpload
from typing import Optional, BinaryIO
import io

from app.config import settings


class GoogleDriveService:
    """Service for Google Drive operations"""
    
    def __init__(self):
        self.service = None
        self.folder_id = settings.GOOGLE_DRIVE_FOLDER_ID
        self._initialize_service()
    
    def _initialize_service(self):
        """Initialize Google Drive API service"""
        try:
            # For MVP, using service account credentials
            # In production, use OAuth2 flow
            credentials = service_account.Credentials.from_service_account_file(
                settings.GOOGLE_DRIVE_CREDENTIALS_PATH,
                scopes=['https://www.googleapis.com/auth/drive']
            )
            self.service = build('drive', 'v3', credentials=credentials)
        except Exception as e:
            print(f"Error initializing Google Drive service: {e}")
            # In development, allow continuation without Drive
            self.service = None
    
    def upload_file(self, file_path: str, file_name: str, mime_type: str = None) -> Optional[dict]:
        """Upload file to Google Drive"""
        if not self.service:
            return None
        
        try:
            file_metadata = {
                'name': file_name,
                'parents': [self.folder_id] if self.folder_id else []
            }
            
            media = MediaFileUpload(
                file_path,
                mimetype=mime_type,
                resumable=True
            )
            
            file = self.service.files().create(
                body=file_metadata,
                media_body=media,
                fields='id, name, webViewLink, webContentLink'
            ).execute()
            
            return {
                'file_id': file.get('id'),
                'file_name': file.get('name'),
                'web_view_link': file.get('webViewLink'),
                'web_content_link': file.get('webContentLink')
            }
        except Exception as e:
            print(f"Error uploading file to Drive: {e}")
            return None
    
    def upload_file_object(self, file_obj: BinaryIO, file_name: str, mime_type: str = None) -> Optional[dict]:
        """Upload file object (BytesIO) to Google Drive"""
        if not self.service:
            return None
        
        try:
            file_metadata = {
                'name': file_name,
                'parents': [self.folder_id] if self.folder_id else []
            }
            
            media = MediaIoBaseUpload(
                file_obj,
                mimetype=mime_type,
                resumable=True
            )
            
            file = self.service.files().create(
                body=file_metadata,
                media_body=media,
                fields='id, name, webViewLink, webContentLink'
            ).execute()
            
            return {
                'file_id': file.get('id'),
                'file_name': file.get('name'),
                'web_view_link': file.get('webViewLink'),
                'web_content_link': file.get('webContentLink')
            }
        except Exception as e:
            print(f"Error uploading file object to Drive: {e}")
            return None
    
    def get_file_url(self, file_id: str) -> Optional[str]:
        """Get shareable URL for a file"""
        if not self.service:
            return None
        
        try:
            # Make file publicly viewable (for MVP)
            self.service.permissions().create(
                fileId=file_id,
                body={'type': 'anyone', 'role': 'reader'}
            ).execute()
            
            file = self.service.files().get(
                fileId=file_id,
                fields='webViewLink, webContentLink'
            ).execute()
            
            return file.get('webViewLink') or file.get('webContentLink')
        except Exception as e:
            print(f"Error getting file URL: {e}")
            return None
    
    def download_file(self, file_id: str) -> Optional[bytes]:
        """Download file content from Google Drive"""
        if not self.service:
            return None
        
        try:
            request = self.service.files().get_media(fileId=file_id)
            file_content = io.BytesIO()
            downloader = MediaIoBaseDownload(file_content, request)
            
            done = False
            while done is False:
                status, done = downloader.next_chunk()
            
            file_content.seek(0)
            return file_content.read()
        except Exception as e:
            print(f"Error downloading file: {e}")
            return None
    
    def delete_file(self, file_id: str) -> bool:
        """Delete file from Google Drive"""
        if not self.service:
            return False
        
        try:
            self.service.files().delete(fileId=file_id).execute()
            return True
        except Exception as e:
            print(f"Error deleting file: {e}")
            return False
