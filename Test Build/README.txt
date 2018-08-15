#SteamConsole
SteamConsole turns your PC into a console-like interface using Steam big picture mode and some free third party tools. 
This allows you to use your controller as a mouse/keyboard as well as import old school video game ROMS into steam to play.



##Things To Note:

* The 32-bit version will not be able to play gamecube, wii or psp ROMs. 
This is because the emulators for those consoles do not support 32-bit.

* Currently only Xinput (Xbox) controllers are supported out of the box. 
You can use Dualshock 3 & 4 controllers with this, but you will need to select the custom install option and check the box for "DS3 & DS4". 
Below is a link to the DSTool reloaded project page that SteamConsole uses.


* [DSTool-Reloaded (ScpServer)] (https://github.com/nefarius/ScpServer)

First Steps:
* Download ROMS for NES/SNES/N64/Gamecube/Wii/SEGA/SMS/GBA/DS/PSP/PS1/PS2 and place them in the appropriate folder in:
** "..\SteamConsole\Emulators\ROMS"
* Run the "Rom Importer" to import all the ROMS into Steam.
* Launch Steam and enjoy!
* Be sure to run the "Update SteamConsole" script periodically since it updates the following:
** The update script itself.
** SteamConsole files
** Dolphin (Gamecube/Wii Emulator)
** PCSX2 (PS2 Emulator)
** RetroArch cores (emulators used in RetroArch)
** RetroArch main program