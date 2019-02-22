echo off
cls
cd "%~dp0%"
cd ..\..
SET dirpath=%cd%
SET "key=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
SET "searchstring=%~1"

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Chrome.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

:app_path
FOR /f "skip=1 tokens=*" %%a IN ('REG QUERY "%key%" /s /f "Google Chrome"') DO if not defined line SET "line=%%a" 2>NUL 1>NUL
FOR /f "tokens=* delims= " %%c IN ('REG QUERY "%line%" /v InstallLocation') DO SET "instloc=%%c" 2>NUL 1>NUL
SET instloc=%instloc:InstallLocation    REG_SZ    =%
SET instloc=%instloc:"=%

"%instloc%\chrome.exe" "https://www.google.com/search?q=%searchstring%"

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

EXIT