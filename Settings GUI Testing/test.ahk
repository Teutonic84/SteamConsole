#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
#Include .\Includes\Class_GroupBox.ahk
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1

Loop, 6
{
  If (testvar = "")
  {
    testvar = test%A_index%
  } else {
    testvar = %testvar%|test%A_index%
  }
}
GB = GB1

GBTHeight:=10
Gui, +LastFound
Gui, Add, Text, vtest1, A Label
Gui, Add, Text, x162 yMargin vtest2, Nother Label
Gui, Add, Edit, Section vtest3 xMargin, This is a Control
Gui, Add, Edit, vtest4 ys x162, This is a Control
Gui, Add, CheckBox, Section vtest5 xMargin, CheckBox 1
Gui, Add, CheckBox, vtest6 ys x160, CheckBox 2
GroupBox(%GB%, "Testing", GBTHeight, 10, testvar)

Gui, Show, , GroupBox Test

return

GuiClose:
ExitApp
