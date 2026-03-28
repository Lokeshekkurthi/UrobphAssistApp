import requests
import json

url = "http://127.0.0.1:8000/api/register/"
data = {
    "username": "test_tech@example.com",
    "email": "test_tech@example.com",
    "first_name": "Test",
    "last_name": "Technologist",
    "password": "password123",
    "license_number": "TECH123",
    "specialty": "Technician",
    "role": "TECHNOLOGIST"
}

try:
    response = requests.post(url, json=data)
    print(f"Status Code: {response.status_code}")
    print(f"Response: {response.json()}")
except Exception as e:
    print(f"Error: {e}")
