echo off

cd ..
set dirpath=%cd%
cls
start "" "%dirpath%\Tools\Xpadder\Xpadder.exe" /C

:end
exit