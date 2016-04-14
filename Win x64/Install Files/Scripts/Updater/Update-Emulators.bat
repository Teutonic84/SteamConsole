@echo off
cls
if not exist "files" (mkdir Files)

wget http://buildbot.libretro.com/nightly/windows/x86_64/latest/mupen64plus_libretro.dll.zip
wget http://buildbot.libretro.com/nightly/windows/x86_64/latest/desmume_libretro.dll.zip
wget http://buildbot.libretro.com/nightly/windows/x86_64/latest/genesis_plus_gx_libretro.dll.zip
wget http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_psx_libretro.dll.zip
wget http://buildbot.libretro.com/nightly/windows/x86_64/latest/nestopia_libretro.dll.zip
wget http://buildbot.libretro.com/nightly/windows/x86_64/latest/ppsspp_libretro.zip
wget http://buildbot.libretro.com/nightly/windows/x86_64/latest/snes9x_libretro.dll.zip
wget http://buildbot.libretro.com/nightly/windows/x86_64/latest/vbam_libretro.dll.zip

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

robocopy "Files\RetroArch_Cores" "..\..\Emulators\RetroArch\cores\" /E /XO /MOVE
if exist "files\RetroArch_Cores" rmdir /s /q "files\RetroArch_Cores"

set /p version=<version_pcsx2.txt
wget -N --no-parent --html-extension --secure-protocol=tlsv1 --no-check-certificate "http://buildbot.orphis.net/pcsx2/index.php"
for /F "tokens=4 delims=><" %%a in ('findstr /I " \<v1.* " index.php.html') do (
    set "newversion=%%a"
    goto vercheck
)

:vercheck
del /q index.php.html
cls
if %version% == %newversion% goto NOUP

wget -Q7m --reject css,html --mirror -p --convert-links -P files\PCSX2 "http://buildbot.orphis.net/pcsx2/index.php"

7za x -y -o"files\PCSX2" "Files\PCSX2\buildbot.orphis.net\pcsx2\index.php@m=get&rev=%newversion%&platform=windows-x86"
robocopy "Files\PCSX2\pcsx2-%newversion%-windows-x86" "..\..\Emulators\PS2\PCSX2\" /E /XO /MOVE
copy /y portable.ini "..\..\Emulators\PS2\PCSX2\portable.ini"
"..\..\Emulators\PS2\PCSX2\4gb_patch.exe" "..\..\Emulators\PS2\pcsx2\pcsx2.exe"
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

wget -N --no-parent --html-extension --secure-protocol=tlsv1 --no-check-certificate https://dolphin-emu.org/download/

for /F "tokens=2 delims=)(" %%a in ('findstr /I " \<(.* " index.html') do (
    set "newversion2=%%a"
    goto next
)
:next
set /p version2=<version_dolphin.txt
del /q "index.html"

if %version2% == %newversion2% goto NOUP2

set link=http://dl.dolphin-emu.org/builds/dolphin-master-%newversion2%-x64.7z
cls
wget --no-check-certificate %link%
7za x -y -o"files\" dolphin-master-%newversion2%-x64.7z
::7za x dolphin-master-%newversion2%-x64.7z
del dolphin-master-%newversion2%-x64.7z

@echo %newversion2%>version_dolphin.txt
robocopy Files\Dolphin-x64 "..\..\Emulators\Gamecube\Dolphin\" /E /XO /MOVE
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
wget --no-check-certificate %link%
if %errorlevel%==1 (
    set "retroarch=No nightly build for today. Try again tomorrow."
    goto end
)
:next2
7za x -y -o"files\RetroArch" %datef%_RetroArch.7z
del %datef%_RetroArch.7z
robocopy Files\RetroArch "..\..\Emulators\RetroArch\" /E /XO /MOVE
set "retroarch=RetroArch updated to %datef%..."

:end
if exist "Files\" (rmdir /q /s Files)
if exist "%datef%_RetroArch.7z" (del /q %datef%_RetroArch.7z)
if exist "dolphin-master-%newversion%-x64.7z" (del /q dolphin-master-%newversion%-x64.7z)
cls
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
pause
EXIT

:nochange
if exist "Files\" (rmdir /q /s Files)
if exist "%datef%_RetroArch.7z" (del /q %datef%_RetroArch.7z)
if exist "dolphin-master-%newversion%-x64.7z" (del /q dolphin-master-%newversion%-x64.7z)
cls
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
pause
EXIT