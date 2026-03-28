import os
import django
from django.conf import settings
from django.core.mail import send_mail

# Mocking settings if not running within django context for quick test
# But better to run with manage.py shell
print("To test email delivery, run: python manage.py shell")
print("Then paste:")
print("from django.core.mail import send_mail")
print("send_mail('Test', 'This is a test', None, ['lokeshekkurthi898@gmail.com'])")
