#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

  SetBatchLines, -1    ; performance optimization for loops
  Gui, Add, ListView, w500 h500 r25 Checked, List of Games & Programs Found   ; this creates the listview, 15 rows high
  Gui, Add, Button, gButton_Import w100 default section, Import To Steam
  Gui, Add, Button, ys gGuiClose w100 , Exit
  gosub Button_Import ; < this will fill the listview for the first time
  Gui, Show, x286 y114 w518 h545
Return

Button_Import:
  FileRead, contents, software_list.csv
  Loop, parse, contents, `n  ; this parses the content of the variable, which contains the contents of the software_list.txt file
  {
    if A_LoopField <>
      LV_Add("", A_LoopField)  ; this adds each line to the last created listview
  }
  contents :=
return

GuiClose:
ExitApp