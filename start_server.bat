@echo off
cd /d "C:\Users\MRA\Desktop\Coding Nerdy Stuff\Image_rater"

start cmd /k venv\Scripts\python.exe app.py

timeout /t 5

start cmd /k npx localtunnel --port 5000 --subdomain imagerater