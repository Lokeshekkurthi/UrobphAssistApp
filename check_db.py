import os
import sys
import django

sys.path.append(os.getcwd())
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'urobph_backend.settings')
django.setup()

from api.models import User

print("--- USERS IN DATABASE ---")
for u in User.objects.all():
    print(f"User: {u.username} | Email: {u.email} | urol: {u.urologist} | tech: {u.technologist} | Pwd: {u.password}")
