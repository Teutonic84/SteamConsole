ECHO off
MODE 150,60
CLS

SET "bpath=%userprofile%\Desktop\Builds\SteamConsole"
SET /P updaterv=Please type version of updater script (ex: 1.2.3): %=%
SET /P scversion=Please type version of SteamConsole (ex: 1.2.3): %=%
ECHO.

ECHO Copying Win x64 folder to new location before building...
PING localhost -n 5 >NUL
robocopy "..\Win x64" "%bpath%\Win x64" /E
COPY /y ".\SteamConsole_uninstaller.exe" "%bpath%\Win x64"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Starting SteamConsole Updater script build.
ECHO Zipping folder "Updater"...
7zg a -y "%bpath%\Updater_v%updaterv%.7z" "%bpath%\Win x64\Install Files\Scripts\Updater"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Moving Updater_v%updaterv%.7z To SteamConsole FTP Folder...
MOVE /y "%bpath%\Updater_v%updaterv%.7z" "\\server\c$\ftp_root\steamconsole\Updater_v%updaterv%.7z"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO SteamConsole Updater Script Build Complete...
ECHO =============================================
ECHO.
PING localhost -n 5 >NUL

ECHO Starting SteamConsole Main Script Build.
ECHO Edit The File "Changelog.rtf" Before Continuing.
"%bpath%\Win x64\Changelog.rtf"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Zipping Updated SteamConsole Files
MOVE /Y "%bpath%\Win x64\SteamConsole_Setup.nsi" "%bpath%\SteamConsole_Setup.nsi" >NUL
7zg a -y "%bpath%\Win x64\SteamConsole_v%scversion%_x64.7z" "%bpath%\Win x64\*"
ECHO Done
ECHO.

ECHO Moving "SteamConsole_v%scversion%_x64.7z" To FTP Folder On \\Server.
MOVE /Y "%bpath%\Win x64\SteamConsole_v%scversion%_x64.7z" "\\server\c$\ftp_root\steamconsole\SteamConsole_v%scversion%_x64.7z"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Prepping Files For SteamConsole NSIS EXE Build.
MOVE /Y "%bpath%\SteamConsole_Setup.nsi" "%bpath%\Win x64\SteamConsole_Setup.nsi"
7zg a -y "%bpath%\Win x64\SteamConsole.7z" "%bpath%\Win x64\Install Files\*"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Removing "..\Install Files" Folder.
RMDIR /S /Q "%bpath%\Win x64\Install Files"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Edit The File "SteamConsole_Setup.nsi" With SteamConsole Version Number %scversion% Before Continuing.
notepad "%bpath%\Win x64\SteamConsole_Setup.nsi"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Building "SteamConsole_Setup.nsi"
"C:\Program Files (x86)\NSIS\makensis.exe" /X"SetCompressor /FINAL lzma" "%bpath%\Win x64\SteamConsole_Setup.nsi"
RENAME "%bpath%\Win x64\SteamConsole_Setup.exe" "SteamConsole_v%scversion%_x64.exe"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Moving "SteamConsole_v%scversion%.exe" To "Builds" Root Folder.
MOVE /Y "%bpath%\Win x64\SteamConsole_v%scversion%_x64.exe" "%userprofile%\Desktop\Builds\SteamConsole_v%scversion%_x64.exe"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO SteamConsole EXE Build Complete...
ECHO ==================================
ECHO.

:end
ECHO Cleaning Up Build Files.
RMDIR /S /Q "%bpath%"
ECHO Done
ECHO.
ECHO.
ECHO Build Complete. Press Any Key To Exit...
PAUSE >NUL
EXIT
