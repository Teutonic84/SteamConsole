echo off
cls
cd "%~dp0"
cd ..\..
set "dirpath=%cd%"

::Launch Game
::===========
:launch
if exist "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile"
cd GAMEPATH
GAMEEXE PARAMS
"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
:end
exit