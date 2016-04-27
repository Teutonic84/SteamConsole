@echo off
cls
cd ..\..
set "dirpath=%cd%"
cd "%dirpath%\Scripts\Updater"

if not exist "..\..\Images" (mkdir ..\..\Images)
if not exist "files" (mkdir Files)

::taskkill /T /IM "ScpService.exe"
taskkill /f /im "Custom Hotkeys.exe"
taskkill /f /im "Steam.exe"
"..\..\Tools\Xpadder\Xpadder.exe" /C

:steampath
if exist "..\..\steam_path.txt" del "..\..\steam_path.txt"
cscript.exe "..\steam_path_check.vbs" > "..\..\steam_path.txt"

for /F "usebackq delims=" %%i in ("..\..\steam_path.txt") do set "steampath=%%i"
del "..\..\steam_path.txt"

::=======================
::|  Updater Section    |
::=======================
:updater
cls
wget -N --no-parent --tries=3 --html-extension --secure-protocol=tlsv1 --no-check-certificate https://github.com/Teutonic84/SteamConsole/releases/
for /F "tokens=8 delims=/ " %%h in ('findstr /I " Updater_ " index.html') do (
    set "newversionup=%%h"
    goto nextup
)
set "updater=Updater Host Down Currently..."
del /q "index.html"
goto steamconsole

:nextup
cls
del /q "index.html"
set newversionup=%newversionup:Updater_v=%
set newversionup=%newversionup:.7z"=%
set "key=HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole"

Reg query "%key%" /v Updater
if %errorlevel%==1 goto update

for /f "tokens=3 delims= " %%i in ('Reg query "%key%" /v Updater') do set "currentver=%%i"
if %currentver% == %newversionup% goto steamconsole

:update
cls
ping haackerit.duckdns.org -n 1
if %errorlevel%==1 (
    set "updater=Updater Host Down Currently..."
    goto steamconsole
)
wget --tries=3 --ftp-user=public --ftp-password="[anthakth15" --no-check-certificate --secure-protocol=auto "ftp://haackerit.duckdns.org/Updater_v%newversionup%.7z"

7za x -y -o"files\Updater_v%newversionup%" Updater_v%newversionup%.7z
del "Updater_v%newversionup%.7z"

robocopy "Files\Updater_v%newversionup%\Updater" ..\..\..\SteamConsole\Scripts\Updater "*.*" /E /XO /MOVE

echo Windows Registry Editor Version 5.00 >"%dirpath%\Scripts\Updater\reg_add.reg"
echo. >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole] >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo "Updater"="%newversionup%" >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo. >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo. >>"%dirpath%\Scripts\Updater\reg_add.reg"

regedit /s "%dirpath%\Scripts\Updater\reg_add.reg"
del /q "%dirpath%\Scripts\Updater\reg_add.reg"

if exist "files\Updater_v%newversionup%" rmdir /s /q "files\Updater_v%newversionup%"
cls
echo.
echo.
echo ============================================================================
echo   Updater Updated to %newversionup%. Please close updater and run it again.
echo ============================================================================
echo.
echo.
pause
goto end

::============================
::|  SteamConsole Section    |
::============================
:steamconsole
cls
wget -N --no-parent --tries=3 --html-extension --secure-protocol=tlsv1 --no-check-certificate https://github.com/Teutonic84/SteamConsole/releases/
for /F "tokens=6 delims=/ " %%f in ('findstr /I " Teutonic84/SteamConsole/tree " index.html') do (
    set newversionsc="%%f
    goto nextsc
)
set "steamconsole=SteamConsole Host Down Currently..."
goto cores

:nextsc
set newversionsc=%newversionsc:"=%
set regver=%newversionsc:v=%
set "key=HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole"
for /f "tokens=3 delims= " %%g in ('Reg query "%key%" /v DisplayVersion') do set "currentver=v%%g"
del /q "index.html"

if %currentver% == %newversionsc% goto NOUPSC

