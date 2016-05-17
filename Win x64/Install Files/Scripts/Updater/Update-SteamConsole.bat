@echo off
cls
cd ..\..
set "dirpath=%cd%"
cd "%dirpath%\Scripts\Updater"

if not exist "..\..\Images" (mkdir ..\..\Images)
if not exist "files" (mkdir Files)

::taskkill /T /IM "ScpService.exe" 2>NUL 1>NUL
taskkill /f /im "Custom Hotkeys.exe" 2>NUL 1>NUL
taskkill /f /im "Steam.exe" 2>NUL 1>NUL
::"..\..\Tools\Xpadder\Xpadder.exe" /C 2>NUL 1>NUL

if exist "Files\SteamConsole_%newversionsc%_x64" rmdir /s /q "Files\SteamConsole_%newversionsc%_x64" 2>NUL 1>NUL
if exist "..\..\Emulators\Updater" rmdir /s /q "..\..\Emulators\Updater" 2>NUL 1>NUL
if exist "Update-Emulators.bat" del /q "Update-Emulators.bat" 2>NUL 1>NUL
if exist "..\..\Emulators\Gamecube\Dolphin\Updater" rmdir /s /q "..\..\Emulators\Gamecube\Dolphin\Updater" 2>NUL 1>NUL
if exist "..\..\Steam_Shortcuts\PC_Games" rmdir /s /q "..\..\Steam_Shortcuts\PC_Games" 2>NUL 1>NUL
if exist "..\..\Emulators\RetroArch_x64" rename "..\..\Emulators\RetroArch_x64" RetroArch 2>NUL 1>NUL
if exist "..\..\Steam_Grid_Images" move "..\..\Steam_Grid_Images" "..\..\Images" 2>NUL 1>NUL
if exist "..\..\steam_path_check.vbs" move /y "..\..\steam_path_check.vbs" "..\..\Scripts\steam_path_check.vbs" 2>NUL 1>NUL
if exist "..\..\steam_path_check_x64.vbs" move /y "..\..\steam_path_check_x64.vbs" "..\..\Scripts\steam_path_check.vbs" 2>NUL 1>NUL
if exist "..\..\steam_path_check_x86.vbs" del /q "..\..\steam_path_check_x86.vbs" 2>NUL 1>NUL
if exist "..\..\replace.vbs" del /q "..\..\replace.vbs" 2>NUL 1>NUL
if exist "..\..\replace2.vbs" del /q "..\..\replace2.vbs" 2>NUL 1>NUL
if exist "..\..\Shortcut.exe" del /q "..\..\Shortcut.exe" 2>NUL 1>NUL
if exist "..\..\Scripts\Logoff.bat" del /q "..\..\Scripts\Logoff.bat" 2>NUL 1>NUL
if exist "..\..\Scripts\ROM_Rename.bat" del /q "..\..\Scripts\ROM_Rename.bat" 2>NUL 1>NUL
if exist "..\..\Scripts\ROM_Shortcut_Blank_Dolphin.bat" del /q "..\..\Scripts\ROM_Shortcut_Blank_Dolphin.bat" 2>NUL 1>NUL
if exist "..\..\Scripts\ROM_Shortcut_Blank_ePSXe.bat" del /q "..\..\Scripts\ROM_Shortcut_Blank_ePSXe.bat" 2>NUL 1>NUL
if exist "..\..\Scripts\ROM_Shortcut_Blank_PCSX2.bat" del /q "..\..\Scripts\ROM_Shortcut_Blank_PCSX2.bat" 2>NUL 1>NUL
if exist "..\..\Scripts\Steam_Open.bat" del /q "..\..\Scripts\Steam_Open.bat" 2>NUL 1>NUL
if exist "..\..\Scripts\Services.bat" del /q "..\..\Scripts\Services.bat" 2>NUL 1>NUL

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
wget -N --no-parent --tries=3 --html-extension --secure-protocol=tlsv1 --no-check-certificate https://github.com/Teutonic84/SteamConsole/releases/ 2>NUL 1>NUL
for /F "tokens=8 delims=/ " %%h in ('findstr /I " Updater_ " index.html') do (
    set "newversionup=%%h"
    goto nextup
)
set "updater=Updater Host Down Currently..."
del /q "index.html" 2>NUL 1>NUL
goto steamconsole

