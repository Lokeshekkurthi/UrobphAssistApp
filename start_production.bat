@echo off
cd /d "c:\Users\lokes\AndroidStudioProjects\UroBPHAssist\backend"
echo Starting UroBPH Production Server with Waitress...
"C:\Users\lokes\AppData\Local\Python\pythoncore-3.14-64\python.exe" -m waitress --port=8000 urobph_backend.wsgi:application
