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

start "" "%dirpath%\Tools\DS4Tool-1.2.2\ScpServer.exe"
::start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"
"%dirpath%\Scripts\services.lnk"
start "" "%programfiles%\Steam\Steam.exe"

exit