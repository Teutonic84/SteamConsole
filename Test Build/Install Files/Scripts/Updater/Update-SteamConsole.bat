@echo off
cls
CD ..\..
SET "dirpath=%cd%"
CD "%dirpath%\Scripts\Updater"

IF NOT EXIST "..\..\Images" (MKDIR ..\..\Images)
IF NOT EXIST "files" (MKDIR files)

::taskkill /T /IM "ScpService.exe" 2>NUL 1>NUL
TASKKILL /f /im "Custom Hotkeys.exe" 2>NUL 1>NUL
TASKKILL /f /im "Steam.exe" 2>NUL 1>NUL

IF EXIST "Files\SteamConsole_%newversionsc%_x64" RMDIR /s /q "Files\SteamConsole_%newversionsc%_x64" 2>NUL 1>NUL
IF EXIST "..\..\Emulators\Updater" RMDIR /s /q "..\..\Emulators\Updater" 2>NUL 1>NUL
IF EXIST "Update-Emulators.bat" DEL /q "Update-Emulators.bat" 2>NUL 1>NUL
IF EXIST "..\..\Emulators\Gamecube\Dolphin\Updater" RMDIR /s /q "..\..\Emulators\Gamecube\Dolphin\Updater" 2>NUL 1>NUL
IF EXIST "..\..\Steam_Shortcuts\Apps\Xbox Games.bat" DEL /q "..\..\Steam_Shortcuts\Apps\Xbox Games.bat" 2>NUL 1>NUL
IF EXIST "..\..\Emulators\RetroArch_x64" RENAME "..\..\Emulators\RetroArch_x64" RetroArch 2>NUL 1>NUL
IF EXIST "..\..\Steam_Grid_Images" MOVE "..\..\Steam_Grid_Images" "..\..\Images" 2>NUL 1>NUL
IF EXIST "..\..\steam_path_check.vbs" DEL /q "..\..\steam_path_check.vbs" 2>NUL 1>NUL
IF EXIST "..\..\steam_path_check_x64.vbs" DEL /q "..\..\steam_path_check_x64.vbs" 2>NUL 1>NUL
IF EXIST "..\..\steam_path_check_x86.vbs" DEL /q "..\..\steam_path_check_x86.vbs" 2>NUL 1>NUL
IF EXIST "..\..\replace.vbs" DEL /q "..\..\replace.vbs" 2>NUL 1>NUL
IF EXIST "..\..\replace2.vbs" DEL /q "..\..\replace2.vbs" 2>NUL 1>NUL
IF EXIST "..\..\Shortcut.exe" DEL /q "..\..\Shortcut.exe" 2>NUL 1>NUL
IF EXIST "..\Logoff.bat" DEL /q "..\Logoff.bat" 2>NUL 1>NUL
IF EXIST "..\ROM_Rename.bat" DEL /q "..\ROM_Rename.bat" 2>NUL 1>NUL
IF EXIST "..\ROM_Shortcut_Blank_Dolphin.bat" DEL /q "..\ROM_Shortcut_Blank_Dolphin.bat" 2>NUL 1>NUL
IF EXIST "..\ROM_Shortcut_Blank_ePSXe.bat" DEL /q "..\ROM_Shortcut_Blank_ePSXe.bat" 2>NUL 1>NUL
IF EXIST "..\ROM_Shortcut_Blank_PCSX2.bat" DEL /q "..\ROM_Shortcut_Blank_PCSX2.bat" 2>NUL 1>NUL
IF EXIST "..\Services.bat" DEL /q "..\Services.bat" 2>NUL 1>NUL

:steampath
IF EXIST "..\..\steam_path.txt" DEL "..\..\steam_path.txt" 2>NUL 1>NUL
cscript.exe "..\steam_path_check.vbs" > "..\..\steam_path.txt"

FOR /F "usebackq delims=" %%i IN ("..\..\steam_path.txt") DO SET "steampath=%%i"
DEL "..\..\steam_path.txt"

::=======================
::|  Updater Section    |
::=======================
:updater
cls
wget -N --no-parent --tries=3 --html-extension --secure-protocol=auto --no-check-certificate https://github.com/Teutonic84/SteamConsole/releases/ 2>NUL 1>NUL
FOR /F "tokens=8 delims=/ " %%h IN ('findstr /I " Updater_ " index.html') DO (
    SET "newversionup=%%h"
    GOTO nextup
)
SET "updater=Updater Host Down Currently..."
DEL /q "index.html" 2>NUL 1>NUL
GOTO steamconsole

