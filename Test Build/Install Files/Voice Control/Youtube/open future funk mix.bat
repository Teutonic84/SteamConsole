echo off
cls
cd "%~dp0%"
cd ..\..
SET dirpath=%cd%
SET "key=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
IF EXIST "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt" del /q /s "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt"

:app_path
FOR /f "skip=1 tokens=*" %%a IN ('REG QUERY "%key%" /s /f "Google Chrome"') DO if not defined line SET "line=%%a" 2>NUL 1>NUL
FOR /f "tokens=* delims= " %%c IN ('REG QUERY "%line%" /v InstallLocation') DO SET "instloc=%%c" 2>NUL 1>NUL
SET instloc=%instloc:InstallLocation    REG_SZ    =%
SET instloc=%instloc:"=%

START "" "%instloc%\chrome.exe" "https://www.youtube.com/watch?v=w-NXWQ9QZwo&list=PLz3hFb6Llk6goWQ4glpuyD52r9jPRsGmj&t=427s&index=1"

EXIT
