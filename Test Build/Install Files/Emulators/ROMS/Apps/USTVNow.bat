ECHO off

cd "%~dp0%"
cd ..\..\..
SET "dirpath=%cd%"
SET "instloc=C:\Program Files (x86)\Internet Explorer"

"%instloc%\iexplore.exe" -k "http://watch.ustvnow.com/guide"
:loop
TASKLIST /FI "IMAGENAME eq iexplore.exe" 2>NUL | FIND /I /N "iexplore.exe">NUL
IF %ERRORLEVEL%==0 (
    PING localhost -n 5 >NUL
    GOTO loop
)

:end
EXIT