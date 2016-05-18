echo off

cd ..\..
set "dirpath=%cd%"

start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\RetroArch.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\RetroArch.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\RetroArch.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\RetroArch.xpadderprofile"
copy /y "%dirpath%\Docs\Controller Maps\360 Controller - Retroarch.rtf" "%dirpath%\Docs\Controller Maps\360 Controller.rtf"
"%dirpath%\Emulators\RetroArch\retroarch.exe" --config "%dirpath%\Emulators\RetroArch\configs\CONFIGFILE_libretro.cfg" -L "%dirpath%\Emulators\RetroArch\cores\CONFIGFILE_libretro.dll" "%dirpath%\Emulators\ROMS\CONGEN\ROMFILE" -f

:xpadder
::"%dirpath%\Tools\Xpadder\xpadder.exe" /C
::start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
copy /y "%dirpath%\Docs\Controller Maps\360 Controller - Steam.rtf" "%dirpath%\Docs\Controller Maps\360 Controller.rtf"
:end
exit
