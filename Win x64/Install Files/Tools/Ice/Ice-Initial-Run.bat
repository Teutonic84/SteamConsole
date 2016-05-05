@echo off

tasklist /FI "IMAGENAME eq steam.exe" 2>NUL | find /I /N "steam.exe">NUL
if "%ERRORLEVEL%"=="0" taskkill /f /im steam.exe

cls
cd ..\..
set dirpath=%cd%

if exist "%dirpath%\steam_path.txt" del "%dirpath%\steam_path.txt"
cscript.exe "%dirpath%\Scripts\steam_path_check.vbs" > "%dirpath%\steam_path.txt"
for /F "usebackq delims=" %%i in ("%dirpath%\steam_path.txt") do set "steampath=%%i"

cd "%dirpath%\Tools\Ice"
if not exist "%userprofile%\AppData\Local\Scott Rice" (
    mkdir "%userprofile%\AppData\Local\Scott Rice"
    mkdir "%userprofile%\AppData\Local\Scott Rice\Ice"
)

if exist "%steampath%\userdata\anonymous" (
    rmdir /q /s "%steampath%\userdata\anonymous"
)

start "" /WAIT Gamecube.bat
start "" /WAIT GBA.bat
start "" /WAIT N64.bat
start "" /WAIT NDS.bat
start "" /WAIT NES.bat
start "" /WAIT PC.bat
start "" /WAIT PS1.bat
start "" /WAIT PS2.bat
start "" /WAIT PSP.bat
start "" /WAIT SEGA.bat
start "" /WAIT SMS.bat
start "" /WAIT SNES.bat
start "" /WAIT Wii.bat

::**************************************************************************************************||
::**************************************************************************************************||
::--------------------------------------------------------------------------------------------------||
::**************************************************************************************************||
::**************************************************************************************************||

::===========================
::|       config.txt        |
::===========================

setlocal DisableDelayedExpansion

:Variables
set "InputFile=%dirpath%\Tools\Ice\config.txt"
set "OutputFile=%dirpath%\Tools\Ice\config-new.txt"
set "_strFind=ROMs Directory="
set "_strInsert=ROMS Directory=%dirpath%\Steam_Shortcuts"

:Replace
>"%OutputFile%" (
  for /f "usebackq delims=" %%A in ("%InputFile%") do (
    if "%%A" equ "%_strFind%" (echo %_strInsert%) else (echo %%A)
  )
)

del /F /Q "%dirpath%\Tools\Ice\config.txt"
rename "%dirpath%\Tools\Ice\config-new.txt" config.txt

::===========================
::|      emulators.txt      |
::===========================

::Nintendo DS
::===========

:Variables_nds
set nds=%dirpath%\Steam_Shortcuts\DS\DS
set InputFile2=%dirpath%\Tools\Ice\emulators.txt
set OutputFile2=%dirpath%\Tools\Ice\emulators-new.txt
set "_strFind2=location=DS"
set "_strInsert2=location=%nds%"

