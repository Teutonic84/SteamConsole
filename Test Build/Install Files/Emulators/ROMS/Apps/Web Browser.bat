ECHO off
cd "%~dp0%"
SET "dirpath=%~1"
SET "browser=%~2"
SET "instloc=%~3"
SET "exefile=%~4"

"%instloc%\%exefile%"

:check
PING localhost -n 2 2>NUL 1>NUL
TASKLIST /FI "IMAGENAME eq %exefile%" 2>NUL | FIND /I /N "%exefile%">NUL
IF "%ERRORLEVEL%"=="0" GOTO check

:end
EXIT