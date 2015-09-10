echo off

cd ..
set dirpath=%cd%
cls

if exist "C:\Program Files (x86)" (
    set "programfiles=C:\Program Files (x86)"
)
if not exist "C:\Program Files (x86)" (
    set "programfiles=C:\Program Files"
)

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

taskkill /f /im "Custom Hotkeys.exe"
start "" "%steampath%\Steam.exe" -start steam://open/bigpicture
start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

exit