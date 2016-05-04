@echo off

::set dirpath=%1
cd ..\..
set dirpath=%cd%

::=====================
::| Start ROM Renamer |
::=====================
for /f "tokens=* delims=" %%a in ('dir /b "%dirpath%\Emulators\ROMS\SNES\*.*"') do (
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
                move /Y "%dirpath%\Emulators\ROMS\SNES\!oldname!" "%dirpath%\Emulators\ROMS\SNES\!newname!!extension!"
                endlocal
            )
        )
    )
goto :eof

::===================
::| End ROM Renamer |
::===================
:renamer
cls
setlocal EnableDelayedExpansion

::Delete all batch files in ROMS folder before running the rest of the batch file
for /f "tokens=* delims=" %%A in ('dir /b /s "%dirpath%\Steam_Shortcuts\SNES\*.bat"') do (
    del /F /Q "%%A"
)

::Create ROM List
for /f "tokens=* delims=" %%F in ('dir /b "%dirpath%\Emulators\ROMS\SNES\*.zip"') do (
    echo %%F>>"%dirpath%\Tools\Ice\ROMS.txt"
)
for /f "tokens=* delims=" %%F in ('dir /b "%dirpath%\Emulators\ROMS\SNES\*.sfc"') do (
    echo %%F>>"%dirpath%\Tools\Ice\ROMS.txt"
)
for /f "tokens=* delims=" %%F in ('dir /b "%dirpath%\Emulators\ROMS\SNES\*.smc"') do (
    echo %%F>>"%dirpath%\Tools\Ice\ROMS.txt"
)
cls
::Create batch files from ROMS.txt list
set "InputFile=%dirpath%\Scripts\ROM_Shortcut_Blank.bat"
set "OutputFile=%dirpath%\Scripts\ROM_Shortcut_Blank_Temp.bat"
set "OutputFile2=%dirpath%\Scripts\ROM_Shortcut_Blank_Temp2.bat"
set "OutputFile3=%dirpath%\Scripts\ROM_Shortcut_Blank_Temp3.bat"
set old=CONSOLE
set old2=CONFIGFILE
set old3=CONGEN
set old4=ROMFILE
set new=zsnes
set new2=snes9x
set new3=SNES
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

for /f "tokens=* delims=" %%M in ('Type "%romlist%"') do (
    echo %%M
    for /f "tokens=* delims=" %%L in ( 'Type "%OutputFile%"') do (
    set str=%%L
    set str=!str:%old4%=%%M!
    echo !str!>>"%dirpath%\Steam_Shortcuts\SNES\%%M.bat"
    )
)

Set "Pattern=.zip"
Set "Pattern2=.sfc"
Set "Pattern3=.smc"
Set "Replace="

For %%# in ("%dirpath%\Steam_Shortcuts\SNES\*.bat") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
For %%# in ("%dirpath%\Steam_Shortcuts\SNES\*.bat") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern2%=%Replace%!"
)
For %%# in ("%dirpath%\Steam_Shortcuts\SNES\*.bat") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern3%=%Replace%!"
)

del /F /Q "%dirpath%\Scripts\ROM_Shortcut_Blank_Temp.bat"
del /F /Q "%dirpath%\Tools\Ice\ROMS.txt"

:end
exit