:nextup
cls
DEL /q "index.html" 2>NUL 1>NUL
SET newversionup=%newversionup:Updater_v=%
SET newversionup=%newversionup:.7z"=%
SET "key=HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole"

Reg query "%key%" /v Updater 2>NUL 1>NUL
if %errorlevel%==1 GOTO update

FOR /f "tokens=3 delims= " %%i IN ('Reg query "%key%" /v Updater') DO SET "currentver=%%i"
if %currentver% == %newversionup% GOTO steamconsole

:update
cls
ping haackerit.duckdns.org -n 1 2>NUL 1>NUL
if %errorlevel%==1 (
    SET "updater=Updater Host Down Currently..."
    GOTO steamconsole
)
cls
echo Downloading SteamConsole Updater v%newversionup% files...
wget --tries=3 --ftp-user=public --ftp-password="[anthakth15" --no-check-certificate --secure-protocol=auto "ftp://haackerit.duckdns.org/Updater_v%newversionup%.7z" 2>NUL 1>NUL
cls
echo Extracting SteamConsole Updater v%newversionup% files...
7zG x -y -o"files\Updater_v%newversionup%" Updater_v%newversionup%.7z
DEL "Updater_v%newversionup%.7z"
cls
echo Replacing old files with new ones...
robocopy "Files\Updater_v%newversionup%\Updater" ..\..\..\SteamConsole\Scripts\Updater "*.*" /E /XO /MOVE 2>NUL 1>NUL

echo Windows Registry Editor Version 5.00 >"%dirpath%\Scripts\Updater\reg_add.reg"
echo. >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole] >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo "Updater"="%newversionup%" >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo. >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo. >>"%dirpath%\Scripts\Updater\reg_add.reg"

regedit /s "%dirpath%\Scripts\Updater\reg_add.reg"
DEL /q "%dirpath%\Scripts\Updater\reg_add.reg"

IF EXIST "files\Updater_v%newversionup%" RMDIR /s /q "files\Updater_v%newversionup%"
cls
echo.
echo.
echo ============================================================================
echo   Updater Updated to %newversionup%. Please close updater and run it again.
echo ============================================================================
echo.
echo.
pause
GOTO end

::============================
::|  SteamConsole Section    |
::============================
:steamconsole
cls
wget -N --no-parent --tries=3 --html-extension --secure-protocol=auto --no-check-certificate https://github.com/Teutonic84/SteamConsole/releases/ 2>NUL 1>NUL
FOR /F "tokens=6 delims=/ " %%f IN ('findstr /I " Teutonic84/SteamConsole/tree " index.html') DO (
    SET newversionsc="%%f
    GOTO nextsc
)
SET "steamconsole=SteamConsole Host Down Currently..."
GOTO retroarch

:nextsc
SET newversionsc=%newversionsc:"=%
SET regver=%newversionsc:v=%
SET "key=HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole"
FOR /f "tokens=3 delims= " %%g IN ('Reg query "%key%" /v DisplayVersion') DO SET "currentver=v%%g"
DEL /q "index.html"

cd "%dirpath%\Scripts\Updater"
if %currentver% == %newversionsc% GOTO NOUPSC

cls
ping haackerit.duckdns.org -n 1 2>NUL 1>NUL
if %errorlevel%==1 (
    SET "steamconsole=SteamConsole Host Down Currently..."
    GOTO retroarch
)
cls
echo Downloading SteamConsole %newversionsc% files...
wget --tries=3 --ftp-user=public --ftp-password="[anthakth15" --no-check-certificate --secure-protocol=auto "ftp://haackerit.duckdns.org/SteamConsole_%newversionsc%_x64.7z" 2>NUL 1>NUL
cls
echo Extracting SteamConsole %newversionsc% files...
7zG x -y -o"files\SteamConsole_%newversionsc%_x64" SteamConsole_%newversionsc%_x64.7z
DEL "SteamConsole_%newversionsc%_x64.7z"
cls
"..\..\Tools\Xpadder\Xpadder.exe" /C 2>NUL 1>NUL
ECHO Replacing old files with new ones...
IF EXIST "..\..\Steam_Shortcuts\Arcade" RMDIR /q /s "..\..\Steam_Shortcuts\Arcade" 2>NUL 1>NUL
IF EXIST "..\..\Steam_Shortcuts\Apps" MOVE /y "..\..\Steam_Shortcuts\Apps" "..\..\Emulators\ROMS\Apps"
IF EXIST "..\..\Emulators\ROMS\PSP\PPSSPP" RMDIR /s /q "..\..\Emulators\ROMS\PSP\PPSSPP"

