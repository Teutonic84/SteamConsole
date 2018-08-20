ECHO off
MODE 150,60
CLS

SET "bpath=%userprofile%\Desktop\Builds"
SET /P updaterv=Please type version of updater script (ex: 1.2.3): %=%
SET /P scversion=Please type version of SteamConsole (ex: 1.2.3): %=%
ECHO.

ECHO Copying Test Build folder to new location before building...
PING localhost -n 5 >NUL
ROBOCOPY "..\Test Build" "%bpath%\SteamConsole\Test Build" /E
COPY /y ".\SteamConsole_uninstaller.exe" "%bpath%\SteamConsole\Test Build"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Starting SteamConsole Updater script build.
ECHO Zipping folder "Updater"...
7zg a -y "%bpath%\Updater_v%updaterv%.7z" "%bpath%\SteamConsole\Test Build\Install Files\Scripts\Updater"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

::ECHO Moving Updater_v%updaterv%.7z To SteamConsole FTP Folder...
::MOVE /y "%bpath%\Updater_v%updaterv%.7z" "\\server\c$\ftp_root\steamconsole\Updater_v%updaterv%.7z"
::ECHO Done
::ECHO.
::PING localhost -n 5 >NUL

ECHO SteamConsole Updater Script Build Complete...
ECHO =============================================
ECHO.
PING localhost -n 5 >NUL

ECHO Starting SteamConsole Main Script Build.
ECHO Edit The File "Changelog.rtf" Before Continuing.
"%bpath%\SteamConsole\Test Build\Changelog.rtf"
COPY /y "%bpath%\SteamConsole\Test Build\Changelog.rft" "..\Test Build\Changelog.rtf"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Zipping Updated SteamConsole Files
MOVE /Y "%bpath%\SteamConsole\Test Build\SteamConsole_Setup.nsi" "%bpath%\SteamConsole\SteamConsole_Setup.nsi" >NUL
7zg a -y "%bpath%\SteamConsole_Update_Only_v%scversion%_x64.7z" "%bpath%\SteamConsole\Test Build\*"
ECHO Done
ECHO.

::ECHO Moving "SteamConsole_Update_Only_v%scversion%_x64.7z" To FTP Folder On \\Server.
::MOVE /Y "%bpath%\Test Build\SteamConsole_Update_Only_v%scversion%_x64.7z" "\\server\c$\ftp_root\steamconsole\SteamConsole_Update_Only_v%scversion%_x64.7z"
::ECHO Done
::ECHO.
::PING localhost -n 5 >NUL

ECHO Prepping Files For SteamConsole NSIS EXE Build.
MOVE /Y "%bpath%\SteamConsole\SteamConsole_Setup.nsi" "%bpath%\SteamConsole\Test Build\SteamConsole_Setup.nsi"
7zg a -y "%bpath%\SteamConsole\Test Build\SteamConsole.7z" "%bpath%\SteamConsole\Test Build\Install Files\*"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Removing "..\Install Files" Folder.
RMDIR /S /Q "%bpath%\SteamConsole\Test Build\Install Files"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Edit The File "SteamConsole_Setup.nsi" With SteamConsole Version Number %scversion% Before Continuing.
notepad "%bpath%\SteamConsole\Test Build\SteamConsole_Setup.nsi"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Building "SteamConsole_Setup.nsi"
"C:\Program Files (x86)\NSIS\makensis.exe" /X"SetCompressor /FINAL lzma" "%bpath%\SteamConsole\Test Build\SteamConsole_Setup.nsi"
RENAME "%bpath%\SteamConsole\Test Build\SteamConsole_Setup.exe" "SteamConsole_v%scversion%_x64.exe"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO Moving "SteamConsole_v%scversion%.exe" To "Builds" Root Folder.
MOVE /Y "%bpath%\SteamConsole\Test Build\SteamConsole_v%scversion%_x64.exe" "%bpath%\SteamConsole_v%scversion%_x64.exe"
ECHO Done
ECHO.
PING localhost -n 5 >NUL

ECHO SteamConsole EXE Build Complete...
ECHO ==================================
ECHO.

:end
ECHO Cleaning Up Build Files.
RMDIR /S /Q "%bpath%\SteamConsole"
ECHO Done
ECHO.
ECHO.
ECHO Build Complete. Press Any Key To Exit...
PAUSE >NUL
EXIT
