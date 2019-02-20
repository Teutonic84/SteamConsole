ECHO off
cls
cd "%~dp0%"
cd ..\..
SET dirpath=%cd%

::"D:\Games\Steam\steamapps\common\rocketleague\Binaries\Win32\RocketLeague.exe"
START "" "steam://rungameid/252950"

EXIT
