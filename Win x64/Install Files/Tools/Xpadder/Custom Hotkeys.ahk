;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;
; ^ = Left Control Key
; ! = Left Alt Key

#SingleInstance Force 
#InstallKeybdHook 
#InstallMouseHook 
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

flag1=0
X := A_ScreenWidth
Y := A_ScreenHeight

Gui, -Caption -DPIScale +AlwaysOnTop +ToolWindow
;Gui, show, center w%A_screenwidth% h%A_screenheight%, Center Test
Gui,Color,262626
;Gui +LastFound  
WinSet, TransColor, EEAA99 
WinSet AlwaysOnTop 
Gui, -Caption 
Gui, Margin, 0, 0 
Gui, add, picture, gdragger x0 y0 w1280 h-1 vPIC gCentre backgroundtrans, %A_ScriptDir%\Controller Maps\Controller Map - Steam.JPG

^!1::
Run,"%A_ScriptDir%\XboxExt.exe" /off 1
; Run,taskkill /F /IM xpadder.exe /T
; Sleep, 1000 ; 1 seconds
; Run,"%A_ScriptDir%\Controller-Profiles\Steam_Xbox360.xpadderprofile"
return

^!2::
Run,"%A_ScriptDir%\XboxExt.exe" /off 2
; Run,taskkill /F /IM xpadder.exe /T
; Sleep, 1000  ; 1 seconds
; Run,"%A_ScriptDir%\Controller-Profiles\Steam_Xbox360.xpadderprofile"
return

^!3::
Run,"%A_ScriptDir%\XboxExt.exe" /off 3
; Run,taskkill /F /IM xpadder.exe /T
; Sleep, 1000 ; 1 seconds
; Run,"%A_ScriptDir%\Controller-Profiles\Steam_Xbox360.xpadderprofile"
return

^!4::
Run,"%A_ScriptDir%\XboxExt.exe" /off 4
; Run,taskkill /F /IM xpadder.exe /T
; Sleep, 1000 ; 1 seconds
; Run,"%A_ScriptDir%\Controller-Profiles\Steam_Xbox360.xpadderprofile"
return

^!5::
Run,"C:\Program Files (x86)\Steam\Steam.exe" -bigpicture
return

^!6::
DetectHiddenWindows, Off	
Process, Exist, FreeVK.exe
status = %ErrorLevel% 
if status = 0
{
	Run FreeVK.exe
}
	IfWinNotExist ahk_class TMainForm
{
	WinShow, ahk_class TMainForm
	WinActivate, ahk_class TMainForm
}
Else
	IfWinExist, ahk_class TMainForm
{
	WinMinimize, ahk_class TMainForm
	WinHide, ahk_class TMainForm
}
Return

^!7::
	if flag1=1
	{
		Gui, Hide
		flag1=0
		return    ; and has not been cleared by and "up" 
					; ignore the keystroke and return without updating the image
	}
	
	Centre:
	flag1=1
	Gui, Show, center w%A_screenwidth% h%A_screenheight%
	Gui, maximize,
	GuiControlget, PIC, Pos
	offX :=  (X/2) - (PICW /2)
	offY :=  (Y/2) - (PICH /2)
	guicontrol, move, PIC, x%offX%, y%offY%
	
Return

;^!7 up::
	;flag1=0  ; since we are in an "up" clear the flag 
	;Gui, Hide
;Return 

;  How to enable Drag for a GUI without a Titlebar ?
;   http://www.autohotkey.com/forum/viewtopic.php?p=64185#64185
dragger:
 PostMessage, 0xA1, 2,,, A 
return

GuiClose: 
ExitApp