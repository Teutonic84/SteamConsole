ECHO off
cd "%~dp0%"
SET "dirpath=%~1"
SET "browser=%~2"
SET "instloc=%~3"
SET "exefile=%~4"
SET "weblink="

START foxsportsgo:

:check
PING localhost -n 2 2>NUL 1>NUL
TASKLIST /FI "IMAGENAME eq foxsportsgo.exe" 2>NUL | FIND /I /N "foxsportsgo.exe">NUL
IF "%ERRORLEVEL%"=="0" GOTO check

:end
EXIT