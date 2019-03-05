ECHO off
cd "%~dp0%"
SET "dirpath=%~1"
SET "browser=%~2"
SET "instloc=%~3"
SET "exefile=%~4"

START xbox:

:check
PING localhost -n 3 2>NUL 1>NUL
TASKLIST /FI "IMAGENAME eq xboxapp.exe" 2>NUL | FIND /I /N "xboxapp.exe">NUL
IF "%ERRORLEVEL%"=="0" GOTO check

:end
EXIT
