echo off
cd ..
set dirpath=%cd%
if exist "%dirpath%\steam_path.txt" del "%dirpath%\steam_path.txt"

  taskkill /f /im "Custom Hotkeys.exe"
  cscript.exe "%dirpath%\Scripts\steam_path_check.vbs" > "%dirpath%\steam_path.txt"

:steampath
for /F "usebackq delims=" %%i in ("%dirpath%\steam_path.txt") do set "steampath=%%i"
del "%dirpath%\steam_path.txt"

"%dirpath%\Tools\Xpadder\Xpadder.exe" /C
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
start "" "%dirpath%\Tools\DS4Tool-1.2.2\ScpServer.exe"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"
start "" "%dirpath%\Tools\Xpadder\Xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
start "" "%steampath%\Steam.exe" -start steam://open/bigpicture
if exist "C:\Program Files (x86)\Google\Drive\googledrivesync.exe" start "" "C:\Program Files (x86)\Google\Drive\googledrivesync.exe"
exit
