echo Dolphin Updater 1.0 by Drakekilla
@echo off
cd Updater
wget -N --no-parent --html-extension --secure-protocol=tlsv1 --no-check-certificate https://dolphin-emu.org/download/

for /F "tokens=2 delims=)(" %%a in ('findstr /I " (4..-....) " index.html') do set "newversion=%%a"
set /p version=<..\version.txt

if %version% == %newversion% goto NOUP

set link=http://dl.dolphin-emu.org/builds/dolphin-master-%newversion%-x64.7z
cd Updater
cls
wget --no-check-certificate %link%
7za x dolphin-master-%newversion%-x64.7z
del dolphin-master-%newversion%-x64.7z
cd Dolphin-x64
@echo %newversion% > version.txt
cd ..
robocopy Dolphin-x64 .. /E /XO /MOVE
if exist "Dolphin-x64" rmdir /s /q Dolphin-x64
@echo.
@echo.
@echo Updated to newest version %newversion%
@echo.
@echo.
pause
EXIT

:NOUP
cls
@echo.
@echo.
@echo Already newest Version.
@echo.
@echo.
pause
EXIT