cls
ping haackerit.duckdns.org -n 1
if %errorlevel%==1 (
    set "steamconsole=SteamConsole Host Down Currently..."
    goto cores
)
wget --tries=3 --ftp-user=public --ftp-password="[anthakth15" --no-check-certificate --secure-protocol=auto "ftp://haackerit.duckdns.org/SteamConsole_%newversionsc%_x64.7z"

7za x -y -o"files\SteamConsole_%newversionsc%_x64" SteamConsole_%newversionsc%_x64.7z
del "SteamConsole_%newversionsc%_x64.7z"

mkdir "Files\SteamConsole_%newversionsc%_x64\Root"
move /y "Files\SteamConsole_%newversionsc%_x64\Changelog.rtf" "Files\SteamConsole_%newversionsc%_x64\Root\Changelog.rtf"
move /y "Files\SteamConsole_%newversionsc%_x64\License.rtf" "Files\SteamConsole_%newversionsc%_x64\Root\License.rtf"
move /y "Files\SteamConsole_%newversionsc%_x64\README.txt" "Files\SteamConsole_%newversionsc%_x64\Root\README.txt"
move /y "Files\SteamConsole_%newversionsc%_x64\SteamConsole_uninstaller.exe" "Files\SteamConsole_%newversionsc%_x64\Root\SteamConsole_uninstaller.exe"

robocopy "Files\SteamConsole_%newversionsc%_x64\Install Files" ..\..\..\SteamConsole\ "*.*" /E /XO /XD "DS4Tool-1.2.2" "DSTool-Reloaded" /MOVE
robocopy "Files\SteamConsole_%newversionsc%_x64\Root" ..\..\..\SteamConsole\ "*.*" /E /XO /MOVE

echo Windows Registry Editor Version 5.00 >"%dirpath%\Scripts\Updater\reg_add.reg"
echo. >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole] >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo "DisplayVersion"="%regver%" >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo "Version"="%regver%" >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo. >>"%dirpath%\Scripts\Updater\reg_add.reg"
echo. >>"%dirpath%\Scripts\Updater\reg_add.reg"

regedit /s "%dirpath%\Scripts\Updater\reg_add.reg"
del /q "%dirpath%\Scripts\Updater\reg_add.reg"

::=======================
::|  Cleanup Section    |
::=======================
:cleanup

if exist "..\steam.bat" (
    del /q "..\steam.bat"
    copy /y "steam.bat" "..\steam.bat"
)
if exist "Files\SteamConsole_%newversionsc%_x64" rmdir /s /q "Files\SteamConsole_%newversionsc%_x64"
if exist "..\..\Emulators\Updater" rmdir /s /q "..\..\Emulators\Updater"
if exist "..\..\Emulators\Gamecube\Dolphin\Updater" rmdir /s /q "..\..\Emulators\Gamecube\Dolphin\Updater"
if exist "..\..\Steam_Shortcuts\PC_Games" rmdir /s /q "..\..\Steam_Shortcuts\PC_Games"
if exist "..\..\Emulators\RetroArch_x64" rename "..\..\Emulators\RetroArch_x64" RetroArch
if exist "..\..\Steam_Grid_Images" move "..\..\Steam_Grid_Images" "..\..\Images"
if exist "..\..\steam_path_check.vbs" del /q "..\..\steam_path_check.vbs"
if exist "..\..\steam_path_check_x64.vbs" del /q "..\..\steam_path_check_x64.vbs"
if exist "..\..\steam_path_check_x86.vbs" del /q "..\..\steam_path_check_x86.vbs"
if exist "..\..\replace.vbs" del /q "..\..\replace.vbs"
if exist "..\..\replace2.vbs" del /q "..\..\replace2.vbs"
if exist "..\..\Shortcut.exe" del /q "..\..\Shortcut.exe"
if exist "..\..\Scripts\Logoff.bat" del /q "..\..\Scripts\Logoff.bat"
if exist "..\..\Scripts\ROM_Rename.bat" del /q "..\..\Scripts\ROM_Rename.bat"
if exist "..\..\Scripts\ROM_Shortcut_Blank_Dolphin.bat" del /q "..\..\Scripts\ROM_Shortcut_Blank_Dolphin.bat"
if exist "..\..\Scripts\ROM_Shortcut_Blank_ePSXe.bat" del /q "..\..\Scripts\ROM_Shortcut_Blank_ePSXe.bat"
if exist "..\..\Scripts\ROM_Shortcut_Blank_PCSX2.bat" del /q "..\..\Scripts\ROM_Shortcut_Blank_PCSX2.bat"
if exist "..\..\Scripts\Services.bat" del /q "..\..\Scripts\Services.bat"

