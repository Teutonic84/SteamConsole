@echo off

set dirpath=%~1
echo.
echo ===============
echo Start PS1:
echo ===============

::=====================
::| Start ROM Renamer |
::=====================

del /q "%dirpath%\Emulators\ROMS\PS1\*.cue" 2>NUL 1>NUL
for /f "tokens=* delims=" %%a in ('dir /b "%dirpath%\Emulators\ROMS\PS1\*.*" 2^>NUL') do (
    call :check "%%a"
)
goto renamer

:check
    set "oldname=%~1"
    set "extension=%~x1"
    set "newname=%~n1"
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
    if %errorlevel%==0 set "disc= - CD1"
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

    if "%extension%"==".mcr" goto :eof
    if "%extension%"==".srm" goto :eof
    if "%newname%"=="" goto :eof
    setlocal enabledelayedexpansion
    set newname=!newname:.=!
    set newname=!newname:_= !
    for /f "usebackq tokens=1 delims=(" %%f in ('"!newname!"') do (
        set "newname=%%~nf"
        for /f usebackq^ tokens^=1^ delims^=^[^" %%b in ('"%%f"') do (
            set "newname=%%~nb"
            for /f "usebackq tokens=* delims= " %%d in ('"!newname!"') do (
                set "newname=%%~d%disc%"
                move /Y "%dirpath%\Emulators\ROMS\PS1\!oldname!" "%dirpath%\Emulators\ROMS\PS1\!newname!!extension!" 2>NUL 1>NUL
                copy /y "%dirpath%\Scripts\blank.cue" "%dirpath%\Emulators\ROMS\PS1\!newname!.cue" 2>NUL 1>NUL
                call :replace "%%~d%disc%"
                move /Y "%dirpath%\Emulators\ROMS\PS1\!newname!.cue.tmp" "%dirpath%\Emulators\ROMS\PS1\!newname!.cue" 2>NUL 1>NUL
                endlocal
            )
        )
    )
goto :eof

:replace
set "name=%~1"
set "replace=ROM"
echo %name%

setlocal enabledelayedexpansion
for /f "tokens=* delims=" %%i in ('type "%dirpath%\Emulators\ROMS\PS1\%name%.cue" 2^>NUL') do (
    set str=%%i
    set str=!str:%replace%=%name%.bin!
    echo(!str!>>"%dirpath%\Emulators\ROMS\PS1\%name%.cue.tmp"
    endlocal
)
goto :eof

::===================
::| End ROM Renamer |
::===================
:renamer
::cls
setlocal EnableDelayedExpansion

::Delete all batch files in ROMS folder before running the rest of the batch file
for /f "tokens=* delims=" %%A in ('dir /b /s "%dirpath%\Steam_Shortcuts\PS1\*.bat" 2^>NUL') do (
    del /F /Q "%%A"
)
::cls

::Create ROM List
for /f "tokens=* delims=" %%F in ('dir /b "%dirpath%\Emulators\ROMS\PS1\*.img" 2^>NUL') do (
    echo %%F>>"%dirpath%\Tools\Ice\ROMS.txt"
)
for /f "tokens=* delims=" %%F in ('dir /b "%dirpath%\Emulators\ROMS\PS1\*.cue" 2^>NUL') do (
    echo %%F>>"%dirpath%\Tools\Ice\ROMS.txt"
)
::cls
::Create batch files from ROMS.txt list
set "InputFile=%dirpath%\Scripts\ROM_Shortcut_Blank.bat"
set "OutputFile=%dirpath%\Scripts\ROM_Shortcut_Blank_Temp.bat"
set "OutputFile2=%dirpath%\Scripts\ROM_Shortcut_Blank_Temp2.bat"
set "OutputFile3=%dirpath%\Scripts\ROM_Shortcut_Blank_Temp3.bat"
set old=CONSOLE
set old2=CONFIGFILE
set old3=CONGEN
set old4=ROMFILE
set new=ePSXe
::set new2=PS1\ePSXe\ps1.lnk" -nogui -loadiso
set new2=mednafen_psx
set new3=PS1
set "romlist=%dirpath%\Tools\Ice\ROMS.txt"

for /f "tokens=* delims=" %%i in ( 'Type "%InputFile%"') do (
    set str=%%i
    set str=!str:%old%=%new%!
    echo(!str!>>"%OutputFile%"
)
for /f "tokens=* delims=" %%j in ( 'Type "%OutputFile%"') do (
    set str=%%j
    set str=!str:%old2%=%new2%!
    echo(!str!>>"%OutputFile2%"
)
for /f "tokens=* delims=" %%k in ( 'Type "%OutputFile2%"') do (
    set str=%%k
    set str=!str:%old3%=%new3%!
    echo(!str!>>"%OutputFile3%"
)
del /F /Q "%OutputFile%"
del /F /Q "%OutputFile2%"
rename "%OutputFile3%" "ROM_Shortcut_Blank_Temp.bat"

for /f "tokens=* delims=" %%M in ('Type "%romlist%" 2^>NUL') do (
    set "name=%%~nM"
    for /f "tokens=* delims=" %%L in ( 'Type "%OutputFile%"') do (
    set str=%%L
    set str=!str:%old4%=%%M!
    echo !str!>>"%dirpath%\Steam_Shortcuts\PS1\!name!.bat"
    )
)

::set "Pattern=.img"
::set "Pattern2=.bin"
::set "Pattern3=.cue"
::set "Replace="

::For %%# in ("%dirpath%\Steam_Shortcuts\PS1\*.bat") Do (
    ::Set "File=%%~nx#"
    ::Ren "%%#" "!File:%Pattern%=%Replace%!"
::)
::For %%# in ("%dirpath%\Steam_Shortcuts\PS1\*.bat") Do (
    ::Set "File=%%~nx#"
    ::Ren "%%#" "!File:%Pattern2%=%Replace%!"
::)

del /F /Q "%dirpath%\Scripts\ROM_Shortcut_Blank_Temp.bat" 2>NUL 1>NUL
del /F /Q "%dirpath%\Tools\Ice\ROMS.txt" 2>NUL 1>NUL
del /F /Q "%dirpath%\Emulators\ROMS\PS1\.cue" 2>NUL 1>NUL

:end
goto :eof