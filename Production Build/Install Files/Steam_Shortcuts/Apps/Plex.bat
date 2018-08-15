echo off

cd "%~dp0%"
cd ..\..
set "dirpath=%cd%"
set "key=HKCU\SOFTWARE\Plex, Inc.\Plex Media Player"
set "key2=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Plex Home Theater"

taskkill /im "Custom Hotkeys.exe"
copy /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - Chrome.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

:app_path
for /f "tokens=* delims= " %%a IN ('Reg query "%key%" /v InstallFolder') DO set "instloc=%%a" 2>NUL 1>NUL
set instloc=%instloc:InstallFolder    REG_SZ    =%
set instloc=%instloc:"=%
for /f "tokens=* delims= " %%b IN ('Reg query "%key2%" /v DisplayIcon') DO set "instloc2=%%b" 2>NUL 1>NUL
set instloc2=%instloc2:DisplayIcon    REG_SZ    =%
set instloc2=%instloc2:"=%

"%dirpath%\Tools\Xpadder\xpadder.exe" /C
::start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
if exist "%instloc%" "%instloc%\PlexMediaPlayer.exe"
if exist "%instloc2%" "%instloc2%\Plex Home Theater.exe"

"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"

taskkill /im "Custom Hotkeys.exe"
copy /y "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map - Steam.JPG" "%dirpath%\Tools\Xpadder\Controller Maps\Controller Map.JPG"
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

exit
