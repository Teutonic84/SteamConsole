echo off

cd "%~dp0%"
cd ..\..\..
set "dirpath=%cd%"
set "key=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

taskkill /im "Custom Hotkeys.exe"
copy /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - Chrome.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

:app_path
for /f "skip=1 tokens=*" %%a IN ('Reg query "%key%" /s /f "Google Chrome"') DO if not defined line set "line=%%a" 2>NUL 1>NUL
for /f "tokens=* delims= " %%c IN ('Reg query "%line%" /v InstallLocation') DO set "instloc=%%c" 2>NUL 1>NUL
set instloc=%instloc:InstallLocation    REG_SZ    =%
set instloc=%instloc:"=%

"%instloc%\chrome.exe" --kiosk "http://www.amctv.com/full-episodes/#"

taskkill /im "Custom Hotkeys.exe"
copy /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

exit