:nextup
cls
del /q "index.html" 2>NUL 1>NUL
set newversionup=%newversionup:Updater_v=%
set newversionup=%newversionup:.7z"=%
set "key=HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole"

Reg query "%key%" /v Updater 2>NUL 1>NUL
if %errorlevel%==1 goto update

for /f "tokens=3 delims= " %%i in ('Reg query "%key%" /v Updater') do set "currentver=%%i"
if %currentver% == %newversionup% goto steamconsole

:update
cls
ping haackerit.duckdns.org -n 1 2>NUL 1>NUL
if %errorlevel%==1 (
    set "updater=Updater Host Down Currently..."
    goto steamconsole
)
cls
echo Downloading SteamConsole Updater v%newversionup% files...
wget --tries=3 --ftp-user=public --ftp-password="[anthakth15" --no-check-certificate --secure-protocol=auto "ftp://haackerit.duckdns.org/Updater_v%newversionup%.7z" 2>NUL 1>NUL
cls
echo Extracting SteamConsole Updater v%newversionup% files...
7zG x -y -o"files\Updater_v%newversionup%" Updater_v%newversionup%.7z
del "Updater_v%newversionup%.7z"
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
wget -N --no-parent --tries=3 --html-extension --secure-protocol=tlsv1 --no-check-certificate https://github.com/Teutonic84/SteamConsole/releases/ 2>NUL 1>NUL
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

cd "%dirpath%\Tools\Ice"
if "%currentver%" LSS "v1.3.4" (
    echo Removing old Steam shortcuts before Ice 1.0.0 import
    if exist "..\..\Steam_Shortcuts" del /q /s "..\..\Steam_Shortcuts\*.*" 2>NUL 1>NUL
    >"config-new.txt" (
        for /f "usebackq delims=" %%A in ("config.txt") do (
        if "%%A" equ "ROMs Directory=" (echo ROMS Directory=%dirpath%\Steam_Shortcuts) else (echo %%A)
        )
    )
    del /F /Q "%dirpath%\Tools\Ice\config.txt"
    rename "%dirpath%\Tools\Ice\config-new.txt" config.txt
    call "%dirpath%\Tools\Ice\Ice.exe"
    del /F /Q "%dirpath%\Tools\Ice\config.txt"
    copy /Y "%dirpath%\Tools\Ice\config_blank.txt" "%dirpath%\Tools\Ice\config.txt"
)
cd "%dirpath%\Scripts\Updater"
if %currentver% == %newversionsc% goto NOUPSC

cls
ping haackerit.duckdns.org -n 1 2>NUL 1>NUL
if %errorlevel%==1 (
    set "steamconsole=SteamConsole Host Down Currently..."
    goto cores
)
cls
echo Downloading SteamConsole %newversionsc% files...
wget --tries=3 --ftp-user=public --ftp-password="[anthakth15" --no-check-certificate --secure-protocol=auto "ftp://haackerit.duckdns.org/SteamConsole_%newversionsc%_x64.7z" 2>NUL 1>NUL
cls
echo Extracting SteamConsole %newversionsc% files...
7zG x -y -o"files\SteamConsole_%newversionsc%_x64" SteamConsole_%newversionsc%_x64.7z
del "SteamConsole_%newversionsc%_x64.7z"
cls
"..\..\Tools\Xpadder\Xpadder.exe" /C 2>NUL 1>NUL
echo Replacing old files with new ones...
if exist "..\..\Steam_Shortcuts\Arcade" del /q /s "..\..\Steam_Shortcuts\Arcade\*.*" 2>NUL 1>NUL
mkdir "Files\SteamConsole_%newversionsc%_x64\Root" 2>NUL 1>NUL
move /y "Files\SteamConsole_%newversionsc%_x64\Changelog.rtf" "Files\SteamConsole_%newversionsc%_x64\Root\Changelog.rtf" 2>NUL 1>NUL
move /y "Files\SteamConsole_%newversionsc%_x64\License.rtf" "Files\SteamConsole_%newversionsc%_x64\Root\License.rtf" 2>NUL 1>NUL
move /y "Files\SteamConsole_%newversionsc%_x64\README.txt" "Files\SteamConsole_%newversionsc%_x64\Root\README.txt" 2>NUL 1>NUL
move /y "Files\SteamConsole_%newversionsc%_x64\SteamConsole_uninstaller.exe" "%dirpath%\SteamConsole_uninstaller.exe" 2>NUL 1>NUL

