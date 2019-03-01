ECHO off

cd "%~dp0%"
cd ..\..\..
SET "dirpath=%cd%"
SET "key64=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
SET "key32=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Chrome.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

:app_path
FOR /f "usebackq tokens=*" %%a IN ("%dirpath%\Config\general_settings.ini") DO (
    FOR /f "tokens=1,2 delims==" %%b IN ('ECHO %%a') DO (
        IF "%%c"=="enabled" (
             IF "%%b"=="Mozilla Firefox" SET "browser=%%b" && SET "exefile=firefox.exe"
             IF "%%b"=="Google Chrome" SET "browser=%%b" && SET "exefile=chrome.exe"
        )
    )
)
IF "%browser%"=="Mozilla Firefox" SET "key=%key32%"
IF NOT "%browser%"=="Mozilla Firefox" SET "key=%key64%"
FOR /f "skip=1 tokens=*" %%d IN ('Reg query "%key%" /s /f "%browser%" /reg:64') DO if not defined line set "line=%%d"
FOR /f "tokens=* delims= " %%e IN ('Reg query "%line%" /v InstallLocation /reg:64') DO set "instloc=%%e" 2>NUL 1>NUL
SET instloc=%instloc:InstallLocation    REG_SZ    =%
SET instloc=%instloc:"=%

"%instloc%\%exefile%"

TASKKILL /im "Custom Hotkeys.exe"
COPY /y "%dirpath%\Tools\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Controller Maps\Controller Map.JPG"
START "" "%dirpath%\Tools\Custom Hotkeys.exe"

:end
EXIT