echo off
cd "%~dp0"
cd ..\..
set "dirpath=%cd%"

taskkill /im "Custom Hotkeys.exe"
copy /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - Dolphin_PCSX2.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\CONSOLE_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\CONSOLE_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\CONSOLE_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\CONSOLE_Xbox360.xpadderprofile"
"%dirpath%\Emulators\PROGRAM "%dirpath%\Emulators\ROMS\CONGEN\ROMFILE

:xpadder
"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"

taskkill /im "Custom Hotkeys.exe"
copy /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

:end
exit