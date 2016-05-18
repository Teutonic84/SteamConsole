echo off

cd ..\..
set "dirpath=%cd%"

start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\CONSOLE_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\CONSOLE_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\CONSOLE_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\CONSOLE_Xbox360.xpadderprofile"
copy /y "%dirpath%\Docs\Controller Maps\360 Controller - CONSOLE.rtf" "%dirpath%\Docs\Controller Maps\360 Controller.rtf"
"%dirpath%\Emulators\PROGRAM "%dirpath%\Emulators\ROMS\CONGEN\ROMFILE

:xpadder
::"%dirpath%\Tools\Xpadder\xpadder.exe" /C
::start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
copy /y "%dirpath%\Docs\Controller Maps\360 Controller - Steam.rtf" "%dirpath%\Docs\Controller Maps\360 Controller.rtf"
:end
exit
