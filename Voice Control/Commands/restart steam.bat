echo off
cls

tasklist /FI "IMAGENAME eq steam.exe" 2>NUL | find /I /N "steam.exe">NUL
if "%ERRORLEVEL%"=="0" taskkill /im "steam.exe" /f

ping localhost -n3 >NUL
start "" "C:\Program Files (x86)\Steam\Steam.exe"

exit