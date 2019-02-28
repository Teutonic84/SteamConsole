;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;  SetBatchLines, -1    ; performance optimization for loops
;  Gui, Add, ListView, w500 h500 r25 Checked, List of Games & Programs Found   ; this creates the listview, 15 rows high
;  Gui, Add, Button, gButton_Import w100 default section, Import To Steam
;  Gui, Add, Button, ys gGuiClose w100 , Exit
;  gosub Button_Import ; < this will fill the listview for the first time
;  Gui, Show, x286 y114 w518 h545
;Return

;Button_Import:
;  FileRead, contents, software_list.txt
;  Loop, parse, contents, `n  ; this parses the content of the variable, which contains the contents of the software_list.txt file
;  {
;    if A_LoopField <>
;      LV_Add("", A_LoopField)  ; this adds each line to the last created listview
;  }
;  contents :=
;return

;GuiClose:
;ExitApp



#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
setbatchlines -1
#Singleinstance, ignore
UrlDownloadToFile,http://icons.iconarchive.com/icons/custom-icon-design/mono-general-4/32/refresh-icon.png, %A_Temp%\Refresh_icon.png
UrlDownloadToFile,http://png-4.findicons.com/files/icons/2354/dusseldorf/32/config.png, %A_Temp%\Config_icon.png
UrlDownloadToFile,https://cdn4.iconfinder.com/data/icons/iconic/raster/32/arrow_left_alt1.png, %A_Temp%\Back_icon.png
 
 
IfNotExist, Config.ini
	{
	1LibraryName=Display Name For Library (e.g. Steam...)
	1HDDLocation=Path To Folder To Search (e.g. G:\Steam\Steamapps\common)
	Goto Configuration
	}
Else
	{
	IniRead, 1LibraryName, Config.ini, Library1, Name, %A_Space%
	IniRead, 1HDDLocation, Config.ini, Library1, HDDLocation, %A_Space%
	IniRead, 2LibraryName, Config.ini, Library2, Name, %A_Space%
	IniRead, 2HDDLocation, Config.ini, Library2, HDDLocation, %A_Space%
	IniRead, 3LibraryName, Config.ini, Library3, Name, %A_Space%
	IniRead, 3HDDLocation, Config.ini, Library3, HDDLocation, %A_Space%
	IniRead, 4LibraryName, Config.ini, Library4, Name, %A_Space%
	IniRead, 4HDDLocation, Config.ini, Library4, HDDLocation, %A_Space%
	Goto MainMenu
	}
 
Configuration:
Gui, Destroy
 
IfExist, Config.ini
	{
	IniRead, 1LibraryName, Config.ini, Library1, Name, %A_Space%
	IniRead, 1HDDLocation, Config.ini, Library1, HDDLocation, %A_Space%
	IniRead, 2LibraryName, Config.ini, Library2, Name, %A_Space%
	IniRead, 2HDDLocation, Config.ini, Library2, HDDLocation, %A_Space%
	IniRead, 3LibraryName, Config.ini, Library3, Name, %A_Space%
	IniRead, 3HDDLocation, Config.ini, Library3, HDDLocation, %A_Space%
	IniRead, 4LibraryName, Config.ini, Library4, Name, %A_Space%
	IniRead, 4HDDLocation, Config.ini, Library4, HDDLocation, %A_Space%
	}
 
Gui, Configuration:New
Gui, Configuration:Font, s8, Segoe UI Semibold, q5
Gui, Configuration:Add, Text, x10 y22, Name Of Library
Gui, Configuration:Add, Edit, x250 y20 w350 v1LibraryName, %1LibraryName%
Gui, Configuration:Add, Text, x10 y47, Define Location Of Games Folder
Gui, Configuration:Add, Edit, x250 y45 w350 v1HDDLocation, %1HDDLocation%
Gui, Configuration:Add, Text, x10 y162, Name Of 2nd Library
Gui, Configuration:Add, Edit, x250 y160 w350 v2LibraryName, %2LibraryName%
Gui, Configuration:Add, Text, x10 y187, Define Location Of Games Folder
Gui, Configuration:Add, Edit, x250 y185 w350 v2HDDLocation, %2HDDLocation%
Gui, Configuration:Add, Text, x10 y302, Name Of 3rd Library
Gui, Configuration:Add, Edit, x250 y300 w350 v3LibraryName, %3LibraryName%
Gui, Configuration:Add, Text, x10 y327, Define Location Of Games Folder
Gui, Configuration:Add, Edit, x250 y325 w350 v3HDDLocation, %3HDDLocation%
Gui, Configuration:Add, Text, x10 y442, Name Of 4th Library
Gui, Configuration:Add, Edit, x250 y440 w350 v4LibraryName, %4LibraryName%
Gui, Configuration:Add, Text, x10 y467, Define Location Of Games Folder
Gui, Configuration:Add, Edit, x250 y465 w350 v4HDDLocation, %4HDDLocation%
Gui, Configuration:Font, s14, Segoe UI Semibold, q5
Gui, Configuration:Add, Button, x10 w590 gSaveConfig, Save
Gui, Configuration:+AlwaysOnTop -MinimizeBox -MaximizeBox
Gui, Configuration:Show, , SteamConsole Game Manager Configuration
 
return
 
SaveConfig:
Gui, Configuration:Submit
If 1LibraryName=Display Name For Library (e.g. Steam...)
	{
	Msgbox, FILL IN THE CONFIG BEFORE SAVING
	Goto Configuration
	Sleep, 2000
	}
If	1HDDLocation=Path To Folder To Search (e.g. G:\Steam\Steamapps\common)
	{
	Msgbox, FILL IN THE CONFIG BEFORE SAVING
	Goto Configuration
	Sleep, 2000
	}
If 1LibraryName
	{
	If !1HDDLocation
		{
		Msgbox, Mandatory Field, FILL IN THE CONFIG PROPERLY
		Goto Configuration
		Sleep, 2000
		}
	}
If 2LibraryName
	{
	If !2HDDLocation
		{
		Msgbox, Mandatory Field, FILL IN THE CONFIG PROPERLY
		Goto Configuration
		Sleep, 2000
		}
	}
If 3LibraryName
	{
	If !3HDDLocation
		{
		Msgbox, Mandatory Field, FILL IN THE CONFIG PROPERLY
		Goto Configuration
		Sleep, 2000
		}
	}
 
If 4LibraryName
	{
	If !4HDDLocation
		{
		Msgbox, Mandatory Field, FILL IN THE CONFIG PROPERLY
		Goto Configuration
		Sleep, 2000
		}
	}
 
StringRight, BackSlashCheck, 1HDDLocation, 1
If BackSlashCheck=`\
	{
	StringTrimRight, 1HDDLocation, 1HDDLocation, 1
	}
 
