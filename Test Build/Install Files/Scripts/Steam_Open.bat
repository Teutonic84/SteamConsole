echo off
cd "%~dp0%"
cd ..
set dirpath=%cd%

if exist "%dirpath%\steam_path.txt" del "%dirpath%\steam_path.txt"
cscript.exe "%dirpath%\Scripts\steam_path_check.vbs" > "%dirpath%\steam_path.txt"

:steampath
for /F "usebackq delims=" %%i in ("%dirpath%\steam_path.txt") do set "steampath=%%i"
del "%dirpath%\steam_path.txt"

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
echo.
TASKLIST /FI "IMAGENAME eq Custom Hotkeys.exe" 2>NUL | FIND /I /N "Custom Hotkeys.exe">NUL
	IF NOT "%ERRORLEVEL%"=="0" START "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"
TASKLIST /FI "IMAGENAME eq antimicro.exe" 2>NUL | FIND /I /N "antimicro.exe">NUL
	IF NOT "%ERRORLEVEL%"=="0" START "" "%dirpath%\Tools\antimicro\antimicro.exe"
START "" "%steampath%\Steam.exe" -start steam://open/bigpicture
EXIT