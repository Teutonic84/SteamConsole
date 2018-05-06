ECHO off
CLS

SET /P updaterv=Please type version of updater script (ex: 1.2.3): %=%
SET /P scversion=Please type version of SteamConsole (ex: 1.2.3): %=%

ECHO Copying Win x64 folder to new location before building...
::robocopy "..\Win x64" "%userprofile%\Desktop\Builds\SteamConsole\Win x64" /E /Z
ECHO.
ECHO Done
PING localhost -n 2 >NUL

ECHO.
ECHO Starting SteamConsole Updater script build.
ECHO Zipping folder "Updater"...
7zg a -y "%userprofile%\Desktop\Builds\SteamConsole\Updater_v%updaterv%.7z" "%userprofile%\Desktop\Builds\SteamConsole\Win x64\Install Files\Scripts\Updater"
ECHO.
ECHO Done
PING localhost -n 2 >NUL

ECHO.
ECHO Moving Updater_v%updaterv%.7z to SteamConsole FTP folder...
MOVE /y "%userprofile%\Desktop\Builds\SteamConsole\Updater_v%updaterv%.7z" "\\server\c$\ftp_root\steamconsole\Updater_v%updaterv%.7z"
ECHO.
ECHO Done
ECHO SteamConsole Updater script build complete.
PING localhost -n 2 >NUL

ECHO.
ECHO Starting SteamConsole main script build.
7zg a -y "%userprofile%\Desktop\Builds\SteamConsole\Win x64\SteamConsole.7z" "%userprofile%\Desktop\Builds\SteamConsole\Win x64\Install Files\*.*"
ECHO.
ECHO Done
PING localhost -n 2 >NUL

ECHO Removing Install Files folder to prep for NSIS installer build.
RMDIR /S /Q "%userprofile%\Desktop\Builds\SteamConsole\Win x64\Install Files"
ECHO Done
PING localhost -n 2 >NUL

ECHO Edit the files "Changelog.rtf" and "SteamConsole_Setup.nsi" with SteamConsole version number %scversion% before continuing.
"%userprofile%\Desktop\Builds\SteamConsole\Win x64\Changelog.rtf"
PAUSE

PAUSE
