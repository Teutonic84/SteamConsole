echo off
cls

taskkill /im "Custom Hotkeys.exe"
"C:\SteamConsole\Tools\Xpadder\xpadder.exe" /C

::"C:\Program Files (x86)\Steam\steamapps\common\rocketleague\Binaries\Win32\RocketLeague.exe"
start "" "steam://rungameid/252950"

:check
ping localhost -n 3 2>NUL 1>NUL
tasklist /FI "IMAGENAME eq RocketLeague.exe" 2>NUL | find /I /N "RocketLeague.exe">NUL
if "%ERRORLEVEL%"=="0" goto check

start "" "C:\SteamConsole\Tools\Xpadder\xpadder.exe" /M "C:\SteamConsole\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "C:\SteamConsole\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "C:\SteamConsole\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "C:\SteamConsole\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "C:\SteamConsole\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "C:\SteamConsole\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "C:\SteamConsole\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "C:\SteamConsole\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"
copy /y "C:\SteamConsole\Tools\Xpadder\Controller Maps\Controller Map - Steam.JPG" "C:\SteamConsole\Tools\Xpadder\Controller Maps\Controller Map.JPG"
start "" "C:\SteamConsole\Tools\Xpadder\Custom Hotkeys.exe"

exit
