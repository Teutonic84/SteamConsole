ECHO off
cls
CD "%~dp0%"
CD ..
SET "dirpath=%cd%"
CD "%dirpath%\Scripts\Updater"

IF NOT EXIST "files" (MKDIR files)

::=======================
::|  RetroArch Section  |
::=======================
:retroarch
	SET /P olddate=<date.txt
	SET datef=%date:~-4%-%date:~4,2%-%date:~7,2%
	::SET day=%date:~7,2%
	::SET /a day=%day%-1
	::SET datef=%date:~-4%-%date:~4,2%-%day%

	::Download RetroArch Program Package:
	::==================================
	cls
	ECHO Downloading RetroArch Nightly Build %datef%...
		SET link=http://buildbot.libretro.com/nightly/windows/x86_64/%datef%_RetroArch.7z
		wget --tries=3 --no-check-certificate %link% 2>NUL 1>NUL
			IF NOT EXIST "%datef%_RetroArch.7z" GOTO yesterday
			IF %errorlevel%==0 ECHO %datef%>date.txt
			GOTO download

	:yesterday
		cls
		ECHO Couldn't Download Today's Nightly Build %datef%. Trying Yesterday's...
		SET day=%date:~7,2%
		SET /a day=%day%-1
		SET datef=%date:~-4%-%date:~4,2%-%day%

		::Download RetroArch Program Package:
		::==================================
		wget --tries=3 --no-check-certificate http://buildbot.libretro.com/nightly/windows/x86_64/%datef%_RetroArch.7z 2>NUL 1>NUL
			IF NOT EXIST "%datef%_RetroArch.7z" (
				SET "retroarch=RetroArch - Couldn't download today or yesterday's nightly build. Try again tomorrow."
				GOTO cores
			)
			cls

	:download
		cls
		IF EXIST "%datef%_RetroArch.7z" (
			ECHO Extracting RetroArch Nightly %datef%...
				7zG x -y -o"files\RetroArch" "%datef%_RetroArch.7z"
				DEL /q %datef%_RetroArch.7z 2>NUL 1>NUL
			ECHO Replacing old files with new ones...
				ROBOCOPY files\RetroArch ..\..\Emulators\RetroArch\ /E /XO /MOVE 2>NUL 1>NUL
				SET "retroarch=RetroArch updated to %datef%..."
		)
		cls

		:redist
			ECHO Downloading RetroArch Redist %datef%...
			SET link2=http://buildbot.libretro.com/nightly/windows/x86_64/redist.7z
			wget --tries=3 --no-check-certificate %link2% 2>NUL 1>NUL
			cls
			IF NOT EXIST "redist.7z" (
				ECHO Download of RetroArch redist files failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues
				SET "redist=Download of RetroArch redist files failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues"
				GOTO cores
			)
			ECHO Extracting RetroArch Redist Files...
			7zG x -y -o"files\RetroArch-redist" "redist.7z"
			DEL /q "redist.7z" 2>NUL 1>NUL
			cls
			ECHO Replacing old files with new ones...
			ROBOCOPY files\RetroArch-redist ..\..\Emulators\RetroArch\ /E /XO /MOVE 2>NUL 1>NUL
			SET "redist=RetroArch Redist Files Updated."