MKDIR "Files\SteamConsole_%newversionsc%_x64\Root" 2>NUL 1>NUL
MOVE /y "Files\SteamConsole_%newversionsc%_x64\Changelog.rtf" "Files\SteamConsole_%newversionsc%_x64\Root\Changelog.rtf" 2>NUL 1>NUL
MOVE /y "Files\SteamConsole_%newversionsc%_x64\License.rtf" "Files\SteamConsole_%newversionsc%_x64\Root\License.rtf" 2>NUL 1>NUL
MOVE /y "Files\SteamConsole_%newversionsc%_x64\README.txt" "Files\SteamConsole_%newversionsc%_x64\Root\README.txt" 2>NUL 1>NUL
MOVE /y "Files\SteamConsole_%newversionsc%_x64\SteamConsole_uninstaller.exe" "%dirpath%\SteamConsole_uninstaller.exe" 2>NUL 1>NUL

robocopy "Files\SteamConsole_%newversionsc%_x64\Install Files" ..\..\..\SteamConsole\ "*.*" /E /XO /XD "DS4Tool-1.2.2" "DSTool-Reloaded" /MOVE 2>NUL 1>NUL
robocopy "Files\SteamConsole_%newversionsc%_x64\Root" ..\..\..\SteamConsole\ "*.*" /E /XO /MOVE 2>NUL 1>NUL

echo Windows Registry Editor Version 5.00 >"%dirpath%\Scripts\Updater\reg_add.reg"
echo. >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole] >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo "DisplayVersion"="%regver%" >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo "Version"="%regver%" >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo. >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo. >>"%dirpath%\Scripts\Updater\reg_add.reg"

REGEDIT /s "%dirpath%\Scripts\Updater\reg_add.reg"
DEL /q "%dirpath%\Scripts\Updater\reg_add.reg"

::=======================
::|  Cleanup Section    |
::=======================
:cleanup
cd "%~dp0%"
IF EXIST "..\steam.bat" (
    DEL /q "..\steam.bat"
)
IF EXIST "..\Steam_Open.bat" (
    DEL /q "..\Steam_Open.bat"
    COPY /y "steam.bat" "..\Steam_Open.bat"
)
IF NOT EXIST "..\Steam_Open.bat" (
    COPY /y "steam.bat" "..\Steam_Open.bat"
)

cd "%dirpath%\Tools\Ice"
start "" "%dirpath%\Tools\Xpadder\Xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
CALL "%dirpath%\Tools\Ice\Ice-Initial-Run.bat"
CALL "%dirpath%\Tools\Ice\Ice.exe"
DEL /F /Q "%dirpath%\Tools\Ice\config.txt"
COPY /Y "%dirpath%\Tools\Ice\config_blank.txt" "%dirpath%\Tools\Ice\config.txt"
DEL /F /Q "%dirpath%\Tools\Ice\emulators.txt"
COPY /Y "%dirpath%\Tools\Ice\emulators_blank.txt" "%dirpath%\Tools\Ice\emulators.txt"
DEL /F /Q "%dirpath%\Tools\Ice\consoles.txt"
COPY /Y "%dirpath%\Tools\Ice\consoles_blank.txt" "%dirpath%\Tools\Ice\consoles.txt"
DEL /F /Q "%dirpath%\steam_path.txt"
cls
cd "%dirpath%\Scripts\Updater"
ECHO SteamConsole successfully updated to %newversionsc%...
SET "steamconsole=SteamConsole Updated to %newversionsc%..."
GOTO retroarch

:NOUPSC
echo.
echo.
echo ======================================
echo   SteamConsole already up to date...
echo ======================================
echo.
echo.
SET "steamconsole=SteamConsole already up to date..."

