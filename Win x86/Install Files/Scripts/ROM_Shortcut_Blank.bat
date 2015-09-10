echo off

cd ..\..
set dirpath=%cd%

start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\CONSOLE_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\CONSOLE_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\CONSOLE_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\CONSOLE_Xbox360.xpadderprofile"
copy /y "%dirpath%\Docs\Controller Maps\360 Controller - Retroarch.rtf" "%dirpath%\Docs\Controller Maps\360 Controller.rtf"
if exist "C:\Program Files (x86)" (
    "%dirpath%\Emulators\RetroArch_x64\retroarch.exe" --config "%dirpath%\Emulators\RetroArch_x64\configs\CONFIGFILE_libretro.cfg" -L "%dirpath%\Emulators\RetroArch_x64\cores\CONFIGFILE_libretro.dll" "%dirpath%\Emulators\ROMS\CONGEN\ROMFILE" -f
    goto xpadder
)
"%dirpath%\Emulators\RetroArch_x86\retroarch.exe" --config "%dirpath%\Emulators\RetroArch_x86\configs\CONFIGFILE_libretro.cfg" -L "%dirpath%\Emulators\RetroArch_x86\cores\CONFIGFILE_libretro.dll" "%dirpath%\Emulators\ROMS\CONGEN\ROMFILE" -f

:xpadder
"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
copy /y "%dirpath%\Docs\Controller Maps\360 Controller - Steam.rtf" "%dirpath%\Docs\Controller Maps\360 Controller.rtf"
:end
exit
