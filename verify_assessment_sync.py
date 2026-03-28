import requests
import json

def verify_sync():
    url = "http://127.0.0.1:8000/api/sync/"
    token = "55516f159df36fa616deee6be1070d4347bb8227" # Admin token from previous step
    
    # First, ensure a patient exists
    headers = {
        'Content-Type': 'application/json',
        'Authorization': f'Token {token}'
    }
    
    patient_mrn = "TEST-MRN-001"
    
    # Step 1: Create patient
    print(f"Ensuring patient {patient_mrn} exists...")
    create_data = [{
        "mrn": patient_mrn,
        "name": "Test Patient",
        "age": "45"
    }]
    requests.post(url, data=json.dumps(create_data), headers=headers)
    
    # Step 2: Sync assessment WITHOUT name
    print(f"Syncing assessment for {patient_mrn} WITHOUT providing patient name...")
    sync_data = [{
        "mrn": patient_mrn,
        "assessments": [{
            "total_score": 15,
            "qol_score": 3
        }]
    }]
    
    try:
        response = requests.post(url, data=json.dumps(sync_data), headers=headers)
        print(f"Status Code: {response.status_code}")
        print(f"Response Body: {response.text}")
        
        if response.status_code == 200:
            print("\nSUCCESS: Assessment synced successfully without patient name.")
        else:
            print("\nFAILURE: Assessment sync failed.")
            
    except Exception as e:
        print(f"Error during request: {e}")

if __name__ == "__main__":
    verify_sync()