::=====================
::|  Cores Section    |
::=====================
:cores
	cls
	ECHO Downloading latest RetroArch cores...
		wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/mupen64plus_libretro.dll.zip 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/assets/frontend/info/mupen64plus_libretro.info 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/desmume_libretro.dll.zip 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/assets/frontend/info/desmume_libretro.info 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/genesis_plus_gx_libretro.dll.zip 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/assets/frontend/info/genesis_plus_gx_libretro.info 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_psx_libretro.dll.zip 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/assets/frontend/info/mednafen_psx_libretro.info 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/nestopia_libretro.dll.zip 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/assets/frontend/info/nestopia_libretro.info 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/ppsspp_libretro.dll.zip 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/assets/frontend/info/ppsspp_libretro.info 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/snes9x_libretro.dll.zip 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/assets/frontend/info/snes9x_libretro.info 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/vbam_libretro.dll.zip 2>NUL 1>NUL
		wget --tries=3 http://buildbot.libretro.com/assets/frontend/info/vbam_libretro.info 2>NUL 1>NUL
		cls
	ECHO Extracting RetroArch cores...
		IF NOT EXIST "files\RetroArch_Cores" MKDIR "files\RetroArch_Cores"
		IF EXIST "mupen64plus_libretro.dll.zip" 7zG x -y -o"files\RetroArch_Cores" "mupen64plus_libretro.dll.zip"
		IF EXIST "desmume_libretro.dll.zip" 7zG x -y -o"files\RetroArch_Cores" "desmume_libretro.dll.zip"
		IF EXIST "genesis_plus_gx_libretro.dll.zip" 7zG x -y -o"files\RetroArch_Cores" "genesis_plus_gx_libretro.dll.zip"
		IF EXIST "mednafen_psx_libretro.dll.zip" 7zG x -y -o"files\RetroArch_Cores" "mednafen_psx_libretro.dll.zip"
		IF EXIST "nestopia_libretro.dll.zip" 7zG x -y -o"files\RetroArch_Cores" "nestopia_libretro.dll.zip"
		IF EXIST "ppsspp_libretro.dll.zip" 7zG x -y -o"files\RetroArch_Cores" "ppsspp_libretro.dll.zip"
		IF EXIST "snes9x_libretro.dll.zip" 7zG x -y -o"files\RetroArch_Cores" "snes9x_libretro.dll.zip"
		IF EXIST "vbam_libretro.dll.zip" 7zG x -y -o"files\RetroArch_Cores" "vbam_libretro.dll.zip"

		DEL "mupen64plus_libretro.dll.zip" 2>NUL 1>NUL
		DEL "desmume_libretro.dll.zip" 2>NUL 1>NUL
		DEL "genesis_plus_gx_libretro.dll.zip" 2>NUL 1>NUL
		DEL "mednafen_psx_libretro.dll.zip" 2>NUL 1>NUL
		DEL "nestopia_libretro.dll.zip" 2>NUL 1>NUL
		DEL "ppsspp_libretro.dll.zip" 2>NUL 1>NUL
		DEL "snes9x_libretro.dll.zip" 2>NUL 1>NUL
		DEL "vbam_libretro.dll.zip" 2>NUL 1>NUL
		cls
	ECHO Updating RetroArch cores...
		IF NOT EXIST "..\..\Emulators\RetroArch\info" MKDIR "..\..\Emulators\RetroArch\info" 2>NUL 1>NUL
		MOVE /y "*.info" ..\..\Emulators\RetroArch\info\ 2>NUL 1>NUL
		ROBOCOPY "files\RetroArch_Cores" ..\..\Emulators\RetroArch\cores\ /E /XO /MOVE 2>NUL 1>NUL
		IF EXIST "files\RetroArch_Cores" RMDIR /s /q "files\RetroArch_Cores" 2>NUL 1>NUL
		SET "cores=RetroArch Cores Updated To Latest Versions."

::=====================
::|  PCSX2 Section    |
::=====================
:pcsx2
	SET /p version=<version_pcsx2.txt
	wget -N --tries=3 --no-parent --html-extension --secure-protocol=tlsv1 --no-check-certificate "https://buildbot.orphis.net/pcsx2/index.php" 2>NUL 1>NUL
	FOR /F "tokens=4 delims=><" %%a IN ('findstr /I " \<v1.* " index.php.html') DO (
		SET "newversion=%%a"
		GOTO vercheck
	)
	SET "pcsx2=PCSX2 Host Down Currently..."
	GOTO dolphin

	:vercheck
		DEL /q index.php.html 2>NUL 1>NUL
		cls
		IF %version% == %newversion% GOTO NOUP
		ECHO Downloading PCSX2 %newversion% files...
			wget -Q7m --tries=3 --reject css,html --mirror -p --convert-links -P files\PCSX2 "https://buildbot.orphis.net/pcsx2/index.php" 2>NUL 1>NUL
			cls
			IF NOT EXIST "files\PCSX2\buildbot.orphis.net\pcsx2\index.php@m=dl&rev=%newversion%&platform=windows-x86" (
				ECHO Download of PCSX2 failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues
				SET "pcsx2=Download of PCSX2 failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues"
				GOTO dolphin
			)
		ECHO Extracting PCSX2 %newversion% files...
			7zG x -y -o"files\PCSX2" "files\PCSX2\buildbot.orphis.net\pcsx2\index.php@m=dl&rev=%newversion%&platform=windows-x86"
			cls
		ECHO Replacing old files with new ones...
			ROBOCOPY "files\PCSX2\pcsx2-%newversion%-windows-x86" ..\..\Emulators\PS2\PCSX2\ /E /XO /MOVE 2>NUL 1>NUL
			COPY /y portable.ini "..\..\Emulators\PS2\PCSX2\portable.ini" 2>NUL 1>NUL
			"..\..\Emulators\PS2\PCSX2\4gb_patch.exe" ..\..\Emulators\PS2\pcsx2\pcsx2.exe
			IF EXIST "files\PCSX2" RMDIR /s /q "files\PCSX2" 2>NUL 1>NUL
			@ECHO %newversion%>version_pcsx2.txt
			cls
		ECHO PCSX2 successfully updated to %newversion%...
			SET "pcsx2=PCSX2 Updated to %newversion%..."
			GOTO dolphin

	:NOUP
		ECHO.
		ECHO.
		ECHO ======================================
		ECHO   PCSX2 already up to date...
		ECHO ======================================
		ECHO.
		ECHO.
		SET "pcsx2=PCSX2 already up to date..."

