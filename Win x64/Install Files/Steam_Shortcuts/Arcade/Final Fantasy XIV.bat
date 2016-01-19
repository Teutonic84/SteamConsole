echo off

cd ..\..
set dirpath=%cd%

:steampath
if exist "%dirpath%\steam_path.txt" del "%dirpath%\steam_path.txt"
cscript.exe "%dirpath%\Scripts\steam_path_check.vbs" > "%dirpath%\steam_path.txt"
for /F "usebackq delims=" %%i in ("%dirpath%\steam_path.txt") do set "steampath=%%i"

start /d "%steampath%" steam.exe "steam://rungameid/39210"

exit
