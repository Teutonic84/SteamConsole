ECHO off

cd "%~dp0%"
cd ..\..\..
SET "dirpath=%cd%"
SET "key=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Chrome.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

:app_path
FOR /f "skip=1 tokens=*" %%a IN ('Reg query "%key%" /s /f "Google Chrome"') DO if not defined line set "line=%%a" 2>NUL 1>NUL
FOR /f "tokens=* delims= " %%c IN ('Reg query "%line%" /v InstallLocation') DO set "instloc=%%c" 2>NUL 1>NUL
SET instloc=%instloc:InstallLocation    REG_SZ    =%
SET instloc=%instloc:"=%

"%instloc%\chrome.exe" --kiosk "http://www.showtime.com/?i_cid=int-default-1010"

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

:end
EXIT