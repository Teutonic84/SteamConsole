Steamconsole uses Steam as a frontend, with some third party tools, to get your PC as close as you can to a console-like experience. This allows you to use your controller as a mouse/keyboard as well as import old school video game ROMS into steam to play. It also imports links to websites like twitch or youtube in fullscreen mode.

# General Usage:

* After installing SteamConsole, you can edit settings and set which weblinks/applications/PC Games, are imported into steam with "SteamConsole Settings.exe", located in the root SteamConsole folder.

* Place any ROMS you have in "..\SteamConsole\Emulators\ROMS\PLATFORM" where "PLATFORM" is the game system (IE: NES, SNES, GBA).

* Run the "ROM Importer" to import games to steam or apply changes if you have added or removed ROMS/Games/Grid Images
   NOTE: The ROM Importer is set by default to rename ROM files before it imports to steam. It removes any extra characters like "-" or "(USA)" in the names. You can disable this option in the Steamconsole Settings application. 
   
* If a grid image isn't found for a ROM, make sure you have the ROM name the exact same as the jpg file located in "..\SteamConsole\Images\Steam_Grid_Images\PLATFORM".

  * If you would like to make your own custom grid image, there are templates located in each folder in "..\SteamConsole\Images\Steam_Grid_Images\PLATFORM". Use the file "Template Image Dimensions.txt" located in "..\SteamConsole\Images\Steam_Grid_Images" to get the exact image dimensions to use in the templates.

## Things To Note:

* The 32-bit version is no longer supported. It is not able to play gamecube, wii or psp ROMs. This is because the emulators for those consoles do not support 32-bit. So this was one of many reasons why 32-bit support was dropped.

* Currently only Xinput (Xbox) controllers are supported out of the box. You can use Dualshock 3 & 4 controllers with this, but you will need to select the custom install option and check the box for "DS3 & DS4". Below is a link to the DSTool reloaded project page that SteamConsole uses.

  * [DSTool-Reloaded (ScpServer)] (https://github.com/nefarius/ScpServer)
