import os
import django
from django.core.mail import send_mail

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'urobph_backend.settings')
django.setup()

try:
    print("Attempting to send test email...")
    res = send_mail(
        'Test Subject',
        'Test Message from UroBPHAssist',
        None,
        ['lokeshekkurthi898@gmail.com'], # Sending to user's email to verify receipt
        fail_silently=False,
    )
    print('Email sent result:', res)
except Exception as e:
    print('Error sending email:', e)
