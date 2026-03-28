import os
import sys
import django

# Add the project root to sys.path
sys.path.append(os.getcwd())

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'urobph_backend.settings')
django.setup()

from api.models import User

users = User.objects.all()
for user in users:
    user.set_password('password123')
    user.save()
    print(f"Password reset for: {user.username}")
