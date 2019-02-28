ECHO off

cd "%~dp0%"
cd ..\..\..
SET "dirpath=%cd%"
SET "key=HKCU\SOFTWARE\Plex, Inc.\Plex Media Player"
SET "key2=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Plex Home Theater"

:app_path
FOR /f "tokens=* delims= " %%a IN ('Reg query "%key%" /v InstallFolder') DO SET "instloc=%%a" 2>NUL 1>NUL
SET instloc=%instloc:InstallFolder    REG_SZ    =%
SET instloc=%instloc:"=%
FOR /f "tokens=* delims= " %%b IN ('Reg query "%key2%" /v DisplayIcon') DO SET "instloc2=%%b" 2>NUL 1>NUL
SET instloc2=%instloc2:DisplayIcon    REG_SZ    =%
SET instloc2=%instloc2:"=%

IF EXIST "%instloc%" "%instloc%\PlexMediaPlayer.exe"
IF EXIST "%instloc2%" "%instloc2%\Plex Home Theater.exe"

:end
EXIT
