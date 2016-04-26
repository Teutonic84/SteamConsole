echo off
cls
cd ..\..
set dirpath=%cd%
set "regcheck=TMP"
if %regcheck%==64 set "key=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
if %regcheck%==32 set "key=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

::Grab Game EXE path from uninstall registry key with "DisplayIcon" value
::=======================================================================
:app_path
for /f "skip=1 tokens=*" %%a IN ('Reg query "%key%" /s /f "GAMENAME"') DO if not defined line set "line=%%a" 2>NUL 1>NUL
for /f "tokens=* delims= " %%c IN ('Reg query "%line%" /v DisplayIcon') DO set "instloc=%%c" 2>NUL 1>NUL
set instloc=%instloc:DisplayIcon    REG_SZ    =%

::Launch Game
::===========
:launch
if exist "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile"
"%instloc%" PARAMS
start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
:end
exit
