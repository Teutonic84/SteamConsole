@echo off

SET "dirpath=%~1"
SET "platform=%~2"
cls
ECHO.
ECHO ===========================
ECHO Start %platform% ROM Renamer:
ECHO ===========================

for /f "tokens=* delims=" %%a in ('dir /b "%dirpath%\Emulators\ROMS\%platform%\*.*" 2^>NUL') do (
    call :check "%%a" %platform%
)

::===================
::| End ROM Renamer |
::===================
ECHO Done
ECHO.
PING localhost -n 4 >NUL
GOTO end

:check
    SET "platform=%~2"
    SET "oldname=%~1"
    SET "extension=%~x1"
    SET "newname=%~n1"
    SET "disc="
    ::Check for multiple disc games
    ::=============================
    echo."%newname%" | findstr /C:"Disc 1" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD1"
    echo."%newname%" | findstr /C:"Disc1" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD1"
    echo."%newname%" | findstr /C:"Disk 1" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD1"
    echo."%newname%" | findstr /C:"Disk1" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD1"
    echo."%newname%" | findstr /C:"CD 1" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD1"
    echo."%newname%" | findstr /C:"CD1" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD1"
    echo."%newname%" | findstr /C:" - CD1" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc="
    echo."%newname%" | findstr /C:"Disc 2" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD2"
    echo."%newname%" | findstr /C:"Disc2" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD2"
    echo."%newname%" | findstr /C:"Disk 2" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD2"
    echo."%newname%" | findstr /C:"Disk2" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD2"
    echo."%newname%" | findstr /C:"CD 2" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD2"
    echo."%newname%" | findstr /C:"CD2" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD2"
    echo."%newname%" | findstr /C:" - CD2" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc="
    echo."%newname%" | findstr /C:"Disc 3" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD3"
    echo."%newname%" | findstr /C:"Disc3" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD3"
    echo."%newname%" | findstr /C:"Disk 3" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD3"
    echo."%newname%" | findstr /C:"Disk3" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD3"
    echo."%newname%" | findstr /C:"CD 3" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD3"
    echo."%newname%" | findstr /C:"CD3" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD3"
    echo."%newname%" | findstr /C:" - CD3" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc="
    echo."%newname%" | findstr /C:"Disc 4" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD4"
    echo."%newname%" | findstr /C:"Disc4" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD4"
    echo."%newname%" | findstr /C:"Disk 4" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD4"
    echo."%newname%" | findstr /C:"Disk4" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD4"
    echo."%newname%" | findstr /C:"CD 4" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD4"
    echo."%newname%" | findstr /C:"CD4" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc= - CD4"
    echo."%newname%" | findstr /C:" - CD4" 2>NUL 1>NUL
    if %errorlevel%==0 set "disc="

    if "%newname%"=="" goto :eof
    setlocal enabledelayedexpansion
    set newname=!newname:.=!
    set newname=!newname:_= !
    for /f "usebackq tokens=1 delims=(" %%f in ('"!newname!"') do (
        set "newname=%%~nf"
        for /f usebackq^ tokens^=1^ delims^=^[^" %%b in ('"%%f"') do (
            set "newname=%%~nb"
            for /f "tokens=* delims= " %%d in ('echo "!newname!"') do (
                set "newname=%%~d%disc%"
                move /Y "%dirpath%\Emulators\ROMS\%platform%\!oldname!" "%dirpath%\Emulators\ROMS\%platform%\!newname!!extension!" 2>NUL 1>NUL
                ECHO !newname!!extension!
                endlocal
            )
        )
    )
    goto :eof

:end
