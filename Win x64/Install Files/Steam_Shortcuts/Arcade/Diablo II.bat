echo off

cd ..\..
set dirpath=%cd%

if exist "C:\Program Files (x86)" (
    set "programfiles=C:\Program Files (x86)"
)
if not exist "C:\Program Files (x86)" (
    set "programfiles=C:\Program Files"
)

::start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Diablo3_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Diablo3_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Diablo3_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Diablo3_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Diablo3_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Diablo3_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Diablo3_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Diablo3_Xbox360.xpadderprofile"

"C:\Program Files (x86)\Diablo II\Diablo II.exe"

::start "" "%dirpath%\Tools\Xpadder\xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"

:end
exit