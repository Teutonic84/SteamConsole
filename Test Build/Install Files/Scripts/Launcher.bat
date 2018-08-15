ECHO off
cls
SET "emu=%~1
SET "platform=%~2"
SET "game=%~3"

IF "%platform%"=="ds" SET "core=desmume"
IF "%platform%"=="gba" SET "core=vbam"
IF "%platform%"=="nes" SET "core=nestopia"
IF "%platform%"=="snes" SET "core=snes9x"
IF "%platform%"=="n64" SET "core=mupen64plus"
IF "%platform%"=="sega" SET "core=genesis_plus_gx"
IF "%platform%"=="psp" SET "core=ppsspp"
IF "%platform%"=="ps1" SET "core=mednafen_psx"

echo emu= %emu%
echo platform= %platform%
echo game= %game%
echo core= %core%
pause

ECHO Loading "%game%"
ECHO.

IF "%emu%"=="apps" (
    "%game%"
    GOTO end
)

cd ..
SET "dirpath=%cd%"

IF "%emu%"=="retroarch" (
    TASKKILL /im "Custom Hotkeys.exe" >NUL
    COPY /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - RetroArch.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG" >NUL
    START "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"
    START "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\RetroArch.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\RetroArch.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\RetroArch.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\RetroArch.xpadderprofile"
    "%dirpath%\Emulators\RetroArch\retroarch.exe" --config "%dirpath%\Emulators\RetroArch\configs\%core%_libretro.cfg" -L "%dirpath%\Emulators\RetroArch\cores\%core%_libretro.dll" "%game%" -f
)

:xpadder
"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
taskkill /im "Custom Hotkeys.exe" >NUL
copy /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG" >NUL
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"
:end
EXIT