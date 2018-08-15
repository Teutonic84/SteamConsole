@echo off

::cd ..\..
::set "dirpath=%cd%"
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
if exist "%dirpath%\Steam_Shortcuts\PC_Games\%name%.bat" (
    if exist "%dirpath%\Images\Steam_Grid_Images\PC_Games\%name%.jpg" (
        echo "%name%.bat" and Grid Image Already Exists>>"%dirpath%\Tools\Ice\pclog.txt"
        cls
        type "%dirpath%\Tools\Ice\pclog.txt"
        goto :eof
    )
    echo "%name%" - Downloading Grid Image...
    "%dirpath%\Scripts\Updater\wget.exe" --tries=3 --ftp-user=public --ftp-password="[anthakth15" --no-check-certificate --secure-protocol=auto -P "%dirpath%" "ftp://haackerit.duckdns.org/Grid_Images/PC_Games/%name%.jpg" 2>NUL 1>NUL
    move /y "%dirpath%\%name%.jpg" "%dirpath%\Images\Steam_Grid_Images\PC_Games\%name%.jpg"
    if errorlevel==0 (
        echo "%name%.bat" Already Exists and Grid Image Downloaded Successfully>>"%dirpath%\Tools\Ice\pclog.txt"
        cls
        type "%dirpath%\Tools\Ice\pclog.txt"    
        goto :eof
    )
    echo "%name%.bat" Already Exists and Grid Image Failed To Downloaded>>"%dirpath%\Tools\Ice\pclog.txt"
    cls
    type "%dirpath%\Tools\Ice\pclog.txt"    
    goto :eof
)

reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s /e /f "%name%"
cls
type "%dirpath%\Tools\Ice\pclog.txt"
echo "%name%" Searching...
if %errorlevel%==1 (
    echo "%name%" not found
    goto check64
)
if %errorlevel%==0 goto search
goto search

:check64
reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s /e /f "%name%"
cls
type "%dirpath%\Tools\Ice\pclog.txt"
echo "%name%" Searching...
if %errorlevel%==1 (
    echo "%name%" Not Found In System>>"%dirpath%\Tools\Ice\pclog.txt"
    cls
    type "%dirpath%\Tools\Ice\pclog.txt"
    goto :eof
)
if %errorlevel%==0 goto search

:search
for %%w in (C D E F G H I J K L) DO @if exist %%w: for /f "delims=" %%x in ('where /R %%w:\ "%~3"') do set "exepath=%%x"

if "%exepath%"=="" goto skip
if "%name%"=="Diablo III" goto special
set "InputFile=PC_Shortcut_Blank.bat"
setlocal enabledelayedexpansion
for /f "tokens=* delims=" %%i in ('Type "%dirpath%\Scripts\%InputFile%"') do (
    set str=%%i
    set str=!str:%old%=%name%!
    set str=!str:%old2%="%exepath%"!
    set str=!str:%old3%=%%d!
    echo !str!>>"%dirpath%\Scripts\temp\%name%.bat"
)
move /y "%dirpath%\Scripts\temp\%name%.bat" "%dirpath%\Steam_Shortcuts\PC_Games\%name%.bat" 2>NUL 1>NUL
if %errorlevel%==0 (
    if not exist "%dirpath%\Images\Steam_Grid_Images\PC_Games\%name%.jpg" (
        echo "%name%" - Downloading Grid Image...
        "%dirpath%\Scripts\Updater\wget.exe" --tries=3 --ftp-user=public --ftp-password="[anthakth15" --no-check-certificate --secure-protocol=auto -P "%dirpath%" "ftp://haackerit.duckdns.org/Grid_Images/PC_Games/%name%.jpg" 2>NUL 1>NUL
        move /y "%dirpath%\%name%.jpg" "%dirpath%\Images\Steam_Grid_Images\PC_Games\%name%.jpg"
        if %errorlevel%==0 (
            echo "%name%.bat" Created Successfully and Grid Image Downloaded>>"%dirpath%\Tools\Ice\pclog.txt"
            cls
            type "%dirpath%\Tools\Ice\pclog.txt"    
            goto :eof
        )
        echo "%name%.bat" Created Successfully and Grid Image Failed to Download>>"%dirpath%\Tools\Ice\pclog.txt"
        cls
        type "%dirpath%\Tools\Ice\pclog.txt"    
        goto :eof
    )
    echo "%name%.bat" Created Successfully and Grid Image Already Exists>>"%dirpath%\Tools\Ice\pclog.txt"
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
    set str=!str:%old%=%name%!
    set str=!str:%old2%="%%c"!
    set str=!str:%old3%=%%d!
    set str=!str:%old4%="%exefolder%"!
    echo !str!>>"%dirpath%\Scripts\temp\%name%.bat"
)
move /y "%dirpath%\Scripts\temp\%name%.bat" "%dirpath%\Steam_Shortcuts\PC_Games\%name%.bat" 2>NUL 1>NUL
if %errorlevel%==0 (
    if not exist "%dirpath%\Images\Steam_Grid_Images\PC_Games\%name%.jpg" (
        echo "%name%" - Downloading Grid Image...
        "%dirpath%\Scripts\Updater\wget.exe" --tries=3 --ftp-user=public --ftp-password="[anthakth15" --no-check-certificate --secure-protocol=auto -P "%dirpath%" "ftp://haackerit.duckdns.org/Grid_Images/PC_Games/%name%.jpg" 2>NUL 1>NUL
        move /y "%dirpath%\%name%.jpg" "%dirpath%\Images\Steam_Grid_Images\PC_Games\%name%.jpg"
        if %errorlevel%==0 (
            echo "%name%.bat" Created Successfully and Grid Image Downloaded>>"%dirpath%\Tools\Ice\pclog.txt"
            cls
            type "%dirpath%\Tools\Ice\pclog.txt"    
            goto :eof
        )
        echo "%name%.bat" Created Successfully and Grid Image Failed to Download>>"%dirpath%\Tools\Ice\pclog.txt"
        cls
        type "%dirpath%\Tools\Ice\pclog.txt"    
        goto :eof
    )
    echo "%name%.bat" Created Successfully and Grid Image Already Exists>>"%dirpath%\Tools\Ice\pclog.txt"
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
ping localhost -n 5 2>NUL 1>NUL
goto :eof