echo off
cls
set "dirpath=c:\SteamConsole"

IF EXIST "C:\Users\User\Dropbox\controlcomputer\controlfile.txt" del /q /s "C:\Users\User\Dropbox\controlcomputer\controlfile.txt"

taskkill /im "Custom Hotkeys.exe"
copy /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - RetroArch.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"
start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\RetroArch.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\RetroArch.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\RetroArch.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\RetroArch.xpadderprofile"
"%dirpath%\Emulators\RetroArch\retroarch.exe" --config "%dirpath%\Emulators\RetroArch\configs\nestopia_libretro.cfg" -L "%dirpath%\Emulators\RetroArch\cores\nestopia_libretro.dll" "%dirpath%\Emulators\ROMS\NES\Super Mario Bros.zip" -f

:xpadder
"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"

taskkill /im "Custom Hotkeys.exe"
copy /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

:end
exit
