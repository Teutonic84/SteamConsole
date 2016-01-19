echo off

cd ..\..
set dirpath=%cd%

if exist "C:\Program Files (x86)" (
    set "programfiles=C:\Program Files (x86)"
)
if not exist "C:\Program Files (x86)" (
    set "programfiles=C:\Program Files"
)

::start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\Chrome_Xbox360.xpadderprofile"
"C:\Program Files (x86)\PlexMediaPlayer\PlexMediaPlayer.exe"

::"%dirpath%\Tools\Xpadder\xpadder.exe" /C
::start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"

exit
