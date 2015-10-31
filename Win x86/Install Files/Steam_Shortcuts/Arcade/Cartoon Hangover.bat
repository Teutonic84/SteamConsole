echo off

cd ..\..
set dirpath=%cd%
set "programfiles=C:\Program Files"

start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile"
copy /y "%dirpath%\Docs\Controller Maps\360 Controller - Chrome.rtf" "%dirpath%\Docs\Controller Maps\360 Controller.rtf"
"%programfiles%\Google\Chrome\Application\chrome.exe" --kiosk "http://cartoonhangover.com"

"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
copy /y "%dirpath%\Docs\Controller Maps\360 Controller - Steam.rtf" "%dirpath%\Docs\Controller Maps\360 Controller.rtf"

exit