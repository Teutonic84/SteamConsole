echo off

cd ..\..
set dirpath=%cd%

start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\Dolphin_Xbox360.xpadderprofile"
if %computername%==DANS-LAPTOP ( goto DDrive )
"%dirpath%\Emulators\Gamecube\Dolphin\dolphin.exe" /e "%dirpath%\Emulators\ROMS\Gamecube\ROMFILE" /b
goto end

:DDrive
del /Q /F "D:\SteamConsole\Emulators\Gamecube\Dolphin\User\Config\Dolphin.ini"
copy /y "D:\SteamConsole\Emulators\Gamecube\Dolphin\User\Config\Dolphin_D_Drive.ini" "D:\SteamConsole\Emulators\Gamecube\Dolphin\User\Config\Dolphin.ini"
"%dirpath%\Emulators\Gamecube\Dolphin\dolphin.exe" /e "%dirpath%\Emulators\ROMS\Gamecube\ROMFILE" /b

del /Q /F "D:\SteamConsole\Emulators\Gamecube\Dolphin\User\Config\Dolphin.ini"
copy /y "D:\SteamConsole\Emulators\Gamecube\Dolphin\User\Config\Dolphin_C_Drive.ini" "D:\SteamConsole\Emulators\Gamecube\Dolphin\User\Config\Dolphin.ini"
goto end

:end
"%dirpath%\Tools\Xpadder\xpadder.exe" /C
start "" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
exit