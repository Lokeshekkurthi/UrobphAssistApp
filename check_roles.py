import os
import sys
import django

# Add the project root to sys.path
sys.path.append(os.getcwd())

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'urobph_backend.settings')
django.setup()

from api.models import User

users = User.objects.all()
if users.exists():
    print(f"Found {users.count()} users:")
    print(f"{'Username':<40} {'Urologist':<10} {'Technologist':<12} {'Is Superuser':<15}")
    for user in users:
        print(f"{user.username:<40} {user.urologist:<10} {user.technologist:<12} {user.is_superuser:<15}")
else:
    print("No users found in database.")
