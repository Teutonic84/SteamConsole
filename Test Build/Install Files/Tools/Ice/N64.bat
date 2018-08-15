@echo off

set dirpath=%~1
echo.
echo ===============
echo Start N64:
echo ===============

::=====================
::| Start ROM Renamer |
::=====================
for /f "tokens=* delims=" %%a in ('dir /b "%dirpath%\Emulators\ROMS\N64\*.*" 2^>NUL') do (
    call :check "%%a"
)
goto renamer

:check
    set "oldname=%~1"
    set "extension=%~x1"
    set "newname=%~n1"
    if "%newname%"=="" goto :eof
    setlocal enabledelayedexpansion
    set newname=!newname:.=!
    set newname=!newname:_= !
    for /f "usebackq tokens=1 delims=(" %%f in ('"!newname!"') do (
        set "newname=%%~nf"
        for /f usebackq^ tokens^=1^ delims^=^[^" %%b in ('"%%f"') do (
            set "newname=%%~nb"
            for /f "tokens=* delims= " %%d in ('echo "!newname!"') do (
                set "newname=%%~d%"
                move /Y "%dirpath%\Emulators\ROMS\N64\!oldname!" "%dirpath%\Emulators\ROMS\N64\!newname!!extension!" 2>NUL 1>NUL
                endlocal
            )
        )
    )
goto :eof

::===================
::| End ROM Renamer |
::===================
:renamer
::cls
setlocal EnableDelayedExpansion

::Delete all batch files in ROMS folder before running the rest of the batch file
for /f "tokens=* delims=" %%A in ('dir /b /s "%dirpath%\Steam_Shortcuts\N64\*.bat" 2^>NUL') do (
    del /F /Q "%%A"
)
::cls

::Create ROM List
for /f "tokens=* delims=" %%F in ('dir /b "%dirpath%\Emulators\ROMS\N64\*.n64" 2^>NUL') do (
    echo %%F>>"%dirpath%\Tools\Ice\ROMS.txt"
)
for /f "tokens=* delims=" %%F in ('dir /b "%dirpath%\Emulators\ROMS\N64\*.v64" 2^>NUL') do (
    echo %%F>>"%dirpath%\Tools\Ice\ROMS.txt"
)
for /f "tokens=* delims=" %%F in ('dir /b "%dirpath%\Emulators\ROMS\N64\*.z64" 2^>NUL') do (
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
set new=Project64
set new2=mupen64plus
set new3=N64
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
    echo %%M
    for /f "tokens=* delims=" %%L in ( 'Type "%OutputFile%"') do (
    set str=%%L
    set str=!str:%old4%=%%M!
    echo !str!>>"%dirpath%\Steam_Shortcuts\N64\%%M.bat"
    )
)

set "Pattern=.n64"
set "Pattern2=.v64"
set "Pattern3=.z64"
set "Replace="

For %%# in ("%dirpath%\Steam_Shortcuts\N64\*.bat") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
For %%# in ("%dirpath%\Steam_Shortcuts\N64\*.bat") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern2%=%Replace%!"
)
For %%# in ("%dirpath%\Steam_Shortcuts\N64\*.bat") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern3%=%Replace%!"
)

del /F /Q "%dirpath%\Scripts\ROM_Shortcut_Blank_Temp.bat" 2>NUL 1>NUL
del /F /Q "%dirpath%\Tools\Ice\ROMS.txt" 2>NUL 1>NUL

:end
goto :eof