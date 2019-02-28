#NoEnv
#Include ..\Includes\Class_ScrollGUI.ahk
SetBatchLines, -1
; ----------------------------------------------------------------------------------------------------------------------
; ChildGUI 1
Gui, New, +hwndHGUI +Resize
Gui, Margin, 20, 20
I := 0
Gui, Add, Button, vBtn1, Test Button
Gui, Add, Text, w370 h20 0x200 Section, % "Edit " . ++I
Gui, Add, Edit, xp y+0 wp r6 vEdit10, 1`n2`n3`n4`n5`n6`n7`n8`n9
Loop, 4 {
   Gui, Add, Text, xp y+0 wp h20 0x200, % "Edit " . ++I
   Gui, Add, Edit, xp y+0 wp r6 vEdit1%A_Index%, 1`n2`n3`n4`n5`n6`n7`n8`n9
}
Gui, Add, Text, ys wp h20 0x200, % "Edit " . ++I
Gui, Add, Edit, xp y+0 wp r6 vEdit20, 1`n2`n3`n4`n5`n6`n7`n8`n9
Loop, 4 {
   Gui, Add, Text, xp y+0 wp h20 0x200, % "Edit " . ++I
   Gui, Add, Edit, xp y+0 wp r6 vEdit2%A_Index%, 1`n2`n3`n4`n5`n6`n7`n8`n9
}
; Create ScrollGUI1 with both horizontal and vertical scrollbars and scrolling by mouse wheel
Global SG1 := New ScrollGUI(HGUI, 400, 400, "+Resize +LabelGui1", 3, 4)
; Show ScrollGUI1
SG1.Show("ScrollGUI1", "y0 xcenter")
; ----------------------------------------------------------------------------------------------------------------------
; ChildGUI 2
Gui, New, +hwndHGUI2
Gui, Margin, 20, 20
Gui, Font, s32
Gui, Add, Text, xm Border Hidden vTX1, Test
Gui, Add, Text, x+m yp w460 h300 Center 0x200 Border Section, GUI number 2
Gui, Font
Gui, Add, Button, xs wp gShowHide, Show/Hide additional controls.
Gui, Font, s32
Gui, Add, Text, ys wp h300 Center 0x200 Border Hidden vTX2, Hidden Text 1
Gui, Add, Text, xs wp h300 Center 0x200 Border Hidden vTX3, Hidden Text 2
Gui, Add, Text, xs wp h300 Center 0x200 Border Hidden vTX4, Hidden Text 3
; Create ScrollGUI2 with both horizontal and vertical scrollbars
SG2 := New ScrollGUI(HGUI2, 600, 200, "+Resize +LabelGui2")
; Show ScrollGUI2
SG2.Show("ScrollGUI2", "x0 yCenter")
Return
; ----------------------------------------------------------------------------------------------------------------------
ShowHide:
   GuiControlGet, V, %HGUI2%:Visible, TX1
   GuiControl, %HGUI2%:Hide%V%, TX1
   GuiControl, %HGUI2%:Hide%V%, TX2
   GuiControl, %HGUI2%:Hide%V%, TX3
   GuiControl, %HGUI2%:Hide%V%, TX4
   SG2.AdjustToChild()
Return
; ----------------------------------------------------------------------------------------------------------------------
Gui1Close:
Gui1Escape:
ExitApp
; ----------------------------------------------------------------------------------------------------------------------
Gui1Size:
Return
Gui2Size:
Return
; ----------------------------------------------------------------------------------------------------------------------
Gui2Close:
Gui2Escape:
   SG2 := ""
Return