StringRight, BackSlashCheck, 2HDDLocation, 1
If BackSlashCheck=`\
	{
	StringTrimRight, 2HDDLocation, 2HDDLocation, 1
	}
 
StringRight, BackSlashCheck, 3HDDLocation, 1
If BackSlashCheck=`\
	{
	StringTrimRight, 3HDDLocation, 3HDDLocation, 1
	}
 
StringRight, BackSlashCheck, 4HDDLocation, 1
If BackSlashCheck=`\
	{
	StringTrimRight, 4HDDLocation, 4HDDLocation, 1
	}
 
Iniwrite, %1LibraryName%, Config.ini, Library1, Name
Iniwrite, %1HDDLocation%, Config.ini, Library1, HDDLocation
Iniwrite, %2LibraryName%, Config.ini, Library2, Name
Iniwrite, %2HDDLocation%, Config.ini, Library2, HDDLocation
Iniwrite, %3LibraryName%, Config.ini, Library3, Name
Iniwrite, %3HDDLocation%, Config.ini, Library3, HDDLocation
Iniwrite, %4LibraryName%, Config.ini, Library4, Name
Iniwrite, %4HDDLocation%, Config.ini, Library4, HDDLocation
 
 
MainMenu:
Gui, GamesList:Destroy
Gui, MainMenu:New
gui, MainMenu:font, s12, Segoe UI Semibold, q5
Gui, MainMenu:Add, Text, , Select Which Library You Wish To Manage
Gui, MainMenu:Add, Picture, gConfirmConfiguration2 x380  y+-24 w32 h32, %A_Temp%\Config_icon.png
gui, MainMenu:font, s20, Segoe UI Semibold, q5
Gui, MainMenu:Add, Button, x15 w400 gSetLibrary1, %1LibraryName%
If 2LibraryName
	{
	Gui, MainMenu:Add, Button, x15 w400 gSetLibrary2, %2LibraryName%
	}
If 3LibraryName
	{
	Gui, MainMenu:Add, Button, x15 w400 gSetLibrary3, %3LibraryName%
	}
If 4LibraryName
	{
	Gui, MainMenu:Add, Button, x15 w400 gSetLibrary4, %4LibraryName%
	}
Gui, MainMenu:+AlwaysOnTop -MinimizeBox -MaximizeBox 	
Gui, MainMenu:Show, Center, SteamConsole Import Manager
 
return
 
SetLibrary1:
 
UseLibraryName=%1LibraryName%
UseHDDLocation=%1HDDLocation%
Goto DriveUse
 
SetLibrary2:
 
UseLibraryName=%2LibraryName%
UseHDDLocation=%2HDDLocation%
Goto DriveUse
 
SetLibrary3:
 
UseLibraryName=%3LibraryName%
UseHDDLocation=%3HDDLocation%
Goto DriveUse
 
SetLibrary4:
 
UseLibraryName=%4LibraryName%
UseHDDLocation=%4HDDLocation%
Goto DriveUse
 
DriveUse:
 
DriveSpaceFree, HDDFree, %UseHDDLocation%
HDDFree:=HDDFree/1024
HDDFree:=Round(HDDFree, 0)
 
TrayTip, Loading...., Fetching List Of %UseLibraryName% Games
 

; Create the ListView with two columns, Name and Size: 
 
HDDLibrary:
Gui, Destroy
Gui, MainMenu:Hide
Gui, Configuration:Hide
Gui, GamesList:New
Gui, GamesList: -MinimizeBox -MaximizeBox 
Gui, GamesList:Font, s16, Segoe UI Semibold, q5
Gui, GamesList:Add, Text, x10 y14, Games On HDD
Gui, GamesList:Font, s12, Segoe UI Semibold, q5
Gui, GamesList:Add, Text, x530 y+-22 gExploreHDD, %HDDFree% GB Free
Gui, GamesList:Add, Picture, gMainMenu x650 y10 w32 h32, %A_Temp%\Back_icon.png
Gui, GamesList:Add, Picture, gDriveUse x700 y10 w32 h32, %A_Temp%\Refresh_icon.png
Gui, GamesList:Add, Picture, gConfirmConfiguration x750 y10 w32 h32, %A_Temp%\Config_icon.png
Gui, GamesList:Font, s12, Segoe UI Semibold, q5
Gui, GamesList:Add, ListView, vLV1 x10 r22 checked w780 gHDDListView -Multi, Name|Size (GB)
Gui, GamesList:Add, Button, gButton_Import w150 default section, Import To Steam
Gui, GamesList:Add, Button, ys gGuiClose w150 , Exit

; Gather a list of file names from a folder and put them into the ListView:
Loop, %UseHDDLocation%\*.*, 2
	{
	File=%A_LoopFileDir%\%A_LoopFileName%
	; FILE_ATTRIBUTE_REPARSE_POINT := 0x400
attributes := DllCall("GetFileAttributes","str",File)
if (attributes != -1 && attributes & 0x400)
	{
    Sleep, 1
	}
else
	{
	Foldersize=0
	Loop, %A_LoopFileDir%\%A_LoopFileName%\*.*, 1, 1
		{
		Foldersize+=%A_LoopFileSize%
		}
	Foldersize:=(((Foldersize/1024)/1024)/1024)
	Foldersize:=Round(Foldersize, 2)
	If FolderSize>0
		{
		Gui, ListView, LV1
		LV_Add("", A_LoopFileName, Foldersize)
		}
	}
	}
 
LV_ModifyCol(1, 685)  ; Auto-size each column to fit its contents.
LV_ModifyCol(2, "90 Integer")  ; For sorting purposes, indicate that column 2 is an integer.
 
;SSDLibrary:
;Gui, GamesList:Font, s16, Segoe UI Semibold, q5
;If UseSSDLocation2
;	{
;	Gui, Gameslist:Add, Text, x10, Games On SSDs
;	}
;Else
;	{
;	Gui, Gameslist:Add, Text, x10, Games On SSD
;	}
;Gui, GamesList:Font, s12, Segoe UI Semibold, q5
;If !UseSSDLocation2
;	{
;	Gui, GamesList:Add, Text, x900 y+-22 gExploreSSD1, %SSD1Free% GB Free
;	}
;If UseSSDLocation3
;	{
;	Gui, GamesList:Add, Text, x700 y+-22, %SSD1Free% GB Free | %SSD2Free% GB Free | %SSD3Free% GB Free
;	}
;If !UseSSDLocation3
;	{
;	If UseSSDLocation2
;		{
;		Gui, GamesList:Add, Text, x800 y+-22, %SSD1Free% GB Free | %SSD2Free% GB Free
;		}
;	}
;Gui, GamesList:ListView, LV2
 
;If UseSSDLocation2
;	{
;	Gui, GamesList:Add, ListView, vLV2 x10 r11 w980 gSSDListView -Multi, Name|SSD Library|Size (GB)
;	}
;Else
;	{
;	Gui, GamesList:Add, ListView, vLV2 x10 r11 w980 gSSDListView -Multi, Name|Size (GB)
;	}
; Gather a list of file names from a folder and put them into the ListView:
;Loop, %UseSSDLocation1%\*.*, 2
;	{
;	Foldersize=0
;	Loop, %A_LoopFileDir%\%A_LoopFileName%\*.*, 1, 1
;		{
;		Foldersize+=%A_LoopFileSize%
;		}
;	Foldersize:=(((Foldersize/1024)/1024)/1024)
;	Foldersize:=Round(Foldersize, 2)
;	Gui, ListView, LV2
;	If UseSSDLocation2
;		{
;		LV_Add("", A_LoopFileName,"#1", Foldersize)
;		}
;	Else
;		{
;		LV_Add("", A_LoopFileName, Foldersize)
;		}
;	}
;If UseSSDLocation2
;	{
;	Loop, %UseSSDLocation2%\*.*, 2
;		{
;		Foldersize=0
;		Loop, %A_LoopFileDir%\%A_LoopFileName%\*.*, 1, 1
;			{
;			Foldersize+=%A_LoopFileSize%
;			}
;		Foldersize:=(((Foldersize/1024)/1024)/1024)
;		Foldersize:=Round(Foldersize, 2)
;		Gui, ListView, LV2
;		LV_Add("", A_LoopFileName,"#2", Foldersize)
;		}
;	}
;If UseSSDLocation3
;	{
;	Loop, %UseSSDLocation3%\*.*, 2
;		{
;		Foldersize=0
;		Loop, %A_LoopFileDir%\%A_LoopFileName%\*.*, 1, 1
;			{
;			Foldersize+=%A_LoopFileSize%
;			}
;		Foldersize:=(((Foldersize/1024)/1024)/1024)
;		Foldersize:=Round(Foldersize, 2)
;		Gui, ListView, LV2
;		LV_Add("", A_LoopFileName, "#3", Foldersize)
;		}
;	}
; 
;If !UseSSDLocation2
;	{
;	LV_ModifyCol(1, 869)  ; Auto-size each column to fit its contents.
;	LV_ModifyCol(2, "90 Integer")  ; For sorting purposes, indicate that column 2 is an integer.
;	}
;Else
;	{
;	LV_ModifyCol(1, 740)  ; Auto-size each column to fit its contents.
;	LV_ModifyCol(2, 128)
;	LV_ModifyCol(3, "90 Integer")  ; For sorting purposes, indicate that column 2 is an integer.
;	}
 
 
 
; Display the window and return. The script will be notified whenever the user double clicks a row.
Gui, GamesList:Add, Button, Hidden Default gHDDListView xp yp
Gui, GamesList:Show, w800 h692 Center, %UseLibraryName% Library Manager
return
 
HDDListView:
if A_GuiEvent = DoubleClick
{
 GuiControlGet, fCTRL, FocusV
 If !InStr(fCTRL,"LV") = 1
  return
 Gui, ListView, %fCTRL%
 LV_GetText(text,LV_GetNext(0,"Focused"))
 Gui, GamesList:Hide
 HDDFolder=%UseHDDLocation%\%text%
;If !UseSSDLocation2
;	{
;	LV_GetText(SSD1GameSize,LV_GetNext(0,"Focused"),2)
;	SSD1FreeAfter:=SSD1Free-SSD1GameSize
;	SSD1FreeAfter:=Round(SSD1FreeAfter, 0)
;	If SSD1FreeAfter < 0
;		{
;		Msgbox, Insufficient Free Space On SSD
;		Gui, GamesList:Show
;		Return
;		}
;	Msgbox, 4, Move %text% To SSD, Do you Want To Move %text% to SSD?`n`nCurrent Free Space`t`t%SSD1Free% GB`nAfter Move Free Space`t%SSD1FreeAfter% GB
;	IfMsgbox, No
;		{
;		Gui, GamesList:Show
;		}
;	Else
;		{
;		SSDFolder=%UseSSDLocation1%\%text%
;		HDDFolder=%UseHDDLocation%\%text%
;		Goto CopyToSSD
;		}
;	}
;If UseSSDLocation2
;		{
;		LV_GetText(SSD1GameSize,LV_GetNext(0,"Focused"),2)
;		LV_GetText(SSD2GameSize,LV_GetNext(0,"Focused"),2)
;		LV_GetText(SSD3GameSize,LV_GetNext(0,"Focused"),2)
;		SSD1FreeAfter:=SSD1Free-SSD1GameSize
;		SSD1FreeAfter:=Round(SSD1FreeAfter, 0)
;		SSD2FreeAfter:=SSD2Free-SSD2GameSize
;		SSD2FreeAfter:=Round(SSD2FreeAfter, 0)
;		SSD3FreeAfter:=SSD3Free-SSD3GameSize
;		SSD3FreeAfter:=Round(SSD3FreeAfter, 0)
;		If !UseSSDLocation3
;			{
;			SetTimer, ChangeButtonNames, 50 
;			MsgBox, 3, Move %text% To SSD, Do you Want To Move %text% to SSD?`n`n`t`t`t`tSSD1`tSSD2`nCurrent Free Space`t`t`t%SSD1Free% GB`t%SSD2Free% GB`nAfter Move Free Space`t`t%SSD1FreeAfter% GB`t%SSD2FreeAfter% GB
;			IfMsgBox, YES 
;				{
;				If SSD1FreeAfter < 0
;					{
;					Msgbox, Insufficient Free Space On SSD1
;					Gui, GamesList:Show
;					Return
;					}			
;				SSDFolder=%UseSSDLocation1%\%text%
;				Goto CopyToSSD
;				}
;			IfMsgBox, NO
;				{
;				If SSD2FreeAfter < 0
;					{
;					Msgbox, Insufficient Free Space On SSD2
;					Gui, GamesList:Show
;					Return
;					}	
;				SSDFolder=%UseSSDLocation2%\%text%
;				Goto CopyToSSD
;				}
;			IfMsgBox, Cancel
;				{
;				Gui, GamesList:Show
;				}
;			}
;		If UseSSDLocation3
;			{
;			Gui, SSDChooser:New
;			Gui, SSDChooser:Add, Text, ,Do you Want To Move %text% to SSD?`n`nCurrent Free Space %SSD1Free% GB | %SSD2Free% GB | %SSD3Free% GB`nAfter Move Free Space %SSD1FreeAfter% GB | %SSD2FreeAfter% GB | %SSD3FreeAfter% GB
;			Gui, SSDChooser:Add, Button, gSSDLib1,SSD Library 1
;			Gui, SSDChooser:Add, Button, gSSDLib2,SSD Library 2
;			Gui, SSDChooser:Add, Button, gSSDLib3,SSD Library 3
;			Gui, SSDChooser:Add, Button, gSSDCancel,Cancel
;			Gui, SSDChooser:+AlwaysOnTop -MinimizeBox -MaximizeBox 
;			Gui, SSDChooser:Show, , Move %text% To SSD
;			}
;		}
}
return
 
