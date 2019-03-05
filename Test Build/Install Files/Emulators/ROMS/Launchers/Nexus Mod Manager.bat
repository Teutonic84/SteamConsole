ECHO off

cd "%~dp0%"
cd ..\..\..
SET "dirpath=%cd%"

:app_path
FOR %%w IN (C D E F G H I J K L) DO @IF EXIST %%w: FOR /f "delims=" %%x IN ('where /R %%w:\ "NexusClient.exe"') DO SET "instloc=%%x"
cls

START /MAX "" "%instloc%"

:check
PING localhost -n 2 2>NUL 1>NUL
TASKLIST /FI "IMAGENAME eq NexusClient.exe" 2>NUL | FIND /I /N "NexusClient.exe">NUL
IF "%ERRORLEVEL%"=="0" GOTO check

:end
EXIT