robocopy "Files\SteamConsole_%newversionsc%_x64\Install Files" ..\..\..\SteamConsole\ "*.*" /E /XO /XD "DS4Tool-1.2.2" "DSTool-Reloaded" /MOVE 2>NUL 1>NUL
robocopy "Files\SteamConsole_%newversionsc%_x64\Root" ..\..\..\SteamConsole\ "*.*" /E /XO /MOVE 2>NUL 1>NUL

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

if not exist "..\Steam_Open.bat" (
    del /q "..\steam.bat" 2>NUL 1>NUL
    copy /y "steam.bat" "..\Steam_Open.bat"
)
if exist "..\Steam_Open.bat" (
    del /q "..\steam.bat"
    copy /y "steam.bat" "..\Steam_Open.bat"
)
cd "%dirpath%\Tools\Ice"
start "" "%dirpath%\Tools\Xpadder\Xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
call "%dirpath%\Tools\Ice\Ice-Initial-Run.bat"
call "%dirpath%\Tools\Ice\Ice.exe"
del /F /Q "%dirpath%\Tools\Ice\config.txt"
copy /Y "%dirpath%\Tools\Ice\config_blank.txt" "%dirpath%\Tools\Ice\config.txt"
del /F /Q "%dirpath%\Tools\Ice\emulators.txt"
copy /Y "%dirpath%\Tools\Ice\emulators_blank.txt" "%dirpath%\Tools\Ice\emulators.txt"
del /F /Q "%dirpath%\Tools\Ice\consoles.txt"
copy /Y "%dirpath%\Tools\Ice\consoles_blank.txt" "%dirpath%\Tools\Ice\consoles.txt"
del /F /Q "%dirpath%\steam_path.txt"
cls
cd "%dirpath%\Scripts\Updater"
echo SteamConsole successfully updated to %newversionsc%...
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
echo Extracting RetroArch cores...
if not exist "files\RetroArch_Cores" mkdir "files\RetroArch_Cores"
7zG x -y -o"files\RetroArch_Cores" "mupen64plus_libretro.dll.zip"
7zG x -y -o"files\RetroArch_Cores" "desmume_libretro.dll.zip"
7zG x -y -o"files\RetroArch_Cores" "genesis_plus_gx_libretro.dll.zip"
7zG x -y -o"files\RetroArch_Cores" "mednafen_psx_libretro.dll.zip"
7zG x -y -o"files\RetroArch_Cores" "nestopia_libretro.dll.zip"
7zG x -y -o"files\RetroArch_Cores" "ppsspp_libretro.dll.zip"
7zG x -y -o"files\RetroArch_Cores" "snes9x_libretro.dll.zip"
7zG x -y -o"files\RetroArch_Cores" "vbam_libretro.dll.zip"

del "mupen64plus_libretro.dll.zip" 2>NUL 1>NUL
del "desmume_libretro.dll.zip" 2>NUL 1>NUL
del "genesis_plus_gx_libretro.dll.zip" 2>NUL 1>NUL
del "mednafen_psx_libretro.dll.zip" 2>NUL 1>NUL
del "nestopia_libretro.dll.zip" 2>NUL 1>NUL
del "ppsspp_libretro.dll.zip" 2>NUL 1>NUL
del "snes9x_libretro.dll.zip" 2>NUL 1>NUL
del "vbam_libretro.dll.zip" 2>NUL 1>NUL
cls
echo Replacing new files with old ones...
move /y "*.info" ..\..\Emulators\RetroArch\info\ 2>NUL 1>NUL
robocopy "Files\RetroArch_Cores" ..\..\Emulators\RetroArch\cores\ /E /XO /MOVE 2>NUL 1>NUL
if exist "files\RetroArch_Cores" rmdir /s /q "files\RetroArch_Cores" 2>NUL 1>NUL

