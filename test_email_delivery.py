import os
import django
import sys

# Set up Django environment
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'urobph_backend.settings')
django.setup()

from django.core.mail import send_mail
from django.conf import settings

def test_email():
    print(f"Using EMAIL_HOST: {settings.EMAIL_HOST}")
    print(f"Using EMAIL_HOST_USER: {settings.EMAIL_HOST_USER}")
    
    try:
        subject = 'UroBPHAssist Service Test'
        message = 'If you are reading this, the email configuration for UroBPHAssist is working correctly.'
        recipient_list = [settings.EMAIL_HOST_USER] # Send to self
        
        sent = send_mail(subject, message, None, recipient_list)
        if sent:
            print("Successfully sent test email!")
        else:
            print("Failed to send test email (returned 0).")
    except Exception as e:
        print(f"Error sending email: {str(e)}")

if __name__ == "__main__":
    test_email()
