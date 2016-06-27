echo off

cd ..\..
set "dirpath=%cd%"
set "key=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

:app_path
for /f "skip=1 tokens=*" %%a IN ('Reg query "%key%" /s /f "Nexus Mod Manager"') DO if not defined line set "line=%%a" 2>NUL 1>NUL
for /f "tokens=* delims= " %%c IN ('Reg query "%line%" /v InstallLocation') DO set "instloc=%%c" 2>NUL 1>NUL
set instloc=%instloc:InstallLocation    REG_SZ    =%
set instloc=%instloc:"=%

start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile"
start /MAX "" "%instloc%\NexusClient.exe"

:check
ping localhost -n 2 2>NUL 1>NUL
tasklist /FI "IMAGENAME eq NexusClient.exe" 2>NUL | find /I /N "NexusClient.exe">NUL
if "%ERRORLEVEL%"=="0" goto check

"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"

exit
