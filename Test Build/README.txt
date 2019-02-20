#SteamConsole
SteamConsole turns your PC into a console-like interface using Steam big picture mode and some free third party tools. 
This allows you to use your controller as a mouse/keyboard as well as import old school video game ROMS into steam to play.

#NOTE: Controller config was set to enable the "desktop" profile by default. Which means mouse/keyboard will be enabled unless
a game is set to auto switch to the "blank" profile. Hold down the select button on your controller to turn off the mouse/keyboard
if you are in a game that needs it turned off. Hold down select for 2 seconds again to re-enable it.

##Current games that are set to "blank" profile:
* Rocket League
* Assassin's Creed Odyssey
* Elite Dangerous

##Things To Note:

* The 32-bit version is old and outdated. DO NOT USE!

* Currently only Xinput (Xbox) controllers are supported out of the box. 
You can use Dualshock 3 & 4 controllers with this, but you will need to select the custom install option and check the box for "DS3 & DS4". 
Below is a link to the SCPToolkit project page that SteamConsole uses.


* [SCPToolkit (ScpServer)] (https://github.com/nefarius/ScpToolkit/releases)

First Steps:
* Download ROMS for NES/SNES/N64/Gamecube/Wii/SEGA/SMS/GBA/DS/PSP/PS1/PS2 and place them in the appropriate folder in:
** "..\SteamConsole\Emulators\ROMS"
* Open the "Import ROMS" link to import all the ROMS into Steam.
* Steam will automatically launch when the import script is finished.
* Be sure to run the "SteamConsole Updater" script periodically since it updates the following:
** The update script itself.
** SteamConsole files
** Dolphin (Gamecube/Wii Emulator)
** PCSX2 (PS2 Emulator)
** RetroArch cores (emulators used in RetroArch)
** RetroArch main program