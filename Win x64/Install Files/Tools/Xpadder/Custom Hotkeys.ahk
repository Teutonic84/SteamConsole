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

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

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
Run,%COMSPEC% /C cd ..\.. && cd "Docs\Controller Maps" && write "360 Controller.rtf"
; Run,write "%A_WorkingDir%\Docs\Controller Maps\360 Controller.rtf"
return