::=======================
::|  RetroArch Section  |
::=======================
:retroarch
SET /P olddate=<date.txt
SET datef=%date:~-4%-%date:~4,2%-%date:~7,2%
::SET day=%date:~7,2%
::SET /a day=%day%-1
::SET datef=%date:~-4%-%date:~4,2%-%day%
if %olddate%==%datef% (
	SET "retroarch=RetroArch EXE Already Up To Date."
	GOTO cores
)
echo %datef%>date.txt

::Download RetroArch Program Package:
::==================================
cls
echo Downloading RetroArch Nightly Build %datef%...
SET link=http://buildbot.libretro.com/nightly/windows/x86_64/%datef%_RetroArch.7z
SET link2=http://buildbot.libretro.com/nightly/windows/x86_64/redist.7z
wget --tries=3 --no-check-certificate %link% 2>NUL 1>NUL
if %errorlevel%==1 GOTO yesterday
GOTO download

:yesterday
SET day=%date:~7,2%
SET /a day=%day%-1
SET datef=%date:~-4%-%date:~4,2%-%day%

::Download RetroArch Program Package:
::==================================
cls
echo Downloading RetroArch Nightly Build %datef%...
SET link=http://buildbot.libretro.com/nightly/windows/x86_64/%datef%_RetroArch.7z
SET link2=http://buildbot.libretro.com/nightly/windows/x86_64/redist.7z
wget --tries=3 --no-check-certificate %link% 2>NUL 1>NUL
if %errorlevel%==1 (
    SET "retroarch=RetroArch No nightly build for today. Try again tomorrow."
    GOTO cores
)
cls

:download
echo Downloading RetroArch Redist %datef%...
wget --tries=3 --no-check-certificate %link2% 2>NUL 1>NUL
cls
IF NOT EXIST "%datef%_RetroArch.7z" (
    ECHO Download of RetroArch core files failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues
	SET "retroarch=Download of RetroArch core files failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues"
	GOTO cores
)
IF NOT EXIST "redist.7z" (
    ECHO Download of RetroArch redist files failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues
	SET "retroarch=Download of RetroArch redist files failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues"
	GOTO cores
)
echo Extracting RetroArch Nightly %datef%...
7zG x -y -o"files\RetroArch" %datef%_RetroArch.7z
7zG x -y -o"files\RetroArch-redist" redist.7z
DEL /q %datef%_RetroArch.7z 2>NUL 1>NUL
DEL /q redist.7z 2>NUL 1>NUL
cls
echo Replacing old files with new ones...
robocopy Files\RetroArch ..\..\Emulators\RetroArch\ /E /XO /MOVE 2>NUL 1>NUL
robocopy Files\RetroArch-redist ..\..\Emulators\RetroArch\ /E /XO /MOVE 2>NUL 1>NUL
SET "retroarch=RetroArch updated to %datef%..."

::=====================
::|  Cores Section    |
::=====================
:cores
cls
echo Downloading latest RetroArch cores...
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
echo Updating RetroArch cores...
move /y "*.info" ..\..\Emulators\RetroArch\info\ 2>NUL 1>NUL
robocopy "Files\RetroArch_Cores" ..\..\Emulators\RetroArch\cores\ /E /XO /MOVE 2>NUL 1>NUL
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
if %version% == %newversion% GOTO NOUP

cls
ECHO Downloading PCSX2 %newversion% files...
wget -Q7m --tries=3 --reject css,html --mirror -p --convert-links -P files\PCSX2 "https://buildbot.orphis.net/pcsx2/index.php" 2>NUL 1>NUL
cls
IF NOT EXIST "Files\PCSX2\buildbot.orphis.net\pcsx2\index.php@m=dl&rev=%newversion%&platform=windows-x86" (
    ECHO Download of PCSX2 failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues
	SET "pcsx2=Download of PCSX2 failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues"
	GOTO dolphin
)
ECHO Extracting PCSX2 %newversion% files...
7zG x -y -o"files\PCSX2" "Files\PCSX2\buildbot.orphis.net\pcsx2\index.php@m=dl&rev=%newversion%&platform=windows-x86"
cls
echo Replacing old files with new ones...
robocopy "Files\PCSX2\pcsx2-%newversion%-windows-x86" ..\..\Emulators\PS2\PCSX2\ /E /XO /MOVE 2>NUL 1>NUL
copy /y portable.ini "..\..\Emulators\PS2\PCSX2\portable.ini" 2>NUL 1>NUL
"..\..\Emulators\PS2\PCSX2\4gb_patch.exe" ..\..\Emulators\PS2\pcsx2\pcsx2.exe