;SSDListView:
;if A_GuiEvent = DoubleClick
;{
; GuiControlGet, fCTRL, FocusV
; If !InStr(fCTRL,"LV") = 1
;  return
; Gui, ListView, %fCTRL%
; LV_GetText(text,LV_GetNext(0,"Focused"))
; If UseSSDLocation2
;	{
;	LV_GetText(SSDLibraryNumber,LV_GetNext(0,"Focused"),2)
;	StringRight, SSDLibraryNumber, SSDLibraryNumber, 1
;	}
; Gui, GamesList:Hide
; MsgBox, 4, %text%, Move %text% TO HDD?
;	IfMsgbox, No
;		{
;		Gui, GamesList:Show
;		}
;	IfMsgbox, Yes
;		{
;		SSDFolder2=%UseSSDLocation1%\%text%
;		If SSDLibraryNumber=2
;			{
;			SSDFolder2=%UseSSDLocation2%\%text%
;			}
;		If SSDLibraryNumber=3
;			{
;			SSDFolder2=%UseSSDLocation3%\%text%
;			}
;		HDDFolder2=%UseHDDLocation%\%text%
;		Goto CopyToHDD
;		}
;}
;return
 
;CopyToHDD:
;FileRemoveDir, %HDDFolder2%, 1
;ShellFileOperation( 0x1, SSDFolder2, HDDFolder2, 0x10 0x8 0x200)
;goto DriveUse
 