:Replace_nds
>"%OutputFile2%" (
  for /f "usebackq delims=" %%B in ("%InputFile2%") do (
    if "%%B" equ "%_strFind2%" (echo %_strInsert2%) else (echo %%B)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

::Gameboy Advance
::===============

:Variables_gba
set gba=%dirpath%\Steam_Shortcuts\GBA\GBA
set InputFile3=%dirpath%\Tools\Ice\emulators.txt
set OutputFile3=%dirpath%\Tools\Ice\emulators-new.txt
set "_strFind3=location=GBA"
set "_strInsert3=location=%gba%"

:Replace_gba
>"%OutputFile3%" (
  for /f "usebackq delims=" %%C in ("%InputFile3%") do (
    if "%%C" equ "%_strFind3%" (echo %_strInsert3%) else (echo %%C)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

::Nintendo 64
::===========

:Variables_n64
set n64=%dirpath%\Steam_Shortcuts\N64\N64
set InputFile4=%dirpath%\Tools\Ice\emulators.txt
set OutputFile4=%dirpath%\Tools\Ice\emulators-new.txt
set "_strFind4=location=N64"
set "_strInsert4=location=%n64%"

:Replace_n64
>"%OutputFile4%" (
  for /f "usebackq delims=" %%D in ("%InputFile4%") do (
    if "%%D" equ "%_strFind4%" (echo %_strInsert4%) else (echo %%D)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

::NES
::===

:Variables_nes
set nes=%dirpath%\Steam_Shortcuts\NES\NES
set InputFile5=%dirpath%\Tools\Ice\emulators.txt
set OutputFile5=%dirpath%\Tools\Ice\emulators-new.txt
set "_strFind5=location=NES"
set "_strInsert5=location=%nes%"

:Replace_nes
>"%OutputFile5%" (
  for /f "usebackq delims=" %%E in ("%InputFile5%") do (
    if "%%E" equ "%_strFind5%" (echo %_strInsert5%) else (echo %%E)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

::SNES
::====

:Variables_snes
set snes=%dirpath%\Steam_Shortcuts\SNES\SNES
set InputFile6=%dirpath%\Tools\Ice\emulators.txt
set OutputFile6=%dirpath%\Tools\Ice\emulators-new.txt
set "_strFind6=location=SNES"
set "_strInsert6=location=%snes%"

:Replace_snes
>"%OutputFile6%" (
  for /f "usebackq delims=" %%F in ("%InputFile6%") do (
    if "%%F" equ "%_strFind6%" (echo %_strInsert6%) else (echo %%F)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

::PSP
::===

:Variables_psp
set psp=%dirpath%\Steam_Shortcuts\PSP\PSP
set InputFile7=%dirpath%\Tools\Ice\emulators.txt
set OutputFile7=%dirpath%\Tools\Ice\emulators-new.txt
set "_strFind7=location=PSP"
set "_strInsert7=location=%psp%"

:Replace_psp
>"%OutputFile7%" (
  for /f "usebackq delims=" %%G in ("%InputFile7%") do (
    if "%%G" equ "%_strFind7%" (echo %_strInsert7%) else (echo %%G)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

::SEGA Genesis
::============

:Variables_sega
set sega=%dirpath%\Steam_Shortcuts\Genesis\Genesis
set InputFile8=%dirpath%\Tools\Ice\emulators.txt
set OutputFile8=%dirpath%\Tools\Ice\emulators-new.txt
set "_strFind8=location=Genesis"
set "_strInsert8=location=%sega%"

:Replace_sega
>"%OutputFile8%" (
  for /f "usebackq delims=" %%H in ("%InputFile8%") do (
    if "%%H" equ "%_strFind8%" (echo %_strInsert8%) else (echo %%H)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

::SEGA SMS
::============

:Variables_sms
set sms=%dirpath%\Steam_Shortcuts\SMS\SMS
set InputFile14=%dirpath%\Tools\Ice\emulators.txt
set OutputFile14=%dirpath%\Tools\Ice\emulators-new.txt
set "_strFind14=location=SMS"
set "_strInsert14=location=%sms%"

:Replace_sms
>"%OutputFile14%" (
  for /f "usebackq delims=" %%O in ("%InputFile14%") do (
    if "%%O" equ "%_strFind14%" (echo %_strInsert14%) else (echo %%O)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

::PC Apps & Games
::============

:Variables_pc
set "pc=%dirpath%\Steam_Shortcuts\Arcade\Arcade"
set "pcimage=%dirpath%\Images\Steam_Grid_Images"
set "InputFile9=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile9=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile92=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile92=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind9=location=PC"
set "_strFind92=images directory=pc-image"
set "_strInsert9=location=%pc%"
set "_strInsert92=images directory=%pcimage%"

:Replace_pc
>"%OutputFile9%" (
  for /f "usebackq delims=" %%I in ("%InputFile9%") do (
    if "%%I" equ "%_strFind9%" (echo %_strInsert9%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_pc2
>"%OutputFile92%" (
  for /f "usebackq delims=" %%I in ("%InputFile92%") do (
    if "%%I" equ "%_strFind92%" (echo %_strInsert92%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::Gamecube
::============

:Variables_gamecube
set gamecube=%dirpath%\Steam_Shortcuts\Gamecube\Gamecube
set InputFile10=%dirpath%\Tools\Ice\emulators.txt
set OutputFile10=%dirpath%\Tools\Ice\emulators-new.txt
set "_strFind10=location=Gamecube"
set "_strInsert10=location=%gamecube%"

:Replace_gamecube
>"%OutputFile10%" (
  for /f "usebackq delims=" %%J in ("%InputFile10%") do (
    if "%%J" equ "%_strFind10%" (echo %_strInsert10%) else (echo %%J)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

::Wii
::============

:Variables_gamecube
set wii=%dirpath%\Steam_Shortcuts\Wii\Wii
set InputFile11=%dirpath%\Tools\Ice\emulators.txt
set OutputFile11=%dirpath%\Tools\Ice\emulators-new.txt
set "_strFind11=location=Wii"
set "_strInsert11=location=%wii%"

:Replace_wii
>"%OutputFile11%" (
  for /f "usebackq delims=" %%K in ("%InputFile11%") do (
    if "%%K" equ "%_strFind11%" (echo %_strInsert11%) else (echo %%K)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

::PS1
::============

:Variables_ps1
set ps1=%dirpath%\Steam_Shortcuts\PS1\PS1
set InputFile12=%dirpath%\Tools\Ice\emulators.txt
set OutputFile12=%dirpath%\Tools\Ice\emulators-new.txt
set "_strFind12=location=PS1"
set "_strInsert12=location=%ps1%"

:Replace_ps1
>"%OutputFile12%" (
  for /f "usebackq delims=" %%L in ("%InputFile12%") do (
    if "%%L" equ "%_strFind12%" (echo %_strInsert12%) else (echo %%L)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

::PS2
::============

:Variables_ps2
set ps2=%dirpath%\Steam_Shortcuts\PS2\PS2
set InputFile13=%dirpath%\Tools\Ice\emulators.txt
set OutputFile13=%dirpath%\Tools\Ice\emulators-new.txt
set "_strFind13=location=PS2"
set "_strInsert13=location=%ps2%"

:Replace_ps2
>"%OutputFile13%" (
  for /f "usebackq delims=" %%M in ("%InputFile13%") do (
    if "%%M" equ "%_strFind13%" (echo %_strInsert13%) else (echo %%M)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt
del /F /Q "%dirpath%\steam_path.txt"

::"%dirpath%\Tools\Ice\ice.exe"

::del /F /Q "%dirpath%\Tools\Ice\config.txt"
::copy /Y "%dirpath%\Tools\Ice\config_blank.txt" "%dirpath%\Tools\Ice\config.txt"
::del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
::copy /Y "%dirpath%\Tools\Ice\emulators_blank.txt" "%dirpath%\Tools\Ice\emulators.txt"

:end
goto :eof