::=======================
::|  Dolphin Section    |
::=======================
:dolphin
	cls
	wget -N --tries=3 --no-parent --html-extension --secure-protocol=tlsv1 --no-check-certificate https://dolphin-emu.org/download/ 2>NUL 1>NUL
	::FOR /F "tokens=2 delims=)(" %%a IN ('findstr /I " \<(.* " index.html') DO (
	FOR /F "tokens=2 delims=()" %%a IN ('FINDSTR "version always-ltr" index.html') DO (
		SET "newversion2=%%a"
		GOTO DOLPHIN_CHECK
	)
	SET "dolphin=Dolphin Host Down Currently..."
	GOTO complete

	:DOLPHIN_CHECK
		SET /p version2=<version_dolphin.txt
		DEL /q "index.html" 2>NUL 1>NUL
		IF %version2% == %newversion2% GOTO NOUP2

		SET link=http://dl.dolphin-emu.org/builds/dolphin-master-%newversion2%-x64.7z
		cls
		ECHO Downloading Dolphin %newversion2% files...
			wget --tries=3 --no-check-certificate %link% 2>NUL 1>NUL
			cls
			IF NOT EXIST "dolphin-master-%newversion2%-x64.7z" (
				ECHO Download of Dolphin failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues
				SET "pcsx2=Download of Dolphin failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues"
				GOTO complete
			)
		ECHO Extracting Dolphin %newversion2% files...
			7zG x -y -o"files\" dolphin-master-%newversion2%-x64.7z
			DEL dolphin-master-%newversion2%-x64.7z 2>NUL 1>NUL
			cls
		ECHO Replacing old files with new ones...
			@ECHO %newversion2%>version_dolphin.txt
			ROBOCOPY files\Dolphin-x64 ..\..\Emulators\Gamecube\Dolphin\ /E /XO /MOVE 2>NUL 1>NUL
			IF EXIST "Dolphin-x64" RMDIR /s /q Dolphin-x64 2>NUL 1>NUL
			cls
		ECHO Dolphin successfully updated to %newversion2%...
			SET "dolphin=Dolphin Updated to %newversion2%..."
			GOTO complete

	:NOUP2
		ECHO.
		ECHO.
		ECHO ======================================
		ECHO   Dolphin already up to date...
		ECHO ======================================
		ECHO.
		ECHO.
		SET "dolphin=Dolphin already up to date..."

::===================
::|  UPDATES END    |
::===================
:complete
	IF EXIST "files\" (RMDIR /q /s files)
	IF EXIST "%datef%_RetroArch.7z" (DEL /q %datef%_RetroArch.7z)
	IF EXIST "dolphin-master-%newversion%-x64.7z" (DEL /q dolphin-master-%newversion%-x64.7z)
	cls
	ECHO.
	ECHO ======================================
	ECHO   %pcsx2%
	ECHO ======================================
	ECHO.
	ECHO ======================================
	ECHO   %dolphin%
	ECHO ======================================
	ECHO.
	ECHO ======================================
	ECHO   %retroarch%
	ECHO   %redist%
	ECHO   %cores%
	ECHO ======================================
	ECHO.
	ECHO.

:nochange
	IF EXIST "files\" (RMDIR /q /s files)
	IF EXIST "%datef%_RetroArch.7z" (DEL /q %datef%_RetroArch.7z)
	IF EXIST "dolphin-master-%newversion%-x64.7z" (DEL /q dolphin-master-%newversion%-x64.7z)
	cls
	ECHO.
	ECHO ======================================
	ECHO   %pcsx2%
	ECHO ======================================
	ECHO.
	ECHO ======================================
	ECHO   %dolphin%
	ECHO ======================================
	ECHO.
	ECHO ======================================
	ECHO   RetroArch already up to date...
	ECHO ======================================
	ECHO.
	ECHO.

:end
EXIT
