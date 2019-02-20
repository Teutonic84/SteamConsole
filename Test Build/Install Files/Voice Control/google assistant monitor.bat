echo off
cls
cd "%~dp0%"
cd ..
SET "dirpath=%cd%"
cd "%~dp0%"

ECHO Waiting for "open game.txt" to appear...

:loop
IF EXIST "%USERPROFILE%\Dropbox\controlcomputer\open game.txt" CALL :game
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
SET /P game=<"%USERPROFILE%\Dropbox\controlcomputer\open game.txt"
ECHO.
ECHO Loading Game: %game%
ECHO.

FOR /f "tokens=3,5,7,9 delims=[]" %%a IN ('FINDSTR /I /C:"[%game%]" games.db') DO (
    SET "gamefile=%%a"
    SET "console=%%b"
    SET "type=%%c"
    SET "gpath=%%d"
)
SETLOCAL ENABLEDELAYEDEXPANSION
IF "%type%"=="RetroArch" (
    SET "gpath=%dirpath%\Emulators\ROMS\%console%\%gamefile%"
    SET "rpath=%dirpath%\Emulators\RetroArch"
    SET "xpath=%dirpath%\Tools\Xpadder"

    IF "%console%"=="NES" SET "core=nestopia"
    IF "%console%"=="SNES" SET "core=snes9x"
    IF "%console%"=="N64" SET "core=mupen64plus"
    IF "%console%"=="GBA" SET "core=vbam"
    IF "%console%"=="NDS" SET "core=desmume"
    IF "%console%"=="SEGA" SET "core=genesis_plus_gx"
    IF "%console%"=="PS1" SET "core=mednafen_psx"
    IF "%console%"=="PSP" SET "core=ppsspp"

    TASKKILL /im "Custom Hotkeys.exe" >NUL
    COPY /y "!xpath!\Controller Maps\Controller Map - RetroArch.JPG" "!xpath!\Controller Maps\Controller Map.JPG" >NUL
    START "" "!xpath!\Custom Hotkeys.exe"

    "!rpath!\retroarch.exe" --config "!rpath!\configs\!core!_libretro.cfg" -L "!rpath!\cores\!core!_libretro.dll" "!gpath!" -f
    
    DEL /Q /S "%USERPROFILE%\Dropbox\controlcomputer\open game.txt" >NUL
    TASKKILL /im "Custom Hotkeys.exe" >NUL
    COPY /y "!xpath!\Controller Maps\Controller Map - Steam.JPG" "!xpath!\Controller Maps\Controller Map.JPG" >NUL
    START "" "!xpath!\Custom Hotkeys.exe"
)
ECHO.
ECHO Quit Game: %game%
ECHO.
ECHO Waiting for "open game.txt" to appear...
PING localhost -n20 >NUL
GOTO :eof

:end
EXIT