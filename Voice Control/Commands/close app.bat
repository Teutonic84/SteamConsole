echo off
cls

tasklist /FI "IMAGENAME eq PlexMediaPlayer.exe" 2>NUL | find /I /N "PlexMediaPlayer.exe">NUL
if "%ERRORLEVEL%"=="0" taskkill /im "PlexMediaPlayer.exe" /f

tasklist /FI "IMAGENAME eq chrome.exe" 2>NUL | find /I /N "chrome.exe">NUL
if "%ERRORLEVEL%"=="0" taskkill /im "chrome.exe"

tasklist /FI "IMAGENAME eq foxsportsgo.exe" 2>NUL | find /I /N "foxsportsgo.exe">NUL
if "%ERRORLEVEL%"=="0" taskkill /im "foxsportsgo.exe" /f

exit