echo off

:loop
IF EXIST "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt" del /q /s "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt"
PING localhost -n 3 >NUL
GOTO loop

EXIT