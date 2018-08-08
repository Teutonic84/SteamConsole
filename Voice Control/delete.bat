echo off

:loop
IF EXIST "C:\Users\User\Dropbox\controlcomputer\controlfile.txt" del /q /s "C:\Users\User\Dropbox\controlcomputer\controlfile.txt"
ping localhost -n 3 >NUL
GOTO loop

exit