;CopyToSSD:
;ShellFileOperation( 0x1, HDDFolder, SSDFolder, 0x10 0x8 0x200)
;Sleep, 100
;Runwait, %Comspec% /c mklink /j "%HDDFolder%\" "%SSDFolder%\", , hide
;goto DriveUse
 
 
ConfirmConfiguration:
Gui, GamesList:Hide
Goto Configuration
Msgbox, 4, Configuration, Do You Wish To Change The Configuration?
IfMsgbox, Yes
	{
	Goto Configuration
	}
IfMsgbox, No
	{
	Gui, GamesList:Show
	}
Return
 
ConfirmConfiguration2:
Gui, MainMenu:Hide
Goto Configuration
Msgbox, 4, Configuration, Do You Wish To Change The Configuration?
IfMsgbox, Yes
	{
	Goto Configuration
	}
IfMsgbox, No
	{
	Gui, MainMenu:Show
	}
Return
 
;SSDChooserGuiEscape:
;SSDChooserGuiClose:
ConfigurationGuiEscape:
ConfigurationGuiClose:
MainMenuGuiEscape:
MainMenuGuiClose:
GamesListGuiEscape:
GamesListGuiClose:
ExitApp  ; All of the above labels will do this.
 
;ChangeButtonNames: 
;IfWinNotExist, Move %text% To SSD
;    return  ; Keep waiting.
;SetTimer, ChangeButtonNames, off 
;WinActivate 
;ControlSetText, Button1, SSD Library 1
;ControlSetText, Button2, SSD Library 2
;ControlSetText, Button3, Cancel 
;return
 
