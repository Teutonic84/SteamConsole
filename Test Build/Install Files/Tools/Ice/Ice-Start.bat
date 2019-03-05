@ECHO off
cls
CD "%~dp0%"
CD ..\..
SET "dirpath=%CD%"
CD "%dirpath%\Tools\Ice"

:CHECK_CONFIG_FILE
FOR /f "tokens=2 delims==" %%a IN ('TYPE "%dirpath%\config\general_settings.ini" ^| FIND "Rename ROMs During Steam Import"') DO SET "rom_renamer=%%a"

TASKLIST /FI "IMAGENAME eq steam.exe" 2>NUL | FIND /I /N "steam.exe">NUL
IF "%ERRORLEVEL%"=="0" TASKKILL /f /im steam.exe

:FILE_CLEANUP
	IF EXIST "%dirpath%\steam_path.txt" DEL /q "%dirpath%\steam_path.txt"
	DEL /F /Q "%dirpath%\Tools\Ice\config.txt" >NUL
	COPY /Y "%dirpath%\Tools\Ice\config_blank.txt" "%dirpath%\Tools\Ice\config.txt" >NUL
	DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt" >NUL
	COPY /Y "%dirpath%\Tools\Ice\emulators_blank.txt" "%dirpath%\Tools\Ice\emulators.txt" >NUL
	DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt" >NUL
	COPY /Y "%dirpath%\Tools\Ice\consoles_blank.txt" "%dirpath%\Tools\Ice\consoles.txt" >NUL

:STEAM_PATH
	cscript.exe "%dirpath%\Scripts\steam_path_check.vbs" > "%dirpath%\steam_path.txt"
	FOR /F "usebackq delims=" %%i IN ("%dirpath%\steam_path.txt") DO SET "steampath=%%i"
	IF EXIST "%dirpath%\steam_path.txt" DEL /q "%dirpath%\steam_path.txt"
	IF EXIST "%steampath%\userdata\anonymous" (
		RMDIR /q /s "%steampath%\userdata\anonymous"
	)
	FOR /R "%steampath%\userdata" %%a IN ("*.vdf") DO (
		IF "%%~nxa"=="shortcuts.vdf" (
			DEL /Q "%%a"
			ECHO Removed %%a
			PING localhost -n 3 >NUL
		)
	)
	IF NOT EXIST "%userprofile%\AppData\Local\Scott Rice" (
		MKDIR "%userprofile%\AppData\Local\Scott Rice"
		MKDIR "%userprofile%\AppData\Local\Scott Rice\Ice"
	)

::ROM Renamer Script Call
::=======================
:RENAMER
	IF "%rom_renamer%"=="disabled" GOTO CONFIG
	
	CALL "rom_renamer.bat" "%dirpath%" "GBA"
	CALL "rom_renamer.bat" "%dirpath%" "DS"
	CALL "rom_renamer.bat" "%dirpath%" "NES"
	CALL "rom_renamer.bat" "%dirpath%" "SNES"
	CALL "rom_renamer.bat" "%dirpath%" "N64"
	CALL "rom_renamer.bat" "%dirpath%" "Gamecube"
	CALL "rom_renamer.bat" "%dirpath%" "Wii"
	CALL "rom_renamer.bat" "%dirpath%" "SMS"
	CALL "rom_renamer.bat" "%dirpath%" "Genesis"
	CALL "rom_renamer.bat" "%dirpath%" "PSP"
	CALL "rom_renamer.bat" "%dirpath%" "PS1"
	CALL "rom_renamer.bat" "%dirpath%" "PS2"

