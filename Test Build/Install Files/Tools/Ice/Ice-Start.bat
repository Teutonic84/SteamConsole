@ECHO off

TASKLIST /FI "IMAGENAME eq steam.exe" 2>NUL | FIND /I /N "steam.exe">NUL
IF "%ERRORLEVEL%"=="0" TASKKILL /f /im steam.exe
TASKLIST /FI "IMAGENAME eq Custom Hotkeys.exe" 2>NUL | FIND /I /N "Custom Hotkeys.exe">NUL
IF "%ERRORLEVEL%"=="0" TASKKILL /f /im "Custom Hotkeys.exe"

cls
CD "%~dp0%"
CD ..\..
SET "dirpath=%CD%"
CD "%dirpath%\Tools\Ice"

DEL /F /Q "%dirpath%\Tools\Ice\config.txt"
COPY /Y "%dirpath%\Tools\Ice\config_blank.txt" "%dirpath%\Tools\Ice\config.txt"
DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
COPY /Y "%dirpath%\Tools\Ice\emulators_blank.txt" "%dirpath%\Tools\Ice\emulators.txt"
DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
COPY /Y "%dirpath%\Tools\Ice\consoles_blank.txt" "%dirpath%\Tools\Ice\consoles.txt"

IF EXIST "%dirpath%\steam_path.txt" DEL "%dirpath%\steam_path.txt"
cscript.exe "%dirpath%\Scripts\steam_path_check.vbs" > "%dirpath%\steam_path.txt"
FOR /F "usebackq delims=" %%i IN ("%dirpath%\steam_path.txt") DO SET "steampath=%%i"

IF NOT EXIST "%userprofile%\AppData\Local\Scott Rice" (
    MKDIR "%userprofile%\AppData\Local\Scott Rice"
    MKDIR "%userprofile%\AppData\Local\Scott Rice\Ice"
)

IF EXIST "%steampath%\userdata\anonymous" (
    RMDIR /q /s "%steampath%\userdata\anonymous"
)

::ROM Renamer Script Call
::=======================
CALL "rom_renamer.bat" "%dirpath%" "Gamecube"
CALL "rom_renamer.bat" "%dirpath%" "GBA"
CALL "rom_renamer.bat" "%dirpath%" "N64"
CALL "rom_renamer.bat" "%dirpath%" "DS"
CALL "rom_renamer.bat" "%dirpath%" "NES"
CALL "rom_renamer.bat" "%dirpath%" "PS1"
CALL "rom_renamer.bat" "%dirpath%" "PS2"
CALL "rom_renamer.bat" "%dirpath%" "PSP"
CALL "rom_renamer.bat" "%dirpath%" "Genesis"
CALL "rom_renamer.bat" "%dirpath%" "SMS"
CALL "rom_renamer.bat" "%dirpath%" "SNES"
CALL "rom_renamer.bat" "%dirpath%" "Wii"

::===========================
::|       config.txt        |
::===========================

SET steampath2=%steampath:(=^^(%
SET steampath2=%steampath:)=^^)%
SET "InputFile=%dirpath%\Tools\Ice\config.txt"
SET "OutputFile=%dirpath%\Tools\Ice\config-new.txt"
SET "_strFind=ROMs Directory="
SET "_strInsert=ROMS Directory=%dirpath%\Emulators\ROMS"
SET "_strFind1=Userdata Directory="
SET "_strInsert1=Userdata Directory=%steampath2%\userdata"