set "steamconsole=SteamConsole Updated to %newversionsc%..."
goto cores

:NOUPSC
echo.
echo.
echo ======================================
echo   SteamConsole already up to date...
echo ======================================
echo.
echo.
set "steamconsole=SteamConsole already up to date..."

::=====================
::|  Cores Section    |
::=====================
:cores

wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/mupen64plus_libretro.dll.zip
wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/desmume_libretro.dll.zip
wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/genesis_plus_gx_libretro.dll.zip
wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_psx_libretro.dll.zip
wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/nestopia_libretro.dll.zip
wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/ppsspp_libretro.zip
wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/snes9x_libretro.dll.zip
wget --tries=3 http://buildbot.libretro.com/nightly/windows/x86_64/latest/vbam_libretro.dll.zip

7za x -y -o"files\RetroArch_Cores" "mupen64plus_libretro.dll.zip"
7za x -y -o"files\RetroArch_Cores" "desmume_libretro.dll.zip"
7za x -y -o"files\RetroArch_Cores" "genesis_plus_gx_libretro.dll.zip"
7za x -y -o"files\RetroArch_Cores" "mednafen_psx_libretro.dll.zip"
7za x -y -o"files\RetroArch_Cores" "nestopia_libretro.dll.zip"
7za x -y -o"files\RetroArch_Cores" "ppsspp_libretro.zip"
7za x -y -o"files\RetroArch_Cores" "snes9x_libretro.dll.zip"
7za x -y -o"files\RetroArch_Cores" "vbam_libretro.dll.zip"

del mupen64plus_libretro.dll.zip
del desmume_libretro.dll.zip
del genesis_plus_gx_libretro.dll.zip
del mednafen_psx_libretro.dll.zip
del nestopia_libretro.dll.zip
del ppsspp_libretro.zip
del snes9x_libretro.dll.zip
del vbam_libretro.dll.zip

robocopy "Files\RetroArch_Cores" ..\..\Emulators\RetroArch\cores\ /E /XO /MOVE
if exist "files\RetroArch_Cores" rmdir /s /q "files\RetroArch_Cores"

::=====================
::|  PCSX2 Section    |
::=====================
:pcsx2
set /p version=<version_pcsx2.txt
wget -N --tries=3 --no-parent --html-extension --secure-protocol=tlsv1 --no-check-certificate "http://buildbot.orphis.net/pcsx2/index.php"
for /F "tokens=4 delims=><" %%a in ('findstr /I " \<v1.* " index.php.html') do (
    set "newversion=%%a"
    goto vercheck
)
set "pcsx2=PCSX2 Host Down Currently..."
goto dolphin

:vercheck
del /q index.php.html
cls
if %version% == %newversion% goto NOUP

wget -Q7m --tries=3 --reject css,html --mirror -p --convert-links -P files\PCSX2 "http://buildbot.orphis.net/pcsx2/index.php"

7za x -y -o"files\PCSX2" "Files\PCSX2\buildbot.orphis.net\pcsx2\index.php@m=get&rev=%newversion%&platform=windows-x86"
robocopy "Files\PCSX2\pcsx2-%newversion%-windows-x86" ..\..\Emulators\PS2\PCSX2\ /E /XO /MOVE
copy /y portable.ini "..\..\Emulators\PS2\PCSX2\portable.ini"
"..\..\Emulators\PS2\PCSX2\4gb_patch.exe" ..\..\Emulators\PS2\pcsx2\pcsx2.exe

