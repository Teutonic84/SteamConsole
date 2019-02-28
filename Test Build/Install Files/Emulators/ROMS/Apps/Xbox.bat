ECHO off

cd "%~dp0%"
cd ..\..\..
SET "dirpath=%cd%"

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Chrome.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

START xbox:

:check
PING localhost -n 3 2>NUL 1>NUL
TASKLIST /FI "IMAGENAME eq xboxapp.exe" 2>NUL | FIND /I /N "xboxapp.exe">NUL
IF "%ERRORLEVEL%"=="0" GOTO check

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

:end
EXIT
