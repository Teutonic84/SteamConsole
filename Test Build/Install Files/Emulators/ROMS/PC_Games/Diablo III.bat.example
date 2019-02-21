ECHO off
cls
cd "%~dp0%"
cd ..\..\..
set "dirpath=%cd%"
set "key=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

:app_path
for /f "skip=1 tokens=*" %%a IN ('Reg query "%key%" /s /f "Diablo III"') DO if not defined line set "line=%%a" 2>NUL 1>NUL
for /f "tokens=* delims= " %%c IN ('Reg query "%line%" /v InstallLocation') DO set "instloc=%%c" 2>NUL 1>NUL
set instloc=%instloc:InstallLocation    REG_SZ    =%
set instloc=%instloc:"=%

cd "%instloc%\x64"
"Diablo III64.exe" -launch

:end
EXIT