if exist "files\PCSX2" rmdir /s /q "files\PCSX2"
@echo %newversion%>version_pcsx2.txt
set "pcsx2=PCSX2 Updated to %newversion%..."
goto dolphin

:NOUP
echo.
echo.
echo ======================================
echo   PCSX2 already up to date...
echo ======================================
echo.
echo.
set "pcsx2=PCSX2 already up to date..."

::=======================
::|  Dolphin Section    |
::=======================
:dolphin
echo Dolphin Updater 1.0 by Drakekilla

wget -N --tries=3 --no-parent --html-extension --secure-protocol=tlsv1 --no-check-certificate https://dolphin-emu.org/download/

for /F "tokens=2 delims=)(" %%a in ('findstr /I " \<(.* " index.html') do (
    set "newversion2=%%a"
    goto next
)
set "dolphin=Dolphin Host Down Currently..."
goto retroarch

:next
set /p version2=<version_dolphin.txt
del /q "index.html"

if %version2% == %newversion2% goto NOUP2

set link=http://dl.dolphin-emu.org/builds/dolphin-master-%newversion2%-x64.7z
cls
wget --tries=3 --no-check-certificate %link%
7za x -y -o"files\" dolphin-master-%newversion2%-x64.7z
::7za x dolphin-master-%newversion2%-x64.7z
del dolphin-master-%newversion2%-x64.7z

@echo %newversion2%>version_dolphin.txt
robocopy Files\Dolphin-x64 ..\..\Emulators\Gamecube\Dolphin\ /E /XO /MOVE
if exist "Dolphin-x64" rmdir /s /q Dolphin-x64
set "dolphin=Dolphin Updated to %newversion2%..."
goto retroarch

:NOUP2
echo.
echo.
echo ======================================
echo   Dolphin already up to date...
echo ======================================
echo.
echo.
set "dolphin=Dolphin already up to date..."

::=======================
::|  RetroArch Section  |
::=======================
:retroarch
set /P olddate=<date.txt
set datef=%date:~-4%-%date:~4,2%-%date:~7,2%
if %olddate%==%datef% goto :nochange
echo %datef%>date.txt

::Download RetroArch Program Package:
::==================================

set link=http://buildbot.libretro.com/nightly/win-x86_64/%datef%_RetroArch.7z
set link2=http://buildbot.libretro.com/nightly/windows/x86_64/redist-x86_64.7z
wget --tries=3 --no-check-certificate %link%
if %errorlevel%==1 (
    set "retroarch=RetroArch No nightly build for today. Try again tomorrow."
    goto complete
)
wget --tries=3 --no-check-certificate %link2%

:next2
7za x -y -o"files\RetroArch" %datef%_RetroArch.7z
7za x -y -o"files\RetroArch-redist" redist-x86_64.7z
del /q %datef%_RetroArch.7z
del /q redist-x86_64.7z
robocopy Files\RetroArch ..\..\Emulators\RetroArch\ /E /XO /MOVE
robocopy Files\RetroArch-redist ..\..\Emulators\RetroArch\ /E /XO /MOVE
set "retroarch=RetroArch updated to %datef%..."

:complete
if exist "Files\" (rmdir /q /s Files)
if exist "%datef%_RetroArch.7z" (del /q %datef%_RetroArch.7z)
if exist "dolphin-master-%newversion%-x64.7z" (del /q dolphin-master-%newversion%-x64.7z)
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
echo ======================================
echo.
echo.
start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"
start "" "%dirpath%\Tools\Xpadder\Xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
pause
start "" "%steampath%\Steam.exe" -start steam://open/bigpicture
goto end

:nochange
if exist "Files\" (rmdir /q /s Files)
if exist "%datef%_RetroArch.7z" (del /q %datef%_RetroArch.7z)
if exist "dolphin-master-%newversion%-x64.7z" (del /q dolphin-master-%newversion%-x64.7z)
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
goto end

:end
exit