;SSDLib1:
;If SSD1FreeAfter < 0
;	{
;	Msgbox, Insufficient Free Space On SSD1
;	Gui, GamesList:Show
;	Return
;	}	
;SSDFolder=%UseSSDLocation1%\%text%
;Goto CopyToSSD
 
;SSDLib2:
;If SSD2FreeAfter < 0
;	{
;	Msgbox, Insufficient Free Space On SSD1
;	Gui, GamesList:Show
;	Return
;	}	
;SSDFolder=%UseSSDLocation2%\%text%
;Goto CopyToSSD
 
;SSDLib3:
;If SSD3FreeAfter < 0
;	{
;	Msgbox, Insufficient Free Space On SSD1
;	Gui, GamesList:Show
;	Return
;	}	
;SSDFolder=%UseSSDLocation3%\%text%
;Goto CopyToSSD
 
;SSDCancel:
;Gui, SSDChooser:Destroy
;Gui, GamesList:Show
;return
 
ExploreHDD:
Run, explorer.exe %UseHDDLocation%
Return
 
;ExploreSSD1:
;Run, explorer.exe %UseSSDLocation1%
;Return
 
ShellFileOperation( fileO=0x0, fSource="", fTarget="", flags=0x0, ghwnd=0x0 )     
{
	;dout_f(A_ThisFunc)
	FO_MOVE   := 0x1
	FO_COPY   := 0x2
	FO_DELETE := 0x3
	FO_RENAME := 0x4
 
	FOF_MULTIDESTFILES :=  			0x1				; Indicates that the to member specifies multiple destination files (one for each source file) rather than one directory where all source files are to be deposited.
	FOF_SILENT := 					0x4				; Does not display a progress dialog box.
	FOF_RENAMEONCOLLISION := 		0x8				; Gives the file being operated on a new name (such as "Copy #1 of...") in a move, copy, or rename operation if a file of the target name already exists.
	FOF_NOCONFIRMATION := 			0x10			; Responds with "yes to all" for any dialog box that is displayed.
	FOF_ALLOWUNDO := 				0x40			; Preserves undo information, if possible. With del, uses recycle bin.
	FOF_FILESONLY := 				0x80			; Performs the operation only on files if a wildcard filename (*.*) is specified.
	FOF_SIMPLEPROGRESS := 			0x100			; Displays a progress dialog box, but does not show the filenames.
	FOF_NOCONFIRMMKDIR := 			0x200			; Does not confirm the creation of a new directory if the operation requires one to be created.
	FOF_NOERRORUI := 				0x400			; don't put up error UI
	FOF_NOCOPYSECURITYATTRIBS := 	0x800			; dont copy file security attributes
	FOF_NORECURSION := 				0x1000			; Only operate in the specified directory. Don't operate recursively into subdirectories.
	FOF_NO_CONNECTED_ELEMENTS := 	0x2000			; Do not move connected files as a group (e.g. html file together with images). Only move the specified files.
	FOF_WANTNUKEWARNING :=		 	0x4000			; Send a warning if a file is being destroyed during a delete operation rather than recycled. This flag partially overrides FOF_NOCONFIRMATION.
 
 
	; no more annoying numbers to deal with (but they should still work, if you really want them to)
	fileO := %fileO% ? %fileO% : fileO
 
	; the double ternary was too fun to pass up
	_flags := 0
	Loop Parse, flags, |
		_flags |= %A_LoopField%	
	flags := _flags ? _flags : (%flags% ? %flags% : flags)
 
	If ( SubStr(fSource,0) != "|" )
		fSource := fSource . "|"
 
	If ( SubStr(fTarget,0) != "|" )
		fTarget := fTarget . "|"
 
	char_size := A_IsUnicode ? 2 : 1
	char_type := A_IsUnicode ? "UShort" : "Char"
 
	fsPtr := &fSource
	Loop % StrLen(fSource)
		if NumGet(fSource, (A_Index-1)*char_size, char_type) = 124
			NumPut(0, fSource, (A_Index-1)*char_size, char_type)
 
	ftPtr := &fTarget
	Loop % StrLen(fTarget)
		if NumGet(fTarget, (A_Index-1)*char_size, char_type) = 124
			NumPut(0, fTarget, (A_Index-1)*char_size, char_type)
 
	VarSetCapacity( SHFILEOPSTRUCT, 60, 0 )                 ; Encoding SHFILEOPSTRUCT
	NextOffset := NumPut( ghwnd, &SHFILEOPSTRUCT )          ; hWnd of calling GUI
	NextOffset := NumPut( fileO, NextOffset+0    )          ; File operation
	NextOffset := NumPut( fsPtr, NextOffset+0    )          ; Source file / pattern
	NextOffset := NumPut( ftPtr, NextOffset+0    )          ; Target file / folder
	NextOffset := NumPut( flags, NextOffset+0, 0, "Short" ) ; options
 
	code := DllCall( "Shell32\SHFileOperation" . (A_IsUnicode ? "W" : "A"), UInt,&SHFILEOPSTRUCT )
	ErrorLevel := ShellFileOperation_InterpretReturn(code)
 
	Return NumGet( NextOffset+0 )
}
 
