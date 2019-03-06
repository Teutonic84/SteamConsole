#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#Include .\Includes\Class_ScrollGUI.ahk
#Include .\Includes\Class_INI.ahk
#Include .\Includes\Class_GroupBox.ahk
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1
GBTHeight:=5
Menu, Tray, Icon, .\Images\General_Settings.ico

;1st Tab - General Settings
;==========================
;Main Window GUI
Gui, New, +hwndHGUI +Resize
Gui, Color, 14141f ;Teal-18afa0, Grey-535e70, BluishTeal-0f6970, Dark Grey-0a0a10
Gui, Margin, 58, 5
I := 0
inifile = .\Config\general_settings.ini
INI_Init(".\Config\general_settings.ini")
Gui, Add, Tab, w455 h950 xs cwhite, General|Launchers/Apps|PC Games
Gui, Add, Text, xm y33 cwhite, General Options For SteamConsole
Loop, %inisections%
{
  FoundSection := A_index
  section := Section%A_index%
  numberOfKeys%A_index% := Section%A_index%_keys
  ;GB := "GB"++1
  GB := ++
  gbvars =
  gbvars2 =
  Gui, Font, Underline
  Gui, Add, Text, w200 h13 cwhite, %section%
  Gui, Font,,
  IF section=Default_Browser
  {
    loop, % numberOfKeys%A_index%
    {
      IniRead, %section%_val%A_index%, %inifile%, %section%, % Section%FoundSection%_key%A_index%, %A_Space%
      value := %section%_val%A_index%
      option := Section%FoundSection%_key%A_index%
      If (gbvars2 = "")
      {
        gbvars2 = Browser%A_index%
      } else {
        gbvars2 = %gbvars2%|Browser%A_index%
      }
      IF value=enabled
      {
        Gui, Add, Radio, cwhite vBrowser%A_index% gsave Checked, %option%
      } Else {
        Gui, Add, Radio, cwhite vBrowser%A_index% gsave, %option%
      }
    }
    GroupBox(GB, "", GBTHeight, 10, gbvars2, 335, "")
  } Else {
    loop, % numberOfKeys%A_index%
    {
      IniRead, %section%_val%A_index%, %inifile%, %section%, % Section%FoundSection%_key%A_index%, %A_Space%
      value := %section%_val%A_index%
      option := Section%FoundSection%_key%A_index%
      If (gbvars = "")
      {
        gbvars = %section%_checkbox%A_index%
      } else {
        gbvars = %gbvars%|%section%_checkbox%A_index%
      }
      IF value=enabled
      {
        Gui, Add, Checkbox, cwhite v%section%_checkbox%A_index% gSave Checked, % Section%FoundSection%_key%A_index%
      } ELSE IF value=disabled
      {
        Gui, Add, Checkbox, cwhite v%section%_checkbox%A_index% gSave, % Section%FoundSection%_key%A_index%
      }
    }
    GroupBox(GB, "", GBTHeight, 10, gbvars, 335, "")
  }
}

;2nd Tab - Import Options
;========================
inifile = .\Config\launchers_apps.ini
INI_Init(".\Config\launchers_apps.ini")
Gui, Tab, Launchers/Apps
Gui, Add, Text, xm y33 cwhite, List Of PC Apps To Import To Steam`n(Re-run the "ROM Importer" desktop shortcut to apply changes)
I := 0
;GB = GB10
Loop, %inisections%
{
  FoundSection := A_index
  section := Section%A_index%
  numberOfKeys%A_index% := Section%A_index%_keys
  GB := ++
  gbvars =
  Gui, Font, Underline
  Gui, Add, Text, w200 h13 cwhite, %section%
  Gui, Font,,
  loop, % numberOfKeys%A_index%
  {
    IniRead, val%A_index%, %inifile%, %section%, % Section%FoundSection%_key%A_index%, %A_Space%
    value := val%A_index%
    option := Section%FoundSection%_key%A_index%
    If (gbvars = "")
    {
      gbvars = %section%_checkbox%A_index%
    } else {
      gbvars = %gbvars%|%section%_checkbox%A_index%
    }
    ;Msgbox, gbvars=%gbvars%
    ;ListVars
    ;Msgbox, value=%value% option=%option%
    IF value=enabled
    {
      Gui, Add, Checkbox, cwhite v%section%_checkbox%A_index% gSave2 Checked, % Section%FoundSection%_key%A_index%
    }
    ELSE IF value=disabled
    {
      Gui, Add, Checkbox, cwhite v%section%_checkbox%A_index% gSave2, % Section%FoundSection%_key%A_index%
    }
  }
  GroupBox(GB, "", GBTHeight, 10, gbvars, 335, "")
}

;3rd Tab - Paths
;===============
inifile = .\Config\pc_games.ini
INI_Init(".\Config\pc_games.ini")
Gui, Tab, PC Games
Gui, Add, Text, xm y33 cwhite, List Of PC Games To Import To Steam`n(Re-run the "ROM Importer" desktop shortcut to apply changes)
I := 0
;GB = GB10
Loop, %inisections%
{
  FoundSection := A_index
  section := Section%A_index%
  numberOfKeys%A_index% := Section%A_index%_keys
  GB := ++
  gbvars =
  Gui, Font, Underline
  Gui, Add, Text, w200 h13 cwhite, %section%
  Gui, Font,,
  loop, % numberOfKeys%A_index%
  {
    IniRead, val%A_index%, %inifile%, %section%, % Section%FoundSection%_key%A_index%, %A_Space%
    value := val%A_index%
    option := Section%FoundSection%_key%A_index%
    If (gbvars = "")
    {
      gbvars = %section%_checkbox%A_index%
    } else {
      gbvars = %gbvars%|%section%_checkbox%A_index%
    }
    ;Msgbox, gbvars=%gbvars%
    ;ListVars
    ;Msgbox, value=%value% option=%option%
    IF value=enabled
    {
      Gui, Add, Checkbox, cwhite v%section%_checkbox%A_index% gSave3 Checked, % Section%FoundSection%_key%A_index%
    }
    ELSE IF value=disabled
    {
      Gui, Add, Checkbox, cwhite v%section%_checkbox%A_index% gSave3, % Section%FoundSection%_key%A_index%
    }
  }
  GroupBox(GB, "", GBTHeight, 10, gbvars, 335, "")
}

