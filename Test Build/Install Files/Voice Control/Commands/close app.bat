echo off
cls

TASKLIST /FI "IMAGENAME eq PlexMediaPlayer.exe" 2>NUL | FIND /I /N "PlexMediaPlayer.exe">NUL
IF "%ERRORLEVEL%"=="0" TASKKILL /im "PlexMediaPlayer.exe" /f

TASKLIST /FI "IMAGENAME eq chrome.exe" 2>NUL | FIND /I /N "chrome.exe">NUL
IF "%ERRORLEVEL%"=="0" TASKKILL /im "chrome.exe"

TASKLIST /FI "IMAGENAME eq foxsportsgo.exe" 2>NUL | FIND /I /N "foxsportsgo.exe">NUL
IF "%ERRORLEVEL%"=="0" TASKKILL /im "foxsportsgo.exe" /f

EXIT