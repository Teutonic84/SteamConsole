echo off
cls

set "key=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
IF EXIST "C:\Users\User\Dropbox\controlcomputer\controlfile.txt" del /q /s "C:\Users\User\Dropbox\controlcomputer\controlfile.txt"

:app_path
for /f "skip=1 tokens=*" %%a IN ('Reg query "%key%" /s /f "Google Chrome"') DO if not defined line set "line=%%a" 2>NUL 1>NUL
for /f "tokens=* delims= " %%c IN ('Reg query "%line%" /v InstallLocation') DO set "instloc=%%c" 2>NUL 1>NUL
set instloc=%instloc:InstallLocation    REG_SZ    =%
set instloc=%instloc:"=%

start "" "%instloc%\chrome.exe" "https://www.youtube.com/watch?v=eqzxBHSKVsQ&list=PLz3hFb6Llk6hsVgmhq1XsOuhIOEgO9Fol"

exit
