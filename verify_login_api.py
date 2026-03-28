import requests
import json

def verify_login():
    url = "http://127.0.0.1:8000/api/login/"
    data = {
        "username": "admin",
        "password": "password123",
        "role": "UROLOGIST"
    }
    headers = {'Content-Type': 'application/json'}
    
    try:
        print(f"Sending POST request to {url}...")
        response = requests.post(url, data=json.dumps(data), headers=headers)
        print(f"Status Code: {response.status_code}")
        print(f"Response Body: {response.text}")
        
        if response.status_code == 200:
            print("\nSUCCESS: The 500 Internal Server Error is resolved and login is working.")
        elif response.status_code == 500:
            print("\nFAILURE: Still receiving 500 Internal Server Error.")
        else:
            print(f"\nRECEIVED: {response.status_code} - unexpected but not a 500.")
            
    except Exception as e:
        print(f"Error during request: {e}")

if __name__ == "__main__":
    verify_login()
