ECHO off
cls
cd "%~dp0%"
cd ..\..
SET dirpath=%cd%

IF EXIST "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt" del /q /s "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt"

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - RetroArch.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

"%dirpath%\Emulators\RetroArch\retroarch.exe" --config "%dirpath%\Emulators\RetroArch\configs\nestopia_libretro.cfg" -L "%dirpath%\Emulators\RetroArch\cores\nestopia_libretro.dll" "%dirpath%\Emulators\ROMS\NES\Super Mario Bros.zip" -f

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

EXIT
