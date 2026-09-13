@echo off
cd /d C:\temp\ps4_web
echo Serving C:\temp\ps4_web on http://0.0.0.0:8080
echo Open in the PS4 browser:  http://<PC-IP>:8080/run_lapse.html
python -m http.server 8080
pause