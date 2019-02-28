echo off

cd "%~dp0%"
cd ..\..\..
SET "dirpath=%cd%"

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Chrome.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

START foxsportsgo:

:check
PING localhost -n 2 2>NUL 1>NUL
TASKLIST /FI "IMAGENAME eq foxsportsgo.exe" 2>NUL | FIND /I /N "foxsportsgo.exe">NUL
IF "%ERRORLEVEL%"=="0" GOTO check

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

:end
EXIT