; Create ScrollGUI1 with both horizontal and vertical scrollbars and scrolling by mouse wheel
Global SG1 := New ScrollGUI(HGUI, 455, 500, "+Resize +LabelGui1", 2, 2)
; Show ScrollGUI1
SG1.Show("SteamConsole Settings Editor", "ycenter xcenter")
Gui, Show
return

Save:
Gui, Submit, NoHide
inifile = .\Config\general_settings.ini
INI_Init(".\Config\general_settings.ini")
Loop, %inisections%
{
  FoundSection := A_index
  section := Section%A_index%
  numberOfKeys%A_index% := Section%A_index%_keys
  IF section=Default_Browser
  {
    loop, % numberOfKeys%A_index%
    {
      IniRead, %section%_val%A_index%, %inifile%, %section%, % Section%FoundSection%_key%A_index%, %A_Space%
      value := %section%_val%A_index%
      option := Section%FoundSection%_key%A_index%
      If Browser%A_index%=1
      {
        IniWrite, enabled, %inifile%, %section%, %option%
      } Else {
        IniWrite, disabled, %inifile%, %section%, %option%
      }
    }
  } Else {
    loop, % numberOfKeys%A_index%
    {
      IniRead, %section%_val%A_index%, %inifile%, %section%, % Section%FoundSection%_key%A_index%, %A_Space%
      value := %section%_val%A_index%
      option := Section%FoundSection%_key%A_index%
      If %section%_checkbox%A_index%=1
      {
        IniWrite, enabled, %inifile%, %section%, %option%
      }
      If %section%_checkbox%A_index%=0
      {
        IniWrite, disabled, %inifile%, %section%, %option%
      }
    }
  }
}
return

Save2:
Gui, Submit, NoHide
inifile = .\Config\launchers_apps.ini
INI_Init(".\Config\launchers_apps.ini")
Loop, %inisections%
{
  FoundSection := A_index
  section := Section%A_index%
  numberOfKeys%A_index% := Section%A_index%_keys
  loop, % numberOfKeys%A_index%
  {
    IniRead, %section%_val%A_index%, %inifile%, %section%, % Section%FoundSection%_key%A_index%, %A_Space%
    value := %section%_val%A_index%
    option := Section%FoundSection%_key%A_index%
    If %section%_checkbox%A_index%=1
    {
      IniWrite, enabled, %inifile%, %section%, %option%
      FileMove, .\Emulators\ROMS\%section%\%option%.bat.example, .\Emulators\ROMS\%section%\%option%.bat, 1
    }
    If %section%_checkbox%A_index%=0
    {
      IniWrite, disabled, %inifile%, %section%, %option%
      FileMove, .\Emulators\ROMS\%section%\%option%.bat, .\Emulators\ROMS\%section%\%option%.bat.example, 1
    }
  }
}
return

Save3:
Gui, Submit, NoHide
inifile = .\Config\pc_games.ini
INI_Init(".\Config\pc_games.ini")
Loop, %inisections%
{
  FoundSection := A_index
  section := Section%A_index%
  numberOfKeys%A_index% := Section%A_index%_keys
  loop, % numberOfKeys%A_index%
  {
    IniRead, %section%_val%A_index%, %inifile%, %section%, % Section%FoundSection%_key%A_index%, %A_Space%
    value := %section%_val%A_index%
    option := Section%FoundSection%_key%A_index%
    If %section%_checkbox%A_index%=1
    {
      IniWrite, enabled, %inifile%, %section%, %option%
      FileMove, .\Emulators\ROMS\%section%\%option%.bat.example, .\Emulators\ROMS\%section%\%option%.bat, 1
    }
    If %section%_checkbox%A_index%=0
    {
      IniWrite, disabled, %inifile%, %section%, %option%
      FileMove, .\Emulators\ROMS\%section%\%option%.bat, .\Emulators\ROMS\%section%\%option%.bat.example, 1
    }
  }
}
return

;=======
;hotkeys
;=======
ESC::
ExitApp

Gui1Close:
Gui1Escape:
ExitApp

Gui1Size:
Return

Gui2Size:
Return

Gui2Close:
Gui2Escape:
   SG2 := ""
Return