::===========================
::|       config.txt        |
::===========================
:CONFIG
	SET steampath2=%steampath:(=^^(%
	SET steampath2=%steampath:)=^^)%
	SET "InputFile=%dirpath%\Tools\Ice\config.txt"
	SET "OutputFile=%dirpath%\Tools\Ice\config-new.txt"
	SET "_strFind=ROMs Directory="
	SET "_strInsert=ROMS Directory=%dirpath%\Emulators\ROMS"
	SET "_strFind1=Userdata Directory="
	SET "_strInsert1=Userdata Directory=%steampath2%\userdata"

	:REPLACE
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
:EMULATORS
	CALL :EMULATOR_REPLACE "%dirpath%" "Apps"
	CALL :EMULATOR_REPLACE "%dirpath%" "GBA"
	CALL :EMULATOR_REPLACE "%dirpath%" "DS"
	CALL :EMULATOR_REPLACE "%dirpath%" "NES"
	CALL :EMULATOR_REPLACE "%dirpath%" "SNES"
	CALL :EMULATOR_REPLACE "%dirpath%" "N64"
	CALL :EMULATOR_REPLACE "%dirpath%" "GC"
	CALL :EMULATOR_REPLACE "%dirpath%" "Wii"
	CALL :EMULATOR_REPLACE "%dirpath%" "SMS"
	CALL :EMULATOR_REPLACE "%dirpath%" "SEGA"
	CALL :EMULATOR_REPLACE "%dirpath%" "PSP"
	CALL :EMULATOR_REPLACE "%dirpath%" "PS1"
	CALL :EMULATOR_REPLACE "%dirpath%" "PS2"
	CALL :EMULATOR_REPLACE "%dirpath%" "PC"
	CALL :EMULATOR_REPLACE "%dirpath%" "Launchers"

:ICE_RUN
	"%dirpath%\Tools\Ice\ice.exe"

	DEL /F /Q "%dirpath%\Tools\Ice\config.txt"
	COPY /Y "%dirpath%\Tools\Ice\config_blank.txt" "%dirpath%\Tools\Ice\config.txt"
	DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
	COPY /Y "%dirpath%\Tools\Ice\emulators_blank.txt" "%dirpath%\Tools\Ice\emulators.txt"
	DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
	COPY /Y "%dirpath%\Tools\Ice\consoles_blank.txt" "%dirpath%\Tools\Ice\consoles.txt"
	IF EXIST "%dirpath%\steam_path.txt" DEL /F /Q "%dirpath%\steam_path.txt" >NUL

:APPS_LAUNCH
	TASKLIST /FI "IMAGENAME eq Custom Hotkeys.exe" 2>NUL | FIND /I /N "Custom Hotkeys.exe">NUL
		IF NOT "%ERRORLEVEL%"=="0" START "" "%dirpath%\Tools\Custom Hotkeys.exe"
	TASKLIST /FI "IMAGENAME eq antimicro.exe" 2>NUL | FIND /I /N "antimicro.exe">NUL
		IF NOT "%ERRORLEVEL%"=="0" START "" "%dirpath%\Tools\antimicro\antimicro.exe"
	START "" "%steampath%\Steam.exe" -start steam://open/bigpicture
	GOTO end

::=================
::---BEGIN CALLS---
::=================
:EMULATOR_REPLACE
	SET "dirpath=%~1"
	SET "console=%~2"
	SET "emulator=%dirpath%\Scripts\Launcher.bat"
	SET "imagepath=%dirpath%\Images\Steam_Grid_Images\%console%"
	SET "InputFile=%dirpath%\Tools\Ice\emulators.txt"
	SET "OutputFile=%dirpath%\Tools\Ice\emulators-new.txt"
	SET "InputFile2=%dirpath%\Tools\Ice\consoles.txt"
	SET "OutputFile2=%dirpath%\Tools\Ice\consoles-new.txt"
	SET "_strFind=location=%console%"
	SET "_strInsert=location=%emulator%"
	SET "_strFind2=images directory=%console%-image"
	SET "_strInsert2=images directory=%imagepath%"

	:REPLACE_EMU
		>"%OutputFile%" (
			FOR /f "usebackq delims=" %%B IN ("%InputFile%") DO (
				IF "%%B" equ "%_strFind%" (echo %_strInsert%) ELSE (echo %%B)
			)
		)
		DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
		RENAME "%dirpath%\Tools\Ice\emulators-new.txt" emulators.txt

	:REPLACE_CONSOLE
		>"%OutputFile2%" (
			FOR /f "usebackq delims=" %%I IN ("%InputFile2%") DO (
				IF "%%I" equ "%_strFind2%" (echo %_strInsert2%) ELSE (echo %%I)
			)
		)
		DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
		RENAME "%dirpath%\Tools\Ice\consoles-new.txt" consoles.txt
		GOTO :eof

::=================
::----END CALLS----
::=================

:end
EXIT