:Replace
>"%OutputFile%" (
  FOR /f "usebackq delims=" %%A IN ("%InputFile%") DO (
    IF "%%A" equ "%_strFind%" (ECHO %_strInsert%)
	IF "%%A" equ "%_strFind1%" (ECHO %_strInsert1%)
	IF NOT "%%A" equ "%_strFind%" (
		IF NOT "%%A" equ "%_strFind1%" (ECHO %%A)
	)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\config.txt"
RENAME "%dirpath%\Tools\Ice\config-new.txt" config.txt

::===========================
::|      emulators.txt      |
::===========================

::Nintendo DS
::===========

:Variables_nds
::SET "nds=%dirpath%\Steam_Shortcuts\DS\DS"
SET "nds=%dirpath%\Scripts\Launcher.bat"
SET "dsimage=%dirpath%\Images\Steam_Grid_Images\DS"
SET "InputFile2=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile2=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile22=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile22=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind2=location=DS"
SET "_strFind22=images directory=ds-image"
SET "_strInsert2=location=%nds%"
SET "_strInsert22=images directory=%dsimage%"

:Replace_nds
>"%OutputFile2%" (
  FOR /f "usebackq delims=" %%B IN ("%InputFile2%") DO (
    IF "%%B" equ "%_strFind2%" (ECHO %_strInsert2%) ELSE (ECHO %%B)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_nds2
>"%OutputFile22%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile22%") DO (
    IF "%%I" equ "%_strFind22%" (ECHO %_strInsert22%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::Gameboy Advance
::===============

:Variables_gba
::SET "gba=%dirpath%\Steam_Shortcuts\GBA\GBA"
SET "gba=%dirpath%\Scripts\Launcher.bat"
SET "gbaimage=%dirpath%\Images\Steam_Grid_Images\GBA"
SET "InputFile3=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile3=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile32=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile32=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind3=location=GBA"
SET "_strFind32=images directory=gba-image"
SET "_strInsert3=location=%gba%"
SET "_strInsert32=images directory=%gbaimage%"

:Replace_gba
>"%OutputFile3%" (
  FOR /f "usebackq delims=" %%B IN ("%InputFile3%") DO (
    IF "%%B" equ "%_strFind3%" (ECHO %_strInsert3%) ELSE (ECHO %%B)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_gba2
>"%OutputFile32%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile32%") DO (
    IF "%%I" equ "%_strFind32%" (ECHO %_strInsert32%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::Nintendo 64
::===========

:Variables_n64
::SET "n64=%dirpath%\Steam_Shortcuts\N64\N64"
SET "n64=%dirpath%\Scripts\Launcher.bat"
SET "n64image=%dirpath%\Images\Steam_Grid_Images\N64"
SET "InputFile4=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile4=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile42=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile42=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind4=location=N64"
SET "_strFind42=images directory=n64-image"
SET "_strInsert4=location=%n64%"
SET "_strInsert42=images directory=%n64image%"

:Replace_n64
>"%OutputFile4%" (
  FOR /f "usebackq delims=" %%D IN ("%InputFile4%") DO (
    IF "%%D" equ "%_strFind4%" (ECHO %_strInsert4%) ELSE (ECHO %%D)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_n642
>"%OutputFile42%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile42%") DO (
    IF "%%I" equ "%_strFind42%" (ECHO %_strInsert42%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::NES
::===

:Variables_nes
::SET "nes=%dirpath%\Steam_Shortcuts\NES\NES"
SET "nes=%dirpath%\Scripts\Launcher.bat"
SET "nesimage=%dirpath%\Images\Steam_Grid_Images\NES"
SET "InputFile5=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile5=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile52=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile52=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind5=location=NES"
SET "_strFind52=images directory=nes-image"
SET "_strInsert5=location=%nes%"
SET "_strInsert52=images directory=%nesimage%"

:Replace_nes
>"%OutputFile5%" (
  FOR /f "usebackq delims=" %%E IN ("%InputFile5%") DO (
    IF "%%E" equ "%_strFind5%" (ECHO %_strInsert5%) ELSE (ECHO %%E)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_nes2
>"%OutputFile52%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile52%") DO (
    IF "%%I" equ "%_strFind52%" (ECHO %_strInsert52%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::SNES
::====

:Variables_snes
::SET "snes=%dirpath%\Steam_Shortcuts\SNES\SNES"
SET "snes=%dirpath%\Scripts\Launcher.bat"
SET "snesimage=%dirpath%\Images\Steam_Grid_Images\SNES"
SET "InputFile6=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile6=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile62=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile62=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind6=location=SNES"
SET "_strFind62=images directory=snes-image"
SET "_strInsert6=location=%snes%"
SET "_strInsert62=images directory=%snesimage%"

:Replace_snes
>"%OutputFile6%" (
  FOR /f "usebackq delims=" %%F IN ("%InputFile6%") DO (
    IF "%%F" equ "%_strFind6%" (ECHO %_strInsert6%) ELSE (ECHO %%F)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_snes2
>"%OutputFile62%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile62%") DO (
    IF "%%I" equ "%_strFind62%" (ECHO %_strInsert62%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::PSP
::===

:Variables_psp
::SET "psp=%dirpath%\Steam_Shortcuts\PSP\PSP"
SET "psp=%dirpath%\Scripts\Launcher.bat"
SET "pspimage=%dirpath%\Images\Steam_Grid_Images\PSP"
SET "InputFile7=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile7=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile72=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile72=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind7=location=PSP"
SET "_strFind72=images directory=psp-image"
SET "_strInsert7=location=%psp%"
SET "_strInsert72=images directory=%pspimage%"

:Replace_psp
>"%OutputFile7%" (
  FOR /f "usebackq delims=" %%G IN ("%InputFile7%") DO (
    IF "%%G" equ "%_strFind7%" (ECHO %_strInsert7%) ELSE (ECHO %%G)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_psp2
>"%OutputFile72%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile72%") DO (
    IF "%%I" equ "%_strFind72%" (ECHO %_strInsert72%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::SEGA Genesis
::============

:Variables_sega
::SET "sega=%dirpath%\Steam_Shortcuts\Genesis\Genesis"
SET "sega=%dirpath%\Scripts\Launcher.bat"
SET "segaimage=%dirpath%\Images\Steam_Grid_Images\Genesis"
SET "InputFile8=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile8=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile82=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile82=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind8=location=Genesis"
SET "_strFind82=images directory=sega-image"
SET "_strInsert8=location=%sega%"
SET "_strInsert82=images directory=%segaimage%"

:Replace_sega
>"%OutputFile8%" (
  FOR /f "usebackq delims=" %%H IN ("%InputFile8%") DO (
    IF "%%H" equ "%_strFind8%" (ECHO %_strInsert8%) ELSE (ECHO %%H)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_sega2
>"%OutputFile82%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile82%") DO (
    IF "%%I" equ "%_strFind82%" (ECHO %_strInsert82%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::SEGA SMS
::============

:Variables_sms
::SET "sms=%dirpath%\Steam_Shortcuts\SMS\SMS"
SET "sms=%dirpath%\Scripts\Launcher.bat"
SET "smsimage=%dirpath%\Images\Steam_Grid_Images\SMS"
SET "InputFile14=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile14=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile142=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile142=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind14=location=SMS"
SET "_strFind142=images directory=sms-image"
SET "_strInsert14=location=%sms%"
SET "_strInsert142=images directory=%smsimage%"

:Replace_sms
>"%OutputFile14%" (
  FOR /f "usebackq delims=" %%O IN ("%InputFile14%") DO (
    IF "%%O" equ "%_strFind14%" (ECHO %_strInsert14%) ELSE (ECHO %%O)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_sms2
>"%OutputFile142%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile142%") DO (
    IF "%%I" equ "%_strFind142%" (ECHO %_strInsert142%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::PC Apps
::============

:Variables_apps
::SET "apps=%dirpath%\Steam_Shortcuts\Apps\Apps"
SET "apps=%dirpath%\Scripts\Launcher.bat"
SET "appsimage=%dirpath%\Images\Steam_Grid_Images\Apps"
SET "InputFile15=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile15=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile152=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile152=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind15=location=APPS"
SET "_strFind152=images directory=apps-image"
SET "_strInsert15=location=%apps%"
SET "_strInsert152=images directory=%appsimage%"

:Replace_apps
>"%OutputFile15%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile15%") DO (
    IF "%%I" equ "%_strFind15%" (ECHO %_strInsert15%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_apps2
>"%OutputFile152%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile152%") DO (
    IF "%%I" equ "%_strFind152%" (ECHO %_strInsert152%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::PC Games
::============

:Variables_pc
::SET "pc=%dirpath%\Steam_Shortcuts\PC_Games\PC_Games"
SET "pc=%dirpath%\Scripts\Launcher.bat"
SET "pcimage=%dirpath%\Images\Steam_Grid_Images\PC_Games"
SET "InputFile9=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile9=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile92=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile92=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind9=location=PC"
SET "_strFind92=images directory=pc-image"
SET "_strInsert9=location=%pc%"
SET "_strInsert92=images directory=%pcimage%"

:Replace_pc
>"%OutputFile9%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile9%") DO (
    IF "%%I" equ "%_strFind9%" (ECHO %_strInsert9%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_pc2
>"%OutputFile92%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile92%") DO (
    IF "%%I" equ "%_strFind92%" (ECHO %_strInsert92%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::Gamecube
::============

:Variables_gamecube
::SET "gamecube=%dirpath%\Steam_Shortcuts\Gamecube\Gamecube"
SET "gamecube=%dirpath%\Scripts\Launcher.bat"
SET "gcimage=%dirpath%\Images\Steam_Grid_Images\Gamecube"
SET "InputFile10=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile10=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile102=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile102=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind10=location=Gamecube"
SET "_strFind102=images directory=gc-image"
SET "_strInsert10=location=%gamecube%"
SET "_strInsert102=images directory=%gcimage%"

:Replace_gamecube
>"%OutputFile10%" (
  FOR /f "usebackq delims=" %%J IN ("%InputFile10%") DO (
    IF "%%J" equ "%_strFind10%" (ECHO %_strInsert10%) ELSE (ECHO %%J)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_gamecube2
>"%OutputFile102%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile102%") DO (
    IF "%%I" equ "%_strFind102%" (ECHO %_strInsert102%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::Wii
::============

:Variables_gamecube
::SET "wii=%dirpath%\Steam_Shortcuts\Wii\Wii"
SET "wii=%dirpath%\Scripts\Launcher.bat"
SET "wiiimage=%dirpath%\Images\Steam_Grid_Images\Wii"
SET "InputFile11=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile11=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile112=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile112=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind11=location=Wii"
SET "_strFind112=images directory=wii-image"
SET "_strInsert11=location=%wii%"
SET "_strInsert112=images directory=%wiiimage%"

:Replace_wii
>"%OutputFile11%" (
  FOR /f "usebackq delims=" %%K IN ("%InputFile11%") DO (
    IF "%%K" equ "%_strFind11%" (ECHO %_strInsert11%) ELSE (ECHO %%K)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_wii2
>"%OutputFile112%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile112%") DO (
    IF "%%I" equ "%_strFind112%" (ECHO %_strInsert112%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::PS1
::============

:Variables_ps1
::SET "ps1=%dirpath%\Steam_Shortcuts\PS1\PS1"
SET "ps1=%dirpath%\Scripts\Launcher.bat"
SET "ps1image=%dirpath%\Images\Steam_Grid_Images\PS1"
SET "InputFile12=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile12=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile122=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile122=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind12=location=PS1"
SET "_strFind122=images directory=ps1-image"
SET "_strInsert12=location=%ps1%"
SET "_strInsert122=images directory=%ps1image%"

:Replace_ps1
>"%OutputFile12%" (
  FOR /f "usebackq delims=" %%L IN ("%InputFile12%") DO (
    IF "%%L" equ "%_strFind12%" (ECHO %_strInsert12%) ELSE (ECHO %%L)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_ps12
>"%OutputFile122%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile122%") DO (
    IF "%%I" equ "%_strFind122%" (ECHO %_strInsert122%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

::PS2
::============

:Variables_ps2
::SET "ps2=%dirpath%\Steam_Shortcuts\PS2\PS2"
SET "ps2=%dirpath%\Scripts\Launcher.bat"
SET "ps2image=%dirpath%\Images\Steam_Grid_Images\PS2"
SET "InputFile13=%dirpath%\Tools\Ice\emulators.txt"
SET "OutputFile13=%dirpath%\Tools\Ice\emulators-new.txt"
SET "InputFile132=%dirpath%\Tools\Ice\consoles.txt"
SET "OutputFile132=%dirpath%\Tools\Ice\consoles-new.txt"
SET "_strFind13=location=PS2"
SET "_strFind132=images directory=ps2-image"
SET "_strInsert13=location=%ps2%"
SET "_strInsert132=images directory=%ps2image%"

:Replace_ps2
>"%OutputFile13%" (
  FOR /f "usebackq delims=" %%M IN ("%InputFile13%") DO (
    IF "%%M" equ "%_strFind13%" (ECHO %_strInsert13%) ELSE (ECHO %%M)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

:Replace_ps22
>"%OutputFile132%" (
  FOR /f "usebackq delims=" %%I IN ("%InputFile132%") DO (
    IF "%%I" equ "%_strFind132%" (ECHO %_strInsert132%) ELSE (ECHO %%I)
  )
)

DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt

"%dirpath%\Tools\Ice\ice.exe"

DEL /F /Q "%dirpath%\Tools\Ice\config.txt"
COPY /Y "%dirpath%\Tools\Ice\config_blank.txt" "%dirpath%\Tools\Ice\config.txt"
DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
COPY /Y "%dirpath%\Tools\Ice\emulators_blank.txt" "%dirpath%\Tools\Ice\emulators.txt"
DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
COPY /Y "%dirpath%\Tools\Ice\consoles_blank.txt" "%dirpath%\Tools\Ice\consoles.txt"
DEL /F /Q "%dirpath%\steam_path.txt"

:end

START "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"
START "" "%dirpath%\Tools\Xpadder\Xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
START "" "%steampath%\Steam.exe" -start steam://open/bigpicture

EXIT