echo off

cd ..\..\..
set dirpath=%cd%

start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\ePSXe_Xbox360.xpadderprofile"
"%dirpath%\Emulators\PS1\ePSXe\ps1.lnk" -nogui -loadiso "%dirpath%\Emulators\ROMS\CONGEN\ROMFILE"
"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"

:end
exit
