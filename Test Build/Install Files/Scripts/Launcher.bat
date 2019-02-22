ECHO off
cls
CD "%~dp0%"
cd ..
SET "dirpath=%cd%"

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
IF "%platform%"=="ps1" SET "core=pcsx_rearmed"
::IF "%platform%"=="ps1" SET "core=mednafen_psx"

ECHO Loading "%game%"
ECHO Done

IF "%emu%"=="apps" (
    "%game%"
	ECHO.
	ECHO Closing "%game%"
    GOTO end
)
IF "%emu%"=="pc" (
    "%game%"
    ECHO.
    ECHO Closing "%game%"
    GOTO end
)
IF "%emu%"=="launcher" (
    "%game%"
    ECHO.
    ECHO Closing "%game%"
    GOTO end
)
IF "%emu%"=="retroarch" (
    TASKKILL /im "Custom Hotkeys.exe" >NUL
    COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - RetroArch.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG" >NUL
    START "" "%dirpath%\Tools\Custom Hotkeys.exe"
    "%dirpath%\Emulators\RetroArch\retroarch.exe" --config "%dirpath%\Emulators\RetroArch\config\%core%_libretro.cfg" -L "%dirpath%\Emulators\RetroArch\cores\%core%_libretro.dll" "%game%" -f
)
IF "%emu%"=="dolphin" (
    TASKKILL /im "Custom Hotkeys.exe" >NUL
    COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Dolphin_PCSX2.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG" >NUL
    START "" "%dirpath%\Tools\Custom Hotkeys.exe"
    "%dirpath%\Emulators\Gamecube\Dolphin\dolphin.exe" -e "%game%" -b
)
IF "%emu%"=="pcsx2" (
    TASKKILL /im "Custom Hotkeys.exe" >NUL
    COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Dolphin_PCSX2.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG" >NUL
    START "" "%dirpath%\Tools\Custom Hotkeys.exe"
    "%dirpath%\Emulators\PS2\pcsx2\pcsx2.exe" --nogui "%game%"
)

:xpadder
ECHO.
ECHO Closing "%game%"

TASKKILL /im "Custom Hotkeys.exe" >NUL
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG" >NUL
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

:end
ECHO Done
EXIT
