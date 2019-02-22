#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Get values from general_settings.ini to populate General tab
IniRead, option1, general_settings.ini, General, Rename ROMs During Steam Import, %A_Space%
IniRead, option2, general_settings.ini, General, launch_steamconsole_on_startup, %A_Space%

;Create tabs labeled General, Import Options, and Paths
Gui, Add, Tab,, General|Import Options|Paths
IF option1=enabled
	{
	Gui, Add, Checkbox, vrom_renamer gSave Checked, Rename ROMs During Steam Import
	}
ELSE IF option1=disabled
	{
	Gui, Add, Checkbox, vrom_renamer gSave, Rename ROMs During Steam Import
	}
IF option2=enabled
	{
	Gui, Add, Checkbox, vlaunch_steamconsole_on_startup gSave Checked, Launch SteamConsole On Windows Startup
	}
ELSE IF option2=disabled
	{
	Gui, Add, Checkbox, vlaunch_steamconsole_on_startup gSave, Launch SteamConsole On Windows Startup
	}

Gui, Tab, Import Options
Gui, Add, Text,, Check boxes to enable import into Steam
Gui, Add, Checkbox, vimport_apps1, Test checkbox 1
Gui, Add, GroupBox,xp+4, Apps
Gui, Add, Checkbox, vimport_apps2, Test checkbox 2

Gui, Tab, Paths
Gui, Add, Checkbox, vpath1, Test Path 1
Gui, Add, Checkbox, vpath2, Test Path 2
Gui, Show,,
return

Save:
Gui, Submit, NoHide
;Msgbox, rom_renamer = %rom_renamer%`nlaunch_steamconsole_on_startup = %launch_steamconsole_on_startup%
IF rom_renamer=0
	{
	IniWrite, disabled, general_settings.ini, General, Rename ROMs During Steam Import ;"rom_renamer" is what it searches for in the ini. "disabled" is what it changes the value of "rom_renamer" to.
	}
IF rom_renamer=1
	{
	IniWrite, enabled, general_settings.ini, General, Rename ROMs During Steam Import ;"rom_renamer" is what it searches for in the ini. "enabled" is what it changes the value of "rom_renamer" to.
	}
IF launch_steamconsole_on_startup=0
	{
	IniWrite, disabled, general_settings.ini, General, launch_steamconsole_on_startup
	}
IF launch_steamconsole_on_startup=1
	{
	IniWrite, enabled, general_settings.ini, General, launch_steamconsole_on_startup
	}
return

F1::
GuiControlGet, rom_renamer
GuiControlGet, launch_steamconsole_on_startup
Msgbox, By using GuiControlGet`nrom_renamer = %rom_renamer%`nlaunch_steamconsole_on_startup = %launch_steamconsole_on_startup%
return

ESC::
GuiClose:
ExitApp
