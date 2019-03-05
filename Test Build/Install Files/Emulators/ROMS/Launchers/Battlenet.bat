ECHO off

cd "%~dp0%"
cd ..\..\..
SET "dirpath=%cd%"
SET "key=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

:app_path
FOR /f "skip=1 tokens=*" %%a IN ('REG QUERY "%key%" /s /f "Battle.net"') DO IF NOT defined line SET "line=%%a" 2>NUL 1>NUL
FOR /f "tokens=* delims= " %%c IN ('REG QUERY "%line%" /v InstallLocation') DO SET "instloc=%%c" 2>NUL 1>NUL
SET instloc=%instloc:InstallLocation    REG_SZ    =%
SET instloc=%instloc:"=%

"%instloc%\Battle.net Launcher.exe"

:end
EXIT