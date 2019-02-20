ECHO off
cls
cd "%~dp0%"
cd ..\..
SET dirpath=%cd%
SET "key=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

IF EXIST "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt" del /q /s "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt"

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - Chrome.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

:app_path
FOR /f "skip=1 tokens=*" %%a IN ('REG QUERY "%key%" /s /f "Google Chrome"') DO if not defined line SET "line=%%a" 2>NUL 1>NUL
FOR /f "tokens=* delims= " %%c IN ('REG QUERY "%line%" /v InstallLocation') DO SET "instloc=%%c" 2>NUL 1>NUL
SET instloc=%instloc:InstallLocation    REG_SZ    =%
SET instloc=%instloc:"=%

"%instloc%\chrome.exe" --kiosk "https://www.youtube.com/user/animefreak61/playlists?view=1&shelf_id=0&sort=dd"

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

EXIT
