@echo off

cd ..
set dirpath=%cd%
setlocal EnableDelayedExpansion

ECHO.
ECHO ROM Folder Options:
ECHO 1. DS
ECHO 2. Gamecube
ECHO 3. GBA
ECHO 4. SEGA
ECHO 5. N64
ECHO 6. NES
ECHO 7. PS1
ECHO 8. PS2
ECHO 9. PSP
ECHO 10. SNES
ECHO 11. Wii
ECHO.
set /P emulator=Enter ROM Folder Number: %=%

if %emulator%==1 (
    goto ds
)
if %emulator%==2 (
    goto gc
)
if %emulator%==3 (
    goto gba
)
if %emulator%==4 (
    goto sega
)
if %emulator%==5 (
    goto n64
)
if %emulator%==6 (
    goto nes
)
if %emulator%==7 (
    goto ps1
)
if %emulator%==8 (
    goto ps2
)
if %emulator%==9 (
    goto psp
)
if %emulator%==10 (
    goto snes
)
if %emulator%==11 (
    goto wii
)

:ds
Set "Pattern= (NDS)"
Set "Replace="

For %%# in ("%dirpath%\Emulators\ROMS\DS\*.*") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
goto end
:gc
Set "Pattern= (GC)"
Set "Replace="

For %%# in ("%dirpath%\Emulators\ROMS\Gamecube\*.*") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
goto end
:gba
Set "Pattern= (GBA)"
Set "Replace="

For %%# in ("%dirpath%\Emulators\ROMS\GBA\*.*") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
goto end
:sega
Set "Pattern= (SEGA)"
Set "Replace="

For %%# in ("%dirpath%\Emulators\ROMS\Genesis\*.*") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
goto end
:n64
Set "Pattern= (N64)"
Set "Replace="

For %%# in ("%dirpath%\Emulators\ROMS\N64\*.*") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
goto end
:nes
Set "Pattern= (NES)"
Set "Replace="

For %%# in ("%dirpath%\Emulators\ROMS\NES\*.*") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
goto end
:ps1
Set "Pattern= (PS1)"
Set "Replace="

For %%# in ("%dirpath%\Emulators\ROMS\PS1\*.*") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
goto end
:ps2
Set "Pattern= (PS2)"
Set "Replace="

For %%# in ("%dirpath%\Emulators\ROMS\PS2\*.*") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
goto end
:psp
Set "Pattern= (PSP)"
Set "Replace="

For %%# in ("%dirpath%\Emulators\ROMS\PSP\*.*") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
goto end
:snes
Set "Pattern= (SNES)"
Set "Replace="

For %%# in ("%dirpath%\Emulators\ROMS\SNES\*.*") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
goto end
:wii
Set "Pattern=(Wii)"
Set "Replace="

For %%# in ("%dirpath%\Emulators\ROMS\Wii\*.*") Do (
    Set "File=%%~nx#"
    Ren "%%#" "!File:%Pattern%=%Replace%!"
)
goto end

:end
cls
ECHO.
ECHO.
ECHO Script Finished...
ECHO.
ECHO.
pause
exit