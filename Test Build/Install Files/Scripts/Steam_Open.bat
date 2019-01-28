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
TASKLIST /FI "IMAGENAME eq Xpadder.exe" 2>NUL | FIND /I /N "Xpadder.exe">NUL
	IF NOT "%ERRORLEVEL%"=="0" START "" "%dirpath%\Tools\Xpadder\Xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
START "" "%steampath%\Steam.exe" -start steam://open/bigpicture
EXIT