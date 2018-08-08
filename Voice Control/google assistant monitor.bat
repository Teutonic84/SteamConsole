echo off
cls

ECHO Waiting for "open game.txt" to appear...

:loop
IF EXIST "C:\Users\User\Dropbox\controlcomputer\open game.txt" CALL :game
ENDLOCAL
GOTO end
::SET game=
::SET gamefile=
::SET console=
::SET type=
::SET gpath=
::ping localhost -n5 >NUL
::GOTO loop

:game
SET /P game=<"C:\Users\User\Dropbox\controlcomputer\open game.txt"
ECHO.
ECHO Loading Game: %game%
ECHO.

for /f "tokens=3,5,7,9 delims=[]" %%a in ('findstr /I /C:"[%game%]" games.db') do (
    SET "gamefile=%%a"
    SET "console=%%b"
    SET "type=%%c"
    SET "gpath=%%d"
)
SETLOCAL ENABLEDELAYEDEXPANSION
IF "%type%"=="RetroArch" (
    SET "gpath=C:\SteamConsole\Emulators\ROMS\%console%\%gamefile%"
    SET "rpath=C:\SteamConsole\Emulators\RetroArch"
    SET "xpath=C:\SteamConsole\Tools\Xpadder"

    IF "%console%"=="NES" SET "core=nestopia"
    IF "%console%"=="SNES" SET "core=snes9x"
    IF "%console%"=="N64" SET "core=mupen64plus"
    IF "%console%"=="GBA" SET "core=vbam"
    IF "%console%"=="NDS" SET "core=desmume"
    IF "%console%"=="SEGA" SET "core=genesis_plus_gx"
    IF "%console%"=="PS1" SET "core=mednafen_psx"
    IF "%console%"=="PSP" SET "core=ppsspp"

    taskkill /im "Custom Hotkeys.exe" >NUL
    copy /y "!xpath!\Controller Maps\Controller Map - RetroArch.JPG" "!xpath!\Controller Maps\Controller Map.JPG" >NUL
    start "" "!xpath!\Custom Hotkeys.exe"
    start "" "!xpath!\xpadder.exe" /M "!xpath!\Controller-Profiles\RetroArch.xpadderprofile" "!xpath!\Controller-Profiles\RetroArch.xpadderprofile" "!xpath!\Controller-Profiles\RetroArch.xpadderprofile" "!xpath!\Controller-Profiles\RetroArch.xpadderprofile"

    "!rpath!\retroarch.exe" --config "!rpath!\configs\!core!_libretro.cfg" -L "!rpath!\cores\!core!_libretro.dll" "!gpath!" -f
    DEL /Q /S "C:\Users\User\Dropbox\controlcomputer\open game.txt" >NUL

    "!xpath!\xpadder.exe" /C
    start "" "!xpath!\xpadder.exe" /M "!xpath!\Controller-Profiles\Steam_Xbox360.xpadderprofile" "!xpath!\Controller-Profiles\Steam_Xbox360.xpadderprofile" "!xpath!\Controller-Profiles\Steam_Xbox360.xpadderprofile" "!xpath!\Controller-Profiles\Steam_Xbox360.xpadderprofile"
    taskkill /im "Custom Hotkeys.exe" >NUL
    copy /y "!xpath!\Controller Maps\Controller Map - Steam.JPG" "!xpath!\Controller Maps\Controller Map.JPG" >NUL
    start "" "!xpath!\Custom Hotkeys.exe"
)
ECHO.
ECHO Quit Game: %game%
ECHO.
ECHO Waiting for "open game.txt" to appear...
ping localhost -n20 >NUL
GOTO :eof

:end
exit