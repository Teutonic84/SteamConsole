Install instructions:
 1. Extract the SteamConsole folder from the 7zip folder and place it anywhere you'd like. This will be the 
    permanent home for the SteamConsole, but if you move the folder later, just run the install again.

 2. Download and put all your ROMS into the folder ..\SteamConsole\Emulators\ROMS\CONSOLE before proceding  
    further in the install. The ROM Import tool that will run automatically during this install, will auto
    rename all the ROM files for you. This will ensure that the ROM Importer script will pull a proper banner 
    image that is displayed in steam big picture mode.
    NOTE: "CONSOLE" is the folder corresponding to which console the ROM is for (EX: NES, SNES, SEGA, etc).

 3. When selecting a controller during the install, use option 2 (Dualshock 4 (PS4) only) if you don't intend to
    hook up a PS2/PS3 controller ever. It uses the DS4Tool which has much better bluetooth drivers but only works
    with Dualshock 4 (PS4) controllers. The Dualshock 2/3/4 option uses the program "DSTools" or "Xinput wrapper".
    This program has some issues with bluetooth drivers and only work on specific devices. If it doesn't work,
    then you may have to find a different tool to emulate xinput (360 controllers).
    NOTE: If you selected option 2 (Dualshock 4 (PS4) only), after the SteamConsole install finishes, before you 
          reboot, You will need to go to SteamConsole\Scripts. Right click on the "services" shortcut 
          (not the batch file), Select properties. Then click on the "advanced" button. Check the box labled 
          "run as administrator". This will allow the DS4Tool to grab exclusive mode to the controller when you 
          launch steam.bat from the link on your desktop that was created during install. Run the services 
          shortcut and reboot to finalize the setup.
    NOTE: For help with the DSTool, please go to:
          http://forums.pcsx2.net/Thread-XInput-Wrapper-for-DS3-and-Play-com-USB-Dual-DS2-Controller
    NOTE: For help with the DS4Tool, please go to:
          http://forums.pcsx2.net/Thread-DS4-To-XInput-Wrapper

 4. If you don't have steam installed, then it will prompt to install. 
    NOTE: Make sure you run steam and login after it's installed to setup your account and profile on your PC.
    NOTE: If you don't have a steam account then create one during the steam install (or online) and log into 
          the steam application once with it before proceding after steam is installed.

 5. The black command prompt window will prompt for certain options. Type in the number corresponding
    to the options and hit enter when prompted.

 6. When installs pop up during this install script, just click next through everything.
    NOTE: When the .NET 3.5 install pops up (during 360 controller setup on Win8 and up), it will take awhile to 
    download and install. You can proceed with the rest of the install while .NET 3.5 is installing, so I recommend
    Initiating that right away.

 7. When xpadder pops up for the first run wizard during the install, click next through everything
    and then right click on the xpadder icon and select "close". The xpadder icon will be in the system tray 
    in the bottom right corner of your screen. This will fully close out of xpadder. The script should 
    continue on after xpadder is fully closed out.
    NOTE: The Xpadder system tray icon in the bottom right might be hidden. Click on the up arrow in the system 
    tray to see hidden icons.

 8. When Ice starts importing the roms into steam, it will rapidly list them out and start downloading
    banner images for them. When Ice finishes it will prompt to press enter to continue.

 9. After this it should finish the install and put a shortcut to a batch file called "steam" on the desktop.
    Also it will put a shortcut called "ROM Import". Use this shortcut when you add/remove ROMS from your PC.
    Use the steam batch file shortcut on the desktop when opening up steam so that the correct programs are 
    running in the background.

10. If you move the location of your steam install and/or the steamconsole folder, just run the setup again
    to update the path of the steam batch file and ROM Import shortcuts on the desktop.

    NOTE: I have added batch files for applications and websites to be accessed in steam. The web applications use
          Google Chrome as the web browser so that must be installed. The batch files are located at:
          "SteamConsole\Steam_Shortcuts\Arcade". You can add or edit these batch files and after running the
          ROM Import script again, it will add them to the "Apps" section in steam.