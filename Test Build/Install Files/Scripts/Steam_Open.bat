ECHO off
cd "%~dp0%"
cd ..
SET "dirpath=%cd%"

IF EXIST "%dirpath%\steam_path.txt" DEL "%dirpath%\steam_path.txt" >NUL
cscript.exe "%dirpath%\Scripts\steam_path_check.vbs" > "%dirpath%\steam_path.txt"

:steampath
FOR /f "usebackq delims=" %%i IN ("%dirpath%\steam_path.txt") DO SET "steampath=%%i"
DEL "%dirpath%\steam_path.txt" >NUL

cls
ECHO.
ECHO.
ECHO          **       ****    *****   ***     ****  **    **    *****
ECHO          **      **  **  **   **  ** **    **   ***   **   **   **
ECHO          **      **  **  *******  **  **   **   ** *  **  **
ECHO          **      **  **  **   **  **  **   **   **  * **  **  ****
ECHO          ******  **  **  **   **  ** **    **   **   ***   **   **
ECHO          ******   ****   **   **  ***     ****  **    **    *****
ECHO.
ECHO.
ECHO.
ECHO.
TASKLIST /FI "IMAGENAME eq Custom Hotkeys.exe" 2>NUL | FIND /I /N "Custom Hotkeys.exe">NUL
	IF NOT "%ERRORLEVEL%"=="0" START "" "%dirpath%\Tools\Custom Hotkeys.exe"
TASKLIST /FI "IMAGENAME eq antimicro.exe" 2>NUL | FIND /I /N "antimicro.exe">NUL
	IF NOT "%ERRORLEVEL%"=="0" START "" "%dirpath%\Tools\antimicro\antimicro.exe"
START "" "%steampath%\Steam.exe" -start steam://open/bigpicture
EXIT