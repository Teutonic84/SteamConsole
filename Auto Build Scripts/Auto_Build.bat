echo off
cls

set /P updaterv=Please type version of updater script (ex: 1.2.3): %=%

echo Copying Win x64 folder to new location before building...
::robocopy "..\Win x64" "C:\Users\User\Desktop\Downloads\Win x64" /E /Z
::cls
echo.
echo Copying done...
ping localhost -n 2 2<NUL 1<NUL

echo.
echo Zipping folder "Updater"
7zg a -y "C:\Users\User\Desktop\Downloads\Updater_v%updaterv%.7z" "C:\Users\User\Desktop\Downloads\Win x64\Install Files\Scripts\Updater"

echo.
echo Zipping of Updater_v%updaterv%.7z completed successfully...
ping localhost -n 2 2<NUL 1<NUL

echo.
echo Moving Updater_v%updaterv%.7z to SteamConsole FTP folder...
move /y "C:\Users\User\Desktop\Downloads\Updater_v%updaterv%.7z" "C:\ftp_root\steamconsole\Updater_v%updaterv%.7z"

echo.
echo Moving completed successfully...
ping localhost -n 2 2<NUL 1<NUL

pause