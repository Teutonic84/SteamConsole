ECHO off
cls

:loop
SET folder=
SET command=
SET command1=
SET game=

IF EXIST "C:\Users\User\Dropbox\controlcomputer\controlfile.txt" CALL :controlfile
IF EXIST "C:\Users\User\Dropbox\controlcomputer\search.txt" CALL :search

PING localhost -n 3 >NUL
GOTO loop

::----------
:: CALLS
::----------
:controlfile
FOR /f "usebackq tokens=1,2 delims= " %%a IN ("C:\Users\User\Dropbox\controlcomputer\controlfile.txt") DO (
    SET "folder=%%a"
    SET "command1=%%b"
)
FOR /f "usebackq tokens=2 delims=[]" %%a IN ("C:\Users\User\Dropbox\controlcomputer\controlfile.txt") DO (
    IF "%folder%"=="Games" (
        SET "game=%%a"
        GOTO games
    )
    SET "command=%command1% %%a"
)

ECHO.
ECHO folder= %folder%
ECHO command= %command%

IF EXIST "C:\Users\User\Dropbox\controlcomputer\controlfile.txt" DEL /q /s "C:\Users\User\Dropbox\controlcomputer\controlfile.txt"
IF "%command%"=="" (
    ECHO.
    ECHO Command not found. Check IFTTT Applet.
    GOTO :eof
)
ECHO.
ECHO Running ..\%folder%\%command%.bat
START "" "C:\SpartanController\batch files\%folder%\%command%.bat"
ECHO Done
GOTO :eof

:search
SET /P searchstring=<"C:\Users\User\Dropbox\controlcomputer\search.txt"
IF EXIST "C:\Users\User\Dropbox\controlcomputer\search.txt" DEL /q /s "C:\Users\User\Dropbox\controlcomputer\search.txt"

START "" CALL "C:\SpartanController\batch files\Commands\search.bat" "%searchstring%"
GOTO :eof

:games
SET "scpath=C:\SteamConsole\Steam_Shortcuts"
IF EXIST "C:\Users\User\Dropbox\controlcomputer\controlfile.txt" DEL /q /s "C:\Users\User\Dropbox\controlcomputer\controlfile.txt"
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
    START "" "C:\SpartanController\batch files\%folder%\%command1% %game%.bat"
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

