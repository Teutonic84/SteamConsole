echo off

cd ..\..\..
set dirpath=%cd%

start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\pcsx2_Xbox360.xpadderprofile"
"%dirpath%\Emulators\PS2\pcsx2\pcsx2.exe" "%dirpath%\Emulators\ROMS\CONGEN\ROMFILE"
"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"

:end
exit