::=====================
::|  PCSX2 Section    |
::=====================
:pcsx2
set /p version=<version_pcsx2.txt
wget -N --tries=3 --no-parent --html-extension --secure-protocol=tlsv1 --no-check-certificate "http://buildbot.orphis.net/pcsx2/index.php" 2>NUL 1>NUL
for /F "tokens=4 delims=><" %%a in ('findstr /I " \<v1.* " index.php.html') do (
    set "newversion=%%a"
    goto vercheck
)
set "pcsx2=PCSX2 Host Down Currently..."
goto dolphin

:vercheck
del /q index.php.html 2>NUL 1>NUL
cls
if %version% == %newversion% goto NOUP

cls
echo Downloading PCSX2 %newversion% files...
wget -Q7m --tries=3 --reject css,html --mirror -p --convert-links -P files\PCSX2 "http://buildbot.orphis.net/pcsx2/index.php" 2>NUL 1>NUL
cls
echo Extracting PCSX2 %newversion% files...
7zG x -y -o"files\PCSX2" "Files\PCSX2\buildbot.orphis.net\pcsx2\index.php@m=get&rev=%newversion%&platform=windows-x86"
cls
echo Replacing old files with new ones...
robocopy "Files\PCSX2\pcsx2-%newversion%-windows-x86" ..\..\Emulators\PS2\PCSX2\ /E /XO /MOVE 2>NUL 1>NUL
copy /y portable.ini "..\..\Emulators\PS2\PCSX2\portable.ini" 2>NUL 1>NUL
"..\..\Emulators\PS2\PCSX2\4gb_patch.exe" ..\..\Emulators\PS2\pcsx2\pcsx2.exe

if exist "files\PCSX2" rmdir /s /q "files\PCSX2" 2>NUL 1>NUL
@echo %newversion%>version_pcsx2.txt
echo PCSX2 successfully updated to %newversion%...
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
cls
wget -N --tries=3 --no-parent --html-extension --secure-protocol=tlsv1 --no-check-certificate https://dolphin-emu.org/download/ 2>NUL 1>NUL
for /F "tokens=2 delims=)(" %%a in ('findstr /I " \<(.* " index.html') do (
    set "newversion2=%%a"
    goto next
)
set "dolphin=Dolphin Host Down Currently..."
goto retroarch

:next
set /p version2=<version_dolphin.txt
del /q "index.html" 2>NUL 1>NUL

if %version2% == %newversion2% goto NOUP2

set link=http://dl.dolphin-emu.org/builds/dolphin-master-%newversion2%-x64.7z
cls
echo Downloading Dolphin %newversion2% files...
wget --tries=3 --no-check-certificate %link% 2>NUL 1>NUL
cls
echo Extracting Dolphin %newversion2% files...
7zG x -y -o"files\" dolphin-master-%newversion2%-x64.7z
del dolphin-master-%newversion2%-x64.7z 2>NUL 1>NUL
cls
echo Replacing old files with new ones...
@echo %newversion2%>version_dolphin.txt
robocopy Files\Dolphin-x64 ..\..\Emulators\Gamecube\Dolphin\ /E /XO /MOVE 2>NUL 1>NUL

if exist "Dolphin-x64" rmdir /s /q Dolphin-x64 2>NUL 1>NUL
cls
echo Dolphin successfully updated to %newversion2%...
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
wget --tries=3 --no-check-certificate %link% 2>NUL 1>NUL
if %errorlevel%==1 (
    set "retroarch=RetroArch No nightly build for today. Try again tomorrow."
    goto complete
)
cls
echo Downloading RetroArch Nightly %datef%...
wget --tries=3 --no-check-certificate %link2% 2>NUL 1>NUL
cls
echo Extracting RetroArch Nightly %datef%...
7zG x -y -o"files\RetroArch" %datef%_RetroArch.7z
7zG x -y -o"files\RetroArch-redist" redist-x86_64.7z
del /q %datef%_RetroArch.7z 2>NUL 1>NUL
del /q redist-x86_64.7z 2>NUL 1>NUL
cls
echo Replacing old files with new ones...
robocopy Files\RetroArch ..\..\Emulators\RetroArch\ /E /XO /MOVE 2>NUL 1>NUL
robocopy Files\RetroArch-redist ..\..\Emulators\RetroArch\ /E /XO /MOVE 2>NUL 1>NUL
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