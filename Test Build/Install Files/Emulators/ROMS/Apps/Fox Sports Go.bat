echo off

cd "%~dp0%"
cd ..\..\..
set "dirpath=%cd%"

taskkill /im "Custom Hotkeys.exe"
copy /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - Chrome.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile"
start foxsportsgo:

:check
ping localhost -n 2 2>NUL 1>NUL
tasklist /FI "IMAGENAME eq foxsportsgo.exe" 2>NUL | find /I /N "foxsportsgo.exe">NUL
if "%ERRORLEVEL%"=="0" goto check

"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"

taskkill /im "Custom Hotkeys.exe"
copy /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

exit