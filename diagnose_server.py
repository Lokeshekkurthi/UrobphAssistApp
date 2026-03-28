import subprocess
import sys
import os
import time

def run_diagnostic():
    print("--- UroBPH Backend Diagnostic ---")
    python_exe = r"C:\Users\lokes\AppData\Local\Python\pythoncore-3.14-64\python.exe"
    print(f"Using Python: {python_exe}")
    
    if not os.path.exists(python_exe):
        print(f"ERROR: Python not found at {python_exe}")
        return

    print("Checking Django...")
    # Find manage.py relative to the script location
    script_dir = os.path.dirname(os.path.abspath(__file__))
    manage_py = os.path.join(script_dir, "manage.py")
    
    if not os.path.exists(manage_py):
        print(f"ERROR: manage.py not found at {manage_py}")
        return

    try:
        res = subprocess.run([python_exe, manage_py, "check"], capture_output=True, text=True)
        print(f"Check result: {res.returncode}")
        print(f"Check output: {res.stdout}")
        print(f"Check errors: {res.stderr}")
    except Exception as e:
        print(f"ERROR running check: {e}")

    print("\nAttempting to start server on port 8000 (Ctrl+C to stop)...")
    try:
        # Start server and keep it alive
        proc = subprocess.Popen([python_exe, manage_py, "runserver", "8000", "--noreload"], 
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        
        # Read first few lines of output
        for _ in range(10):
            line = proc.stdout.readline()
            if not line: break
            print(f"Server: {line.strip()}")
            if "Quit the server with" in line:
                print("\nSUCCESS: Server is running!")
                break
        
        # Keep running
        proc.wait()
    except KeyboardInterrupt:
        print("\nStopping diagnostic...")
        proc.terminate()
    except Exception as e:
        print(f"ERROR starting server: {e}")

if __name__ == "__main__":
    run_diagnostic()
