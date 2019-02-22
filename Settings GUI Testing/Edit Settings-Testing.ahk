TEST USING THIS METHOD:
IniRead, Out1, test.ini, Section1, Keytest1
IniRead, Out2, test.ini, Section1, Keytest2

IniRead, Out3, test.ini, Section2, Keytest1
IniRead, Out4, test.ini, Section2, Keytest2

MsgBox, %Out1%`n%Out2%`n%Out3%`n%Out4%



#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

inifile = general_settings.ini

;here is where we use our new user library functions.
initializeini(inifile)
;Listvars
loadini(inifile)
;Listvars

;Create tabs labeled General, Import Options, and Paths
Gui, Add, Tab,, General|Import Options|Paths
Loop, %inisections%
  If (Section%A_index% = "General")
    {
      GeneralSection := A_index
      numberOfKeys := Section%A_index%_keys
    }
Loop, %numberOfKeys%
{
  section := Section%GeneralSection%
  option%A_index% := Section%GeneralSection%_key%A_index%
  value%A_index% := val%A_index%
}
IF value%A_index%=enabled
{
  Gui, Add, Checkbox, voname%A_index% gSave Checked, option%A_index%
}
ELSE IF value=disabled
{
  Gui, Add, Checkbox, voname%A_index% gSave, option%A_index%
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
;saveini(inifile)
return

Save:
Gui, Submit, NoHide
;Msgbox, rom_renamer = %rom_renamer%`nlaunch_steamconsole_on_startup = %launch_steamconsole_on_startup%
IF oname%A_index%=0
	{
	IniWrite, disabled, %inifile%, %section%, option%A_index% ;"rom_renamer" is what it searches for in the ini. "disabled" is what it changes the value of "rom_renamer" to.
	}
ELSE IF oname%A_index%=1
	{
	IniWrite, enabled, %inifile%, %section%, option%A_index% ;"rom_renamer" is what it searches for in the ini. "enabled" is what it changes the value of "rom_renamer" to.
	}
return

;=========
;functions
;=========

initializeini(inifile = "general_settings.ini"){
  global
  local key,temp
  inisections:=0

  loop,read,%inifile%
  {
    if regexmatch(A_Loopreadline,"\[(.*)?]")
      {
        inisections+= 1
        section%inisections%:=regexreplace(A_loopreadline,"(\[)(.*)?(])","$2")
        section%inisections%_keys:=0
      }
    else if regexmatch(A_LoopReadLine,"(\w+)=(.*)")
      {
        section%inisections%_keys+= 1
        key:=section%inisections%_keys
        section%inisections%_key%key%:=regexreplace(A_LoopReadLine,"(\w+)=(.*)","$1")
      }
  }
}

loadini(inifile="general_settings.ini"){
  global
  local sec,var
  loop,%inisections%
    {
      sec:=A_index
      loop,% section%a_index%_keys
        {
          var:=section%sec% "_" section%sec%_key%A_index%,
          Stringreplace,var,var,%a_space%,,All
          iniread,%var%,%inifile%,% section%sec%,% section%sec%_key%A_index%
          val%A_index%:=%var%
        }
    }
}

saveini(inifile="general_settings.ini"){
  global
  local sec,var
  loop,%inisections%
    {
      sec:=A_index
      loop,% section%a_index%_keys
        {
          var:=section%sec% "_" section%sec%_key%A_index%
          Stringreplace,var,var,%a_space%,,All
          var:=%var%
          iniwrite,%var%,%inifile%,% section%sec%,% section%sec%_key%A_index%
        }
    }
}

;=======
;hotkeys
;=======
ESC::
GuiClose:
ExitApp
