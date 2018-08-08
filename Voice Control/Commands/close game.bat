echo off
cls

tasklist /FI "IMAGENAME eq RocketLeague.exe" 2>NUL | find /I /N "RocketLeague.exe">NUL
if "%ERRORLEVEL%"=="0" taskkill /im "RocketLeague.exe"

tasklist /FI "IMAGENAME eq ShantaeHero.exe" 2>NUL | find /I /N "ShantaeHero.exe">NUL
if "%ERRORLEVEL%"=="0" taskkill /im "ShantaeHero.exe"

tasklist /FI "IMAGENAME eq retroarch.exe" 2>NUL | find /I /N "retroarch.exe">NUL
if "%ERRORLEVEL%"=="0" taskkill /im "retroarch.exe"

exit