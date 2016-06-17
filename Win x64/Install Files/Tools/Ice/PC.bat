@echo off

set "dirpath=%~1"
set old=GAMENAME
set old2=GAMEEXE
set old3=PARAMS
set old4=GAMEPATH
if not exist "%dirpath%\Scripts\temp" mkdir "%dirpath%\Scripts\temp"
if exist "%dirpath%\Tools\Ice\pclog.txt" del /q "%dirpath%\Tools\Ice\pclog.txt"

cls
echo.>>"%dirpath%\Tools\Ice\pclog.txt"
echo ===============>>"%dirpath%\Tools\Ice\pclog.txt"
echo Start PC:>>"%dirpath%\Tools\Ice\pclog.txt"
echo ===============>>"%dirpath%\Tools\Ice\pclog.txt"
type "%dirpath%\Tools\Ice\pclog.txt"

::Create batch files from GAMES.txt list
for /f "skip=1 tokens=1,3,4,5,6 delims=[]" %%a IN ('type "%dirpath%\Tools\Ice\GAMES.txt"') DO (
    call :checkreg "%%a" "%%b" "%%c" "%%d"
)
echo. >>"%dirpath%\Tools\Ice\pclog.txt"
echo Search Complete>>"%dirpath%\Tools\Ice\pclog.txt"
cls
type "%dirpath%\Tools\Ice\pclog.txt"
goto end

:checkreg
cls
type "%dirpath%\Tools\Ice\pclog.txt"
set "name=%~1"
set "name=%name::= -%"
set exepath=
echo "%name%" Searching...
if %~2==disable goto :eof

for %%w in (C D E F G H I J K L) DO @if exist %%w: for /f "delims=" %%x in ('where /R %%w:\ "%~3"') do set "exepath=%%x"

if "%exepath%"=="" goto skip
if "%name%"=="Diablo III" goto special
set "InputFile=PC_Shortcut_Blank.bat"
setlocal enabledelayedexpansion
for /f "tokens=* delims=" %%i in ('Type "%dirpath%\Scripts\%InputFile%"') do (
    set str=%%i
    set str=!str:%old%=%%a!
    set str=!str:%old2%="%exepath%"!
    set str=!str:%old3%=%%d!
    echo !str!>>"%dirpath%\Scripts\temp\%name%.bat"
)
move /y "%dirpath%\Scripts\temp\%name%.bat" "%dirpath%\Steam_Shortcuts\PC_Games\%name%.bat" 2>NUL 1>NUL
if %errorlevel%==0 (
    echo "%name%.bat" Created Successfully>>"%dirpath%\Tools\Ice\pclog.txt"
    cls
    type "%dirpath%\Tools\Ice\pclog.txt"
    goto :eof
)
echo "%name%.bat" Failed To Be Created>>"%dirpath%\Tools\Ice\pclog.txt"
cls
type "%dirpath%\Tools\Ice\pclog.txt"
goto :eof

:special
set "InputFile=PC_Shortcut_Blank_Run_From_GameDir.bat"
FOR %%k IN ("%exepath%") DO (
    set tmp1=%%~dk
    set tmp2=%%~pk
)
set "exefolder=%tmp1%%tmp2%"

setlocal enabledelayedexpansion
for /f "tokens=* delims=" %%i in ('Type "%dirpath%\Scripts\%InputFile%"') do (
    set str=%%i
    set str=!str:%old%=%%a!
    set str=!str:%old2%="%%c"!
    set str=!str:%old3%=%%d!
    set str=!str:%old4%="%exefolder%"!
    echo !str!>>"%dirpath%\Scripts\temp\%name%.bat"
)
move /y "%dirpath%\Scripts\temp\%name%.bat" "%dirpath%\Steam_Shortcuts\PC_Games\%name%.bat" 2>NUL 1>NUL
if %errorlevel%==0 (
    echo "%name%.bat" Created Successfully>>"%dirpath%\Tools\Ice\pclog.txt"
    cls
    type "%dirpath%\Tools\Ice\pclog.txt"
    goto :eof
)
echo "%name%.bat" Failed To Be Created>>"%dirpath%\Tools\Ice\pclog.txt"
cls
type "%dirpath%\Tools\Ice\pclog.txt"
goto :eof

:skip
echo "%name%" Not Found>>"%dirpath%\Tools\Ice\pclog.txt"
cls
type "%dirpath%\Tools\Ice\pclog.txt"
goto :eof

:end
rmdir /s /q "%dirpath%\Scripts\temp"
goto :eof