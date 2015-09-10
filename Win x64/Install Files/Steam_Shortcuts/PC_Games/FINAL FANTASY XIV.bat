echo off

cd ..\..
set dirpath=%cd%

if exist "C:\Program Files (x86)" (
    set "programfiles=C:\Program Files (x86)"
)
if not exist "C:\Program Files (x86)" (
    set "programfiles=C:\Program Files"
)

start /d "C:\Program Files (x86)\Steam" steam.exe "steam://rungameid/39210"
"C:\Program Files\Mumble\mumble.exe" "mumble://User:Password@SERVER_ADDRESS:PORT"

exit
