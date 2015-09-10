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
::start /d "C:\Program Files\Mumble" mumble.exe "mumble://Kloe Fluffypaws:kitty22@mumble.snoopsec.com:50021"
start /d "C:\Program Files (x86)\Steam" steam.exe "steam://rungameid/39210"
"C:\Program Files\Mumble\mumble.exe" "mumble://Kloe Fluffypaws:kitty22@mumble.snoopsec.com:50021"

::"%dirpath%\Tools\Xpadder\xpadder.exe" /C
::start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"

exit
