echo off
cls

TASKLIST /FI "IMAGENAME eq RocketLeague.exe" 2>NUL | FIND /I /N "RocketLeague.exe">NUL
IF "%ERRORLEVEL%"=="0" TASKKILL /im "RocketLeague.exe"

TASKLIST /FI "IMAGENAME eq ShantaeHero.exe" 2>NUL | FIND /I /N "ShantaeHero.exe">NUL
IF "%ERRORLEVEL%"=="0" TASKKILL /im "ShantaeHero.exe"

TASKLIST /FI "IMAGENAME eq retroarch.exe" 2>NUL | FIND /I /N "retroarch.exe">NUL
IF "%ERRORLEVEL%"=="0" TASKKILL /im "retroarch.exe"

TASKLIST /FI "IMAGENAME eq EliteDangerous64.exe" 2>NUL | FIND /I /N "EliteDangerous64.exe">NUL
IF "%ERRORLEVEL%"=="0" TASKKILL /im "EliteDangerous64.exe"

exit