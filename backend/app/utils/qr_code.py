"""
QR code and share link generation utilities
"""
import qrcode
from io import BytesIO
import secrets
from typing import Optional


def generate_share_token() -> str:
    """Generate a unique share token"""
    return secrets.token_urlsafe(16)


def generate_qr_code(data: str) -> BytesIO:
    """Generate QR code image from data"""
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(data)
    qr.make(fit=True)
    
    img = qr.make_image(fill_color="black", back_color="white")
    buffer = BytesIO()
    img.save(buffer, format='PNG')
    buffer.seek(0)
    return buffer


def generate_share_link(base_url: str, token: str, resource_type: str) -> str:
    """Generate shareable link for resource"""
    return f"{base_url}/{resource_type}/{token}"


def generate_qr_data(base_url: str, token: str, resource_type: str) -> str:
    """Generate data string for QR code"""
    return generate_share_link(base_url, token, resource_type)
