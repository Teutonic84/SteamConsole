@echo off

tasklist /FI "IMAGENAME eq steam.exe" 2>NUL | find /I /N "steam.exe">NUL
if "%ERRORLEVEL%"=="0" taskkill /f /im steam.exe

cls
cd "%~dp0%"
cd ..\..
set "dirpath=%cd%"
cd "%dirpath%\Tools\Ice"

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

call "Gamecube.bat" "%dirpath%"
cls
call "GBA.bat" "%dirpath%"
cls
call "N64.bat" "%dirpath%"
cls
call "NDS.bat" "%dirpath%"
cls
call "NES.bat" "%dirpath%"
cls
call "PC.bat" "%dirpath%"
cls
call "PS1.bat" "%dirpath%"
cls
call "PS2.bat" "%dirpath%"
cls
call "PSP.bat" "%dirpath%"
cls
call "SEGA.bat" "%dirpath%"
cls
call "SMS.bat" "%dirpath%"
cls
call "SNES.bat" "%dirpath%"
cls
call "Wii.bat" "%dirpath%"

::**************************************************************************************************||
::**************************************************************************************************||
::--------------------------------------------------------------------------------------------------||
::**************************************************************************************************||
::**************************************************************************************************||

::===========================
::|       config.txt        |
::===========================

set steampath=%steampath:(=^^(%
set steampath=%steampath:)=^^)%
set "InputFile=%dirpath%\Tools\Ice\config.txt"
set "OutputFile=%dirpath%\Tools\Ice\config-new.txt"
set "_strFind=ROMs Directory="
set "_strInsert=ROMS Directory=%dirpath%\Steam_Shortcuts"
set "_strFind1=Userdata Directory="
set "_strInsert1=Userdata Directory=%steampath%\userdata"

