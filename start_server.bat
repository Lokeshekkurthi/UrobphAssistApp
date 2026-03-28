@echo off
cd /d "c:\Users\lokes\AndroidStudioProjects\UroBPHAssist\backend"
"C:\Users\lokes\AppData\Local\Python\pythoncore-3.14-64\python.exe" manage.py runserver 8000 > server_log.txt 2>&1
