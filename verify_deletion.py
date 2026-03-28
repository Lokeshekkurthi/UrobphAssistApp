import requests
import json

def verify_deletion():
    # 1. Login to get token
    login_url = "http://127.0.0.1:8000/api/login/"
    login_data = {
        "username": "admin",
        "password": "password123",
        "role": "UROLOGIST"
    }
    
    try:
        print("Logging in to get token...")
        resp = requests.post(login_url, json=login_data)
        if resp.status_code != 200:
            print(f"Login failed: {resp.text}")
            return
        
        token = resp.json().get('token')
        headers = {
            'Authorization': f'Token {token}',
            'Content-Type': 'application/json'
        }
        
        # 2. Get a patient list to find an MRN to delete (or create one)
        print("Fetching patient list...")
        resp = requests.get("http://127.0.0.1:8000/api/patients/", headers=headers)
        patients = resp.json()
        
        if not patients:
            print("No patients found to delete. Creating a test patient...")
            # Create a test patient
            sync_url = "http://127.0.0.1:8000/api/sync/"
            test_patient = [{
                "mrn": "TEST-123",
                "name": "Test Delete Patient",
                "age": "30",
                "gender": "Male"
            }]
            requests.post(sync_url, json=test_patient, headers=headers)
            target_mrn = "TEST-123"
        else:
            target_mrn = patients[0]['mrn']
            
        print(f"Attempting to delete patient with MRN: {target_mrn}")
        delete_url = f"http://127.0.0.1:8000/api/patients/{target_mrn}/"
        resp = requests.delete(delete_url, headers=headers)
        
        print(f"Status Code: {resp.status_code}")
        if resp.status_code == 204:
            print("SUCCESS: Patient record deleted successfully.")
        else:
            print(f"FAILURE: Unexpected status code {resp.status_code}. Response: {resp.text}")
            
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    verify_deletion()
