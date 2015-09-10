echo off

cd ..\..
set dirpath=%cd%

if exist "C:\Program Files (x86)" (
    set "programfiles=C:\Program Files (x86)"
)
if not exist "C:\Program Files (x86)" (
    set "programfiles=C:\Program Files"
)

::if %computername% == "Dans-Laptop" do (
    ::cd "Tools\Joy_to_Key\"
    ::start "" "JoyToKey.exe"
    ::cd "D:\Games\Diablo III"
    ::"Diablo III.exe" -launch
    ::cd %WINDIR%\system32
    ::taskkill.exe /f /im JoyToKey.exe
    ::goto end
::)

"%dirpath%\Tools\Xpadder\Xpadder.exe" /C

cd "%dirpath%\Tools\Joy_to_Key\"
start "" "JoyToKey.exe"

cd "%programfiles%\Diablo III"
"Diablo III.exe" -launch

:keymaps
cd %WINDIR%\system32
taskkill.exe /f /im JoyToKey.exe

start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"

:end
exit