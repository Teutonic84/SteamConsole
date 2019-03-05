ECHO off
cls
CD "%~dp0%"
cd ..
SET "dirpath=%cd%"
SET "emu=%~1"
SET "platform=%~2"
SET "game=%~3"
SET "key64=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
SET "key32=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

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
  TASKKILL /im "Custom Hotkeys.exe"
  COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Chrome.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
  START "" "%dirpath%\Tools\Custom Hotkeys.exe"
  SETLOCAL ENABLEDELAYEDEXPANSION
  CALL :app_paths
  "%game%" "%dirpath%" "!browser!" "!instloc!" "!exefile!"
  ENDLOCAL
  ECHO.
  ECHO Closing "%game%"
  GOTO end
)
IF "%emu%"=="pc" (
  "%game%" "%dirpath%"
  ECHO.
  ECHO Closing "%game%"
  GOTO end
)
IF "%emu%"=="launcher" (
  "%game%" "%dirpath%"
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

:closing
ECHO.
ECHO Closing "%game%"

TASKKILL /im "Custom Hotkeys.exe" >NUL
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG" >NUL
START "" "%dirpath%\Tools\Custom Hotkeys.exe"
GOTO end

::==============
::Function Calls
::==============
:app_paths
  :default_browser
  FOR /f "usebackq tokens=*" %%a IN ("%dirpath%\Config\general_settings.ini") DO (
    FOR /f "tokens=1,2 delims==" %%b IN ('ECHO %%a') DO (
      IF "%%c"=="enabled" (
        IF "%%b"=="Mozilla Firefox" SET "browser=%%b" && SET "exefile=firefox.exe"
        IF "%%b"=="Google Chrome" SET "browser=%%b" && SET "exefile=chrome.exe"
      )
    )
  )
  IF "!browser!"=="Mozilla Firefox" SET "key=%key32%"
  IF NOT "!browser!"=="Mozilla Firefox" SET "key=%key64%"
  FOR /f "skip=1 tokens=*" %%d IN ('Reg query "!key!" /s /f "!browser!" /reg:64') DO if not defined line set "line=%%d"
  FOR /f "tokens=* delims= " %%e IN ('Reg query "!line!" /v InstallLocation /reg:64') DO set "instloc=%%e" 2>NUL 1>NUL
  SET instloc=%instloc:InstallLocation    REG_SZ    =%
  SET instloc=%instloc:"=%
  GOTO :eof

:end
ECHO Done
EXIT
