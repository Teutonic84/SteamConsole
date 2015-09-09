echo off

cd ..\..
set dirpath=%cd%

if exist "C:\Program Files (x86)" (
    set "programfiles=C:\Program Files (x86)"
)
if not exist "C:\Program Files (x86)" (
    set "programfiles=C:\Program Files"
)

start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile"
"%programfiles%\Google\Chrome\Application\chrome.exe" --kiosk "http://twitch.tv"

"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"

exit
