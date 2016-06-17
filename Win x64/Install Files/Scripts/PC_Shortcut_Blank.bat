echo off
cls
cd ..\..
set dirpath=%cd%

::Launch Game
::===========
:launch
if exist "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\GAMENAME.xpadderprofile"
GAMEEXE PARAMS
start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
:end
exit