ShellFileOperation_InterpretReturn(c)
{
	static dict
	if !dict
	{
		dict := Object()
		dict[0x0]		:= 	""
		dict[0x71]		:=	"DE_SAMEFILE - The source and destination files are the same file."
		dict[0x72]		:=	"DE_MANYSRC1DEST - Multiple file paths were specified in the source buffer, but only one destination file path."
		dict[0x73]		:=	"DE_DIFFDIR - Rename operation was specified but the destination path is a different directory. Use the move operation instead."
		dict[0x74]		:=	"DE_ROOTDIR - The source is a root directory, which cannot be moved or renamed."
		dict[0x75]		:=	"DE_OPCANCELLED - The operation was cancelled by the user, or silently cancelled if the appropriate flags were supplied to SHFileOperation."
		dict[0x76]		:=	"DE_DESTSUBTREE - The destination is a subtree of the source."
		dict[0x78]		:=	"DE_ACCESSDENIEDSRC - Security settings denied access to the source."
		dict[0x79]		:=	"DE_PATHTOODEEP - The source or destination path exceeded or would exceed MAX_PATH."
		dict[0x7A]		:=	"DE_MANYDEST - The operation involved multiple destination paths, which can fail in the case of a move operation."
		dict[0x7C]		:=	"DE_INVALIDFILES	- The path in the source or destination or both was invalid."
		dict[0x7D]		:=	"DE_DESTSAMETREE	- The source and destination have the same parent folder."
		dict[0x7E]		:=	"DE_FLDDESTISFILE - The destination path is an existing file."
		dict[0x80]		:=	"DE_FILEDESTISFLD - The destination path is an existing folder."
		dict[0x81]		:=	"DE_FILENAMETOOLONG - The name of the file exceeds MAX_PATH."
		dict[0x82]		:=	"DE_DEST_IS_CDROM - The destination is a read-only CD-ROM, possibly unformatted."
		dict[0x83]		:=	"DE_DEST_IS_DVD - The destination is a read-only DVD, possibly unformatted."
		dict[0x84]		:=	"DE_DEST_IS_CDRECORD - The destination is a writable CD-ROM, possibly unformatted."
		dict[0x85]		:=	"DE_FILE_TOO_LARGE - The file involved in the operation is too large for the destination media or file system."
		dict[0x86]		:=	"DE_SRC_IS_CDROM - The source is a read-only CD-ROM, possibly unformatted."
		dict[0x87]		:=	"DE_SRC_IS_DVD - The source is a read-only DVD, possibly unformatted."
		dict[0x88]		:=	"DE_SRC_IS_CDRECORD - The source is a writable CD-ROM, possibly unformatted."
		dict[0xB7]		:=	"DE_ERROR_MAX - MAX_PATH was exceeded during the operation."
		dict[0x402]		:= 	"An unknown error occurred. This is typically due to an invalid path in the source or destination. This error does not occur on Windows Vista and later."
		dict[0x10000]	:=	"RRORONDEST	- An unspecified error occurred on the destination."
		dict[0x10074]	:=	"E_ROOTDIR | ERRORONDEST	- Destination is a root directory and cannot be renamed."
	}
 
	return dict[c] ? dict[c] : "Error code not recognized"
}

Button_Import:
  FileRead, contents, software_list.txt
  Loop, parse, contents, `n  ; this parses the content of the variable, which contains the contents of the software_list.txt file
  {
    if A_LoopField <>
      LV_Add("", A_LoopField)  ; this adds each line to the last created listview
  }
  contents :=
return

GuiClose:
ExitApp