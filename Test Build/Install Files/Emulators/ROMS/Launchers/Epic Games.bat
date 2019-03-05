ECHO off

cd "%~dp0%"
cd ..\..\..
SET "dirpath=%cd%"
SET "key=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

:app_path
FOR /f "skip=1 tokens=*" %%a IN ('REG QUERY "%key%" /s /f "Epic Games Launcher"') DO IF NOT defined line SET "line=%%a" 2>NUL 1>NUL
FOR /f "tokens=* delims= " %%c IN ('REG QUERY "%line%" /v InstallLocation') DO SET "instloc=%%c" 2>NUL 1>NUL
SET instloc=%instloc:InstallLocation    REG_SZ    =%
SET instloc=%instloc:"=%

"%instloc%\Launcher\Engine\Binaries\Win64\EpicGamesLauncher.exe"

:end
EXIT