ECHO off
cls
cd "%~dp0%"
cd ..
SET "dirpath=%cd%"
SET "scpath=%cd%\Emulators\ROMS"
cd "%~dp0%"

:loop
SET folder=
SET command=
SET command1=
SET game=

IF EXIST "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt" CALL :controlfile "%dirpath%" "%scpath%"
IF EXIST "%USERPROFILE%\Dropbox\controlcomputer\search.txt" CALL :search "%dirpath%" "%scpath%"

PING localhost -n 3 >NUL
GOTO loop

::----------
:: CALLS
::----------
:controlfile
SET "dirpath=%~1"
SET "scpath=%~2"

FOR /f "usebackq tokens=1,2 delims= " %%a IN ("%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt") DO (
    SET "folder=%%a"
    SET "command1=%%b"
)
FOR /f "usebackq tokens=2 delims=[]" %%a IN ("%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt") DO (
    IF "%folder%"=="Games" (
        SET "game=%%a"
        GOTO games
    )
    IF "%folder%"=="Apps" (
        SET "appname=%%a"
    )
    SET "command=%command1% %%a"
)

ECHO.
ECHO folder= %folder%
ECHO command= %command%

IF EXIST "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt" DEL /q /s "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt"
IF "%command%"=="" (
    ECHO.
    ECHO Command not found. Check IFTTT Applet.
    GOTO :eof
)

IF "%folder%"=="Apps" (
    ECHO.
    ECHO Running ..\Apps\%appname%.bat
    START "" "%scpath%\Apps\%appname%.bat"
    ECHO Done
    GOTO :eof
)
ECHO.
ECHO Running ..\%folder%\%command%.bat
START "" "%dirpath%\Voice Control\%folder%\%command%.bat"
ECHO Done
GOTO :eof

:search
SET "dirpath=%~1"
SET "scpath=%~2"

SET /P searchstring=<"%USERPROFILE%\Dropbox\controlcomputer\search.txt"
IF EXIST "%USERPROFILE%\Dropbox\controlcomputer\search.txt" DEL /q /s "%USERPROFILE%\Dropbox\controlcomputer\search.txt"

START "" CALL "%dirpath%\Voice Control\Commands\search.bat" "%searchstring%"
GOTO :eof

:games
IF EXIST "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt" DEL /q /s "%USERPROFILE%\Dropbox\controlcomputer\controlfile.txt"
IF "%game%"=="games DB" (
    START "" notepad games.db
    GOTO :eof
)

for /f "tokens=3,5,7,9 delims=[]" %%a in ('findstr /I /C:"[%game%]" games.db') do (
    SET "gamefile=%%a"
    SET "console=%%b"
    SET "type=%%c"
    SET "gpath=%%d"
)

IF NOT "%type%"=="RetroArch" (
    ECHO.
    ECHO folder= %folder%
    ECHO command= %command1% %game%

    IF "%command1%"=="" (
        ECHO.
        ECHO Command not found. Check IFTTT Applet.
        GOTO :eof
    )
    ECHO.
    ECHO Running ..\%folder%\%command1% %game%.bat
    START "" "%dirpath%\Voice Control\%folder%\%command1% %game%.bat"
    ECHO Done
    GOTO :eof
)

IF "%type%"=="RetroArch" (
    ECHO.
    ECHO folder= %console%
    ECHO command= %gamefile%

    ECHO.
    ECHO Running ..\%console%\%gamefile%.bat
    START "" "%scpath%\%console%\%gamefile%.bat"
    ECHO Done
    GOTO :eof
)
GOTO :eof