:Replace
>"%OutputFile%" (
  for /f "usebackq delims=" %%A in ("%InputFile%") do (
    if "%%A" equ "%_strFind%" (echo %_strInsert%)
	if "%%A" equ "%_strFind1%" (echo %_strInsert1%)
	if not "%%A" equ "%_strFind%" (
		if not "%%A" equ "%_strFind1%" (echo %%A)
	)
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
set "nds=%dirpath%\Steam_Shortcuts\DS\DS"
set "dsimage=%dirpath%\Images\Steam_Grid_Images\DS"
set "InputFile2=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile2=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile22=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile22=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind2=location=DS"
set "_strFind22=images directory=ds-image"
set "_strInsert2=location=%nds%"
set "_strInsert22=images directory=%dsimage%"

:Replace_nds
>"%OutputFile2%" (
  for /f "usebackq delims=" %%B in ("%InputFile2%") do (
    if "%%B" equ "%_strFind2%" (echo %_strInsert2%) else (echo %%B)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_nds2
>"%OutputFile22%" (
  for /f "usebackq delims=" %%I in ("%InputFile22%") do (
    if "%%I" equ "%_strFind22%" (echo %_strInsert22%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::Gameboy Advance
::===============

:Variables_gba
set "gba=%dirpath%\Steam_Shortcuts\GBA\GBA"
set "gbaimage=%dirpath%\Images\Steam_Grid_Images\GBA"
set "InputFile3=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile3=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile32=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile32=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind3=location=GBA"
set "_strFind32=images directory=gba-image"
set "_strInsert3=location=%gba%"
set "_strInsert32=images directory=%gbaimage%"

:Replace_gba
>"%OutputFile3%" (
  for /f "usebackq delims=" %%B in ("%InputFile3%") do (
    if "%%B" equ "%_strFind3%" (echo %_strInsert3%) else (echo %%B)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_gba2
>"%OutputFile32%" (
  for /f "usebackq delims=" %%I in ("%InputFile32%") do (
    if "%%I" equ "%_strFind32%" (echo %_strInsert32%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::Nintendo 64
::===========

:Variables_n64
set "n64=%dirpath%\Steam_Shortcuts\N64\N64"
set "n64image=%dirpath%\Images\Steam_Grid_Images\N64"
set "InputFile4=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile4=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile42=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile42=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind4=location=N64"
set "_strFind42=images directory=n64-image"
set "_strInsert4=location=%n64%"
set "_strInsert42=images directory=%n64image%"

:Replace_n64
>"%OutputFile4%" (
  for /f "usebackq delims=" %%D in ("%InputFile4%") do (
    if "%%D" equ "%_strFind4%" (echo %_strInsert4%) else (echo %%D)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_n642
>"%OutputFile42%" (
  for /f "usebackq delims=" %%I in ("%InputFile42%") do (
    if "%%I" equ "%_strFind42%" (echo %_strInsert42%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::NES
::===

:Variables_nes
set "nes=%dirpath%\Steam_Shortcuts\NES\NES"
set "nesimage=%dirpath%\Images\Steam_Grid_Images\NES"
set "InputFile5=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile5=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile52=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile52=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind5=location=NES"
set "_strFind52=images directory=nes-image"
set "_strInsert5=location=%nes%"
set "_strInsert52=images directory=%nesimage%"

:Replace_nes
>"%OutputFile5%" (
  for /f "usebackq delims=" %%E in ("%InputFile5%") do (
    if "%%E" equ "%_strFind5%" (echo %_strInsert5%) else (echo %%E)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_nes2
>"%OutputFile52%" (
  for /f "usebackq delims=" %%I in ("%InputFile52%") do (
    if "%%I" equ "%_strFind52%" (echo %_strInsert52%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::SNES
::====

:Variables_snes
set "snes=%dirpath%\Steam_Shortcuts\SNES\SNES"
set "snesimage=%dirpath%\Images\Steam_Grid_Images\SNES"
set "InputFile6=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile6=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile62=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile62=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind6=location=SNES"
set "_strFind62=images directory=snes-image"
set "_strInsert6=location=%snes%"
set "_strInsert62=images directory=%snesimage%"

:Replace_snes
>"%OutputFile6%" (
  for /f "usebackq delims=" %%F in ("%InputFile6%") do (
    if "%%F" equ "%_strFind6%" (echo %_strInsert6%) else (echo %%F)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_snes2
>"%OutputFile62%" (
  for /f "usebackq delims=" %%I in ("%InputFile62%") do (
    if "%%I" equ "%_strFind62%" (echo %_strInsert62%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::PSP
::===

:Variables_psp
set "psp=%dirpath%\Steam_Shortcuts\PSP\PSP"
set "pspimage=%dirpath%\Images\Steam_Grid_Images\PSP"
set "InputFile7=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile7=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile72=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile72=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind7=location=PSP"
set "_strFind72=images directory=psp-image"
set "_strInsert7=location=%psp%"
set "_strInsert72=images directory=%pspimage%"

:Replace_psp
>"%OutputFile7%" (
  for /f "usebackq delims=" %%G in ("%InputFile7%") do (
    if "%%G" equ "%_strFind7%" (echo %_strInsert7%) else (echo %%G)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_psp2
>"%OutputFile72%" (
  for /f "usebackq delims=" %%I in ("%InputFile72%") do (
    if "%%I" equ "%_strFind72%" (echo %_strInsert72%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::SEGA Genesis
::============

:Variables_sega
set "sega=%dirpath%\Steam_Shortcuts\Genesis\Genesis"
set "segaimage=%dirpath%\Images\Steam_Grid_Images\Genesis"
set "InputFile8=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile8=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile82=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile82=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind8=location=Genesis"
set "_strFind82=images directory=sega-image"
set "_strInsert8=location=%sega%"
set "_strInsert82=images directory=%segaimage%"

:Replace_sega
>"%OutputFile8%" (
  for /f "usebackq delims=" %%H in ("%InputFile8%") do (
    if "%%H" equ "%_strFind8%" (echo %_strInsert8%) else (echo %%H)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_sega2
>"%OutputFile82%" (
  for /f "usebackq delims=" %%I in ("%InputFile82%") do (
    if "%%I" equ "%_strFind82%" (echo %_strInsert82%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::SEGA SMS
::============

:Variables_sms
set "sms=%dirpath%\Steam_Shortcuts\SMS\SMS"
set "smsimage=%dirpath%\Images\Steam_Grid_Images\SMS"
set "InputFile14=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile14=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile142=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile142=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind14=location=SMS"
set "_strFind142=images directory=sms-image"
set "_strInsert14=location=%sms%"
set "_strInsert142=images directory=%smsimage%"

:Replace_sms
>"%OutputFile14%" (
  for /f "usebackq delims=" %%O in ("%InputFile14%") do (
    if "%%O" equ "%_strFind14%" (echo %_strInsert14%) else (echo %%O)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_sms2
>"%OutputFile142%" (
  for /f "usebackq delims=" %%I in ("%InputFile142%") do (
    if "%%I" equ "%_strFind142%" (echo %_strInsert142%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::PC Apps
::============

:Variables_apps
set "apps=%dirpath%\Steam_Shortcuts\Apps\Apps"
set "appsimage=%dirpath%\Images\Steam_Grid_Images\Apps"
set "InputFile15=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile15=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile152=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile152=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind15=location=APPS"
set "_strFind152=images directory=apps-image"
set "_strInsert15=location=%apps%"
set "_strInsert152=images directory=%appsimage%"

:Replace_apps
>"%OutputFile15%" (
  for /f "usebackq delims=" %%I in ("%InputFile15%") do (
    if "%%I" equ "%_strFind15%" (echo %_strInsert15%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_apps2
>"%OutputFile152%" (
  for /f "usebackq delims=" %%I in ("%InputFile152%") do (
    if "%%I" equ "%_strFind152%" (echo %_strInsert152%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::PC Games
::============

:Variables_pc
set "pc=%dirpath%\Steam_Shortcuts\PC_Games\PC_Games"
set "pcimage=%dirpath%\Images\Steam_Grid_Images\PC_Games"
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
set "gamecube=%dirpath%\Steam_Shortcuts\Gamecube\Gamecube"
set "gcimage=%dirpath%\Images\Steam_Grid_Images\Gamecube"
set "InputFile10=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile10=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile102=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile102=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind10=location=Gamecube"
set "_strFind102=images directory=gc-image"
set "_strInsert10=location=%gamecube%"
set "_strInsert102=images directory=%gcimage%"

:Replace_gamecube
>"%OutputFile10%" (
  for /f "usebackq delims=" %%J in ("%InputFile10%") do (
    if "%%J" equ "%_strFind10%" (echo %_strInsert10%) else (echo %%J)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_gamecube2
>"%OutputFile102%" (
  for /f "usebackq delims=" %%I in ("%InputFile102%") do (
    if "%%I" equ "%_strFind102%" (echo %_strInsert102%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::Wii
::============

:Variables_gamecube
set "wii=%dirpath%\Steam_Shortcuts\Wii\Wii"
set "wiiimage=%dirpath%\Images\Steam_Grid_Images\Wii"
set "InputFile11=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile11=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile112=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile112=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind11=location=Wii"
set "_strFind112=images directory=wii-image"
set "_strInsert11=location=%wii%"
set "_strInsert112=images directory=%wiiimage%"

:Replace_wii
>"%OutputFile11%" (
  for /f "usebackq delims=" %%K in ("%InputFile11%") do (
    if "%%K" equ "%_strFind11%" (echo %_strInsert11%) else (echo %%K)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_wii2
>"%OutputFile112%" (
  for /f "usebackq delims=" %%I in ("%InputFile112%") do (
    if "%%I" equ "%_strFind112%" (echo %_strInsert112%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::PS1
::============

:Variables_ps1
set "ps1=%dirpath%\Steam_Shortcuts\PS1\PS1"
set "ps1image=%dirpath%\Images\Steam_Grid_Images\PS1"
set "InputFile12=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile12=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile122=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile122=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind12=location=PS1"
set "_strFind122=images directory=ps1-image"
set "_strInsert12=location=%ps1%"
set "_strInsert122=images directory=%ps1image%"

:Replace_ps1
>"%OutputFile12%" (
  for /f "usebackq delims=" %%L in ("%InputFile12%") do (
    if "%%L" equ "%_strFind12%" (echo %_strInsert12%) else (echo %%L)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_ps12
>"%OutputFile122%" (
  for /f "usebackq delims=" %%I in ("%InputFile122%") do (
    if "%%I" equ "%_strFind122%" (echo %_strInsert122%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::PS2
::============

:Variables_ps2
set "ps2=%dirpath%\Steam_Shortcuts\PS2\PS2"
set "ps2image=%dirpath%\Images\Steam_Grid_Images\PS2"
set "InputFile13=%dirpath%\Tools\Ice\emulators.txt"
set "OutputFile13=%dirpath%\Tools\Ice\emulators-new.txt"
set "InputFile132=%dirpath%\Tools\Ice\consoles.txt"
set "OutputFile132=%dirpath%\Tools\Ice\consoles-new.txt"
set "_strFind13=location=PS2"
set "_strFind132=images directory=ps2-image"
set "_strInsert13=location=%ps2%"
set "_strInsert132=images directory=%ps2image%"

:Replace_ps2
>"%OutputFile13%" (
  for /f "usebackq delims=" %%M in ("%InputFile13%") do (
    if "%%M" equ "%_strFind13%" (echo %_strInsert13%) else (echo %%M)
  )
)

del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
rename "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_ps22
>"%OutputFile132%" (
  for /f "usebackq delims=" %%I in ("%InputFile132%") do (
    if "%%I" equ "%_strFind132%" (echo %_strInsert132%) else (echo %%I)
  )
)

del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
rename "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt
del /F /Q "%dirpath%\steam_path.txt"

::"%dirpath%\Tools\Ice\ice.exe"

::del /F /Q "%dirpath%\Tools\Ice\config.txt"
::copy /Y "%dirpath%\Tools\Ice\config_blank.txt" "%dirpath%\Tools\Ice\config.txt"
::del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
::copy /Y "%dirpath%\Tools\Ice\emulators_blank.txt" "%dirpath%\Tools\Ice\emulators.txt"
::del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
::copy /Y "%dirpath%\Tools\Ice\consoles_blank.txt" "%dirpath%\Tools\Ice\consoles.txt"

:end
goto :eof