IF EXIST "files\PCSX2" RMDIR /s /q "files\PCSX2" 2>NUL 1>NUL
@echo %newversion%>version_pcsx2.txt
echo PCSX2 successfully updated to %newversion%...
SET "pcsx2=PCSX2 Updated to %newversion%..."
GOTO dolphin

:NOUP
echo.
echo.
echo ======================================
echo   PCSX2 already up to date...
echo ======================================
echo.
echo.
SET "pcsx2=PCSX2 already up to date..."

::=======================
::|  Dolphin Section    |
::=======================
:dolphin
cls
wget -N --tries=3 --no-parent --html-extension --secure-protocol=tlsv1 --no-check-certificate https://dolphin-emu.org/download/ 2>NUL 1>NUL
FOR /F "tokens=2 delims=)(" %%a IN ('findstr /I " \<(.* " index.html') DO (
    SET "newversion2=%%a"
    GOTO next
)
SET "dolphin=Dolphin Host Down Currently..."
GOTO complete

:next
SET /p version2=<version_dolphin.txt
DEL /q "index.html" 2>NUL 1>NUL

if %version2% == %newversion2% GOTO NOUP2

SET link=http://dl.dolphin-emu.org/builds/dolphin-master-%newversion2%-x64.7z
cls
echo Downloading Dolphin %newversion2% files...
wget --tries=3 --no-check-certificate %link% 2>NUL 1>NUL
cls
IF NOT EXIST "dolphin-master-%newversion2%-x64.7z" (
    ECHO Download of Dolphin failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues
	SET "pcsx2=Download of Dolphin failed. Open an issue at https://github.com/Teutonic84/SteamConsole/issues"
	GOTO complete
)
echo Extracting Dolphin %newversion2% files...
7zG x -y -o"files\" dolphin-master-%newversion2%-x64.7z
DEL dolphin-master-%newversion2%-x64.7z 2>NUL 1>NUL
cls
echo Replacing old files with new ones...
@echo %newversion2%>version_dolphin.txt
robocopy Files\Dolphin-x64 ..\..\Emulators\Gamecube\Dolphin\ /E /XO /MOVE 2>NUL 1>NUL

IF EXIST "Dolphin-x64" RMDIR /s /q Dolphin-x64 2>NUL 1>NUL
cls
echo Dolphin successfully updated to %newversion2%...
SET "dolphin=Dolphin Updated to %newversion2%..."
GOTO complete

:NOUP2
echo.
echo.
echo ======================================
echo   Dolphin already up to date...
echo ======================================
echo.
echo.
SET "dolphin=Dolphin already up to date..."

:complete
IF EXIST "Files\" (RMDIR /q /s Files)
IF EXIST "%datef%_RetroArch.7z" (DEL /q %datef%_RetroArch.7z)
IF EXIST "dolphin-master-%newversion%-x64.7z" (DEL /q dolphin-master-%newversion%-x64.7z)
cls
echo.
echo ======================================
echo   %steamconsole%
echo ======================================
echo.
echo ======================================
echo   %pcsx2%
echo ======================================
echo.
echo ======================================
echo   %dolphin%
echo ======================================
echo.
echo ======================================
echo   %retroarch%
ECHO   %cores%
echo ======================================
echo.
echo.
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"
start "" "%dirpath%\Tools\Xpadder\Xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
pause
start "" "%steampath%\Steam.exe" -start steam://open/bigpicture
GOTO end

:nochange
IF EXIST "Files\" (RMDIR /q /s Files)
IF EXIST "%datef%_RetroArch.7z" (DEL /q %datef%_RetroArch.7z)
IF EXIST "dolphin-master-%newversion%-x64.7z" (DEL /q dolphin-master-%newversion%-x64.7z)
cls
echo.
echo ======================================
echo   %steamconsole%
echo ======================================
echo.
echo ======================================
echo   %pcsx2%
echo ======================================
echo.
echo ======================================
echo   %dolphin%
echo ======================================
echo.
echo ======================================
echo   RetroArch already up to date... 
echo ======================================
echo.
echo.
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"
start "" "%dirpath%\Tools\Xpadder\Xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
pause
start "" "%steampath%\Steam.exe" -start steam://open/bigpicture
GOTO end

:end
exit