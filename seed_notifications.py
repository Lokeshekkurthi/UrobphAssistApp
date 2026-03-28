import requests
import json

API_BASE_URL = 'http://127.0.0.1:8000/api'

def seed_notifications():
    # 1. Login to get token
    login_url = f"{API_BASE_URL}/login/"
    login_data = {
        "username": "admin",
        "password": "password123",
        "role": "UROLOGIST"
    }
    
    response = requests.post(login_url, json=login_data)
    if response.status_code != 200:
        print(f"Login failed: {response.text}")
        return
    
    token = response.json().get('token')
    print(f"Logged in, token: {token[:10]}...")
    
    # 2. Seed some notifications via Sync
    sync_url = f"{API_BASE_URL}/sync/"
    headers = {"Authorization": f"Token {token}", "Content-Type": "application/json"}
    
    # We need an MRN. Let's get one first.
    patients_url = f"{API_BASE_URL}/patients/"
    p_resp = requests.get(patients_url, headers=headers)
    if p_resp.status_code == 200 and p_resp.json():
        mrn = p_resp.json()[0]['mrn']
    else:
        mrn = "MRN-TEST-123" # Fallback
    
    sync_payload = [
        {
            "mrn": mrn,
            "notifications": [
                {
                    "title": "System Check: Success",
                    "message": "The notification system has been successfully restored.",
                    "type": "SUCCESS"
                },
                {
                    "title": "Clinical Alert: High Score",
                    "message": "A patient assessment has exceeded the risk threshold.",
                    "type": "URGENT"
                }
            ]
        }
    ]
    
    sync_resp = requests.post(sync_url, json=sync_payload, headers=headers)
    if sync_resp.status_code == 200:
        print("Successfully seeded notifications via sync.")
    else:
        print(f"Sync failed: {sync_resp.text}")

    # 3. Verify they can be listed
    list_url = f"{API_BASE_URL}/notifications/"
    list_resp = requests.get(list_url, headers=headers)
    if list_resp.status_code == 200:
        notis = list_resp.json()
        print(f"Retrieved {len(notis)} notifications:")
        for n in notis:
            print(f"- [{n['type']}] {n['title']}: {n['message']}")
    else:
        print(f"List failed: {list_resp.text}")

if __name__ == "__main__":
    seed_notifications()
