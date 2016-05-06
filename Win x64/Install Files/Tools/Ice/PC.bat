@echo off
echo Creating PC Game Batch Files...

cd ..\..
set dirpath=%cd%
set old=GAMENAME
set old2=PARAMS
set old3=TMP
set "key=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
set "key2=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

if not exist "%dirpath%\Scripts\temp" mkdir "%dirpath%\Scripts\temp"

::Create batch files from GAMES.txt list
for /f "skip=1 tokens=1,3,4,5,6 delims=[]" %%a IN ('type "%dirpath%\Tools\Ice\GAMES.txt"') DO (
    call :checkreg "%%a" "%%b" "%%c" "%%d" %%e
)
goto end

:checkreg
set "name=%~1"
set "name=%name::= -%"

if %~2==disable goto :eof
if %~3==custom set "InputFile=PC_Shortcut_Blank_Run_From_GameDir.bat"
if %~3==customexe set "InputFile=PC_Shortcut_Blank_Custom_Exe.bat"
if %~3==default set "InputFile=PC_Shortcut_Blank.bat"

Reg query "%key%" /s /f %1 2>NUL 1>NUL
if %errorlevel%==0 goto 64
Reg query "%key2%" /s /f %1 2>NUL 1>NUL
if %errorlevel%==0 goto 32
goto :eof

:64
setlocal EnableDelayedExpansion
if %4=="override" goto create64
for /f "skip=1 tokens=*" %%g IN ('Reg query "%key%" /s /f %1') DO if not defined line set "line=%%g" 2>NUL 1>NUL
    Reg query "%line%" | find "Steam App" 2>NUL 1>NUL
    if %errorlevel%==1 goto create64
    if %errorlevel%==0 goto :eof
)
:create64
for /f "tokens=* delims=" %%i in ('Type "%dirpath%\Scripts\%InputFile%"') do (
    set str=%%i
    set str=!str:%old%=%%a!
    set str=!str:%old2%=%%e!
    set str=!str:%old3%=64!
    echo !str!>>"%dirpath%\Scripts\temp\%name%.bat"
)
move /y "%dirpath%\Scripts\temp\%name%.bat" "%dirpath%\Steam_Shortcuts\PC_Games\%name%.bat" 2>NUL 1>NUL
if %errorlevel%==0 echo "%name%.bat" created
goto :eof

:32
setlocal EnableDelayedExpansion
if %4=="import override" goto create32
for /f "skip=1 tokens=*" %%g IN ('Reg query "%key2%" /s /f %1') DO if not defined line set "line=%%g" 2>NUL 1>NUL
    Reg query "%line%" | find "Steam App" 2>NUL 1>NUL
    if %errorlevel%==1 goto create32
    if %errorlevel%==0 goto :eof
)
:create32
for /f "tokens=* delims=" %%i in ('Type "%dirpath%\Scripts\%InputFile%"') do (
    set str=%%i
    set str=!str:%old%=%%a!
    set str=!str:%old2%=%%e!
    set str=!str:%old3%=32!
    echo !str!>>"%dirpath%\Scripts\temp\%name%.bat"
)
move /y "%dirpath%\Scripts\temp\%name%.bat" "%dirpath%\Steam_Shortcuts\PC_Games\%name%.bat" 2>NUL 1>NUL
if %errorlevel%==0 echo "%name%.bat" created
goto :eof

:end
rmdir /s /q "%dirpath%\Scripts\temp"
exit