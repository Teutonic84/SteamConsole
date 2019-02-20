echo off
cls
cd "%~dp0%"
cd ..\..
set dirpath=%cd%

IF EXIST "%dirpath%\steam_path.txt" del "%dirpath%\steam_path.txt"
cscript.exe "%dirpath%\Scripts\steam_path_check.vbs" > "%dirpath%\steam_path.txt"

:steampath
FOR /F "usebackq delims=" %%i IN ("%dirpath%\steam_path.txt") DO SET "steampath=%%i"
DEL "%dirpath%\steam_path.txt"

TASKLIST /FI "IMAGENAME eq steam.exe" 2>NUL | FIND /I /N "steam.exe">NUL
IF "%ERRORLEVEL%"=="0" TASKKILL /im "steam.exe" /f

PING localhost -n3 >NUL
START "" "%steampath%\Steam.exe"

EXIT