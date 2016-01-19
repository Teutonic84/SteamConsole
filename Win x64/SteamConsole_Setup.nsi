#============================
#| Define Variables/Options |
#============================
!include "nsDialogs.nsh"
!include "winmessages.nsh"
!include "logiclib.nsh"
!include "x64.nsh"
!include "MUI.nsh"
!include "MUI_EXTRAPAGES.nsh"
!include "nsProcess.nsh"
!include "Sections.nsh"
!include "zipdll.nsh"

Insttype "/CUSTOMSTRING=Custom"
Insttype "Standard Installation"
#Insttype "Dualshock Installation"

!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\win-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\win-uninstall.ico"
!define VERSION "v1.3.1.12"

Name "SteamConsole" # The name of the installer
OutFile "SteamConsole_Setup.exe" # The file to write
InstallDir "C:\SteamConsole" # The default installation directory
DirText "Choose a folder to install SteamConsole to." # The text to prompt the user to enter a directory
ComponentText "Please choose components to install. If this is your first time running the setup, make sure prerequisites is checked."
RequestExecutionLevel admin
ShowInstDetails show

!insertmacro MUI_PAGE_LICENSE "License.rtf"
!insertmacro MUI_PAGE_README "Changelog.rtf"
Page custom installwarning
Page directory
Page components
Page instfiles
Page custom setupfinished

Section "Core Files (Required)" 
  SectionIn RO
    # Required files here
	KillProcDLL::KillProc "Xpadder.exe"
	ExecDos::exec /NOUNLOAD /TOSTACK "$INSTDIR\Scripts\killprocess.bat" "" ""
	SetOutPath $INSTDIR
	File /r "Changelog.rtf"
	File /r "License.rtf"
	File /r "README.txt"
	File "SteamConsole.7z"
	Nsis7z::ExtractWithDetails "SteamConsole.7z" # Extract all files from 7zip file to install directory based off of user's selection
	Delete "$INSTDIR\SteamConsole.7z"
	SetOutPath "$INSTDIR\Scripts"
	CreateShortCut "$INSTDIR\Steam Launch.lnk" "$INSTDIR\Scripts\Steam_Open.bat" "" "$INSTDIR\Images\SteamConsole.ico"
	SetOutPath $INSTDIR
		SetRegView 64
		WriteRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\Tools\Xpadder\Xpadder.exe" "~ RUNASADMIN WIN7RTM"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "DisplayIcon" "$INSTDIR\Images\SteamConsole.ico"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "DisplayName" "SteamConsole (64-Bit)"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "DisplayVersion" "1.3.2.22"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "InstallLocation" "$INSTDIR"
		WriteRegDWORD HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "NoModify" "0x00000001"
		WriteRegDWORD HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "NoRepair" "0x00000001"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "UninstallString" "$INSTDIR\SteamConsole_uninstaller.exe"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "Version" "1.3.2"
		SetOutPath $INSTDIR\Scripts
		ExecDos::exec /NOUNLOAD /ASYNC /TOSTACK "$INSTDIR\Scripts\open_xpadder.bat" "" ""
	MessageBox MB_OK '"Core Files Installation Complete!"'
	SetOutPath $INSTDIR\Scripts
	ExecDos::exec /NOUNLOAD /TOSTACK "$INSTDIR\Scripts\close_xpadder.bat" "" ""
SectionEnd
 
Section "Prerequisites" SEC_PREREQS
  SectionIn 1
	ExecWait '"$INSTDIR\Installs\dxwebsetup.exe" /Q'
	ExecWait '"$INSTDIR\Installs\vcredist_x86 (2013).exe" /passive'
	ExecWait '"$INSTDIR\Installs\vcredist_x64 (2013).exe" /passive'
SectionEnd

Section "Start Menu & Desktop Shortcuts" SEC_STARTMENU
	SectionIn 1
	SetOutPath $INSTDIR
	SetShellVarContext all
	CreateDirectory "$SMPROGRAMS\SteamConsole"
	SetOutPath "$INSTDIR\Tools\Ice"
	CreateShortCut "$SMPROGRAMS\SteamConsole\ROM Importer.lnk" "$INSTDIR\Tools\Ice\Ice-Start.bat" "" "$INSTDIR\Images\ROM_Importer.ico"
	CreateShortCut "$DESKTOP\ROM Importer.lnk" "$INSTDIR\Tools\Ice\Ice-Start.bat" "" "$INSTDIR\Images\ROM_Importer.ico"
	
	FileOpen $0 "$INSTDIR\Scripts\Steam_Open.bat" w
	FileWrite $0 "echo off"
	FileWrite $0 "$\r$\n" # go to new line
	FileWrite $0 "cd .."
	FileWrite $0 "$\r$\n"
	FileWrite $0 "set dirpath=%cd%"
	FileWrite $0 "$\r$\n"
	FileWrite $0 'if exist "%dirpath%\steam_path.txt" del "%dirpath%\steam_path.txt"'
	FileWrite $0 "$\r$\n"
	FileWrite $0 "$\r$\n"
	FileWrite $0 '  taskkill /f /im "Custom Hotkeys.exe"'
	FileWrite $0 "$\r$\n"
    FileWrite $0 '  cscript.exe "%dirpath%\Scripts\steam_path_check.vbs" > "%dirpath%\steam_path.txt"'
	FileWrite $0 "$\r$\n"
	FileWrite $0 "$\r$\n"
	FileWrite $0 ":steampath"
	FileWrite $0 "$\r$\n"
	FileWrite $0 'for /F "usebackq delims=" %%i in ("%dirpath%\steam_path.txt") do set "steampath=%%i"'
	FileWrite $0 "$\r$\n"
	FileWrite $0 'del "%dirpath%\steam_path.txt"'
	FileWrite $0 "$\r$\n"
	FileWrite $0 "$\r$\n"
	FileWrite $0 '"%dirpath%\Tools\Xpadder\Xpadder.exe" /C'
	FileWrite $0 "$\r$\n"
	FileWrite $0 "cls"
	FileWrite $0 "$\r$\n"
	FileWrite $0 "ECHO."
	FileWrite $0 "$\r$\n"
	FileWrite $0 "ECHO."
	FileWrite $0 "$\r$\n"
	FileWrite $0 "ECHO          **       ****    *****   ***     ****  **    **    *****"
	FileWrite $0 "$\r$\n"
	FileWrite $0 "ECHO          **      **  **  **   **  ** **    **   ***   **   **   **"
	FileWrite $0 "$\r$\n"
	FileWrite $0 "ECHO          **      **  **  *******  **  **   **   ** *  **  **"
	FileWrite $0 "$\r$\n"
	FileWrite $0 "ECHO          **      **  **  **   **  **  **   **   **  * **  **  ****"
	FileWrite $0 "$\r$\n"
	FileWrite $0 "ECHO          ******  **  **  **   **  ** **    **   **   ***   **   **"
	FileWrite $0 "$\r$\n"
	FileWrite $0 "ECHO          ******   ****   **   **  ***     ****  **    **    *****"
	FileWrite $0 "$\r$\n"
	FileWrite $0 "ECHO."
	FileWrite $0 "$\r$\n"
	FileWrite $0 "ECHO."
	FileWrite $0 "$\r$\n"
	FileWrite $0 "ECHO."
	FileWrite $0 "$\r$\n"
	FileWrite $0 "echo."
	FileWrite $0 "$\r$\n"
	FileWrite $0 'start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"'
	FileWrite $0 "$\r$\n"
	FileWrite $0 'start "" "%dirpath%\Tools\Xpadder\Xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"'
	FileWrite $0 "$\r$\n"
	FileWrite $0 'start "" "%steampath%\Steam.exe" -start steam://open/bigpicture'
	FileWrite $0 "$\r$\n"
	FileWrite $0 "exit"
	FileClose $0
	
	SetOutPath "$INSTDIR\Scripts"
	CreateShortCut "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SteamConsole\Steam Launch.lnk" "$INSTDIR\Scripts\Steam_Open.bat" "" "$INSTDIR\Images\SteamConsole.ico"
	CreateShortCut "$DESKTOP\Steam Launch.lnk" "$INSTDIR\Scripts\Steam_Open.bat" "" "$INSTDIR\Images\SteamConsole.ico"
	SetOutPath $INSTDIR

SectionEnd

#Section "Search ROMS" SEC_ROMSEARCH
  #SectionIn 1
    # Standard installation files here
#SectionEnd

Section "Import ROMS" SEC_ROMIMPORT
  SectionIn 1
    # Scan user defined folders for ROM files and move them to ..\SteamConsole\Emulators\ROMS
	
	# Run Ice to import ROMS into Steam
	MessageBox MB_OK '"NOTE: Please make sure you move all your ROM files to ..\SteamConsole\Emulators\ROMS\CONSOLE before continuing. Where CONSOLE is the name of the game system the ROM is for (NES, SNES, Genesis, N64, etc.)"'
	SetOutPath "$INSTDIR\Tools\Ice"
	ExecDos::exec /NOUNLOAD /TOSTACK "Ice-Initial-Run.bat" "" ""
	ExecWait '"ice.exe"'
	Delete "config.txt"
	CopyFiles /SILENT /FILESONLY "config_blank.txt" "config.txt"
	Delete "emulators.txt"
	CopyFiles /SILENT /FILESONLY "emulators_blank.txt" "emulators.txt"
SectionEnd

Section "DS3 & DS4 (Not Implemented Yet)" SEC_DS3
  SectionIn 2
    # Standard installation files here
SectionEnd

Section "DS4 Only (Not Implemented Yet)" SEC_DS4
  SectionIn 2
    # Standard installation files here
SectionEnd
 
Function .onInit
  StrCpy $1 ${SEC_PREREQS}
  StrCpy $1 ${SEC_STARTMENU}
  #StrCpy $1 ${SEC_ROMSEARCH}
  StrCpy $1 ${SEC_ROMIMPORT}
  StrCpy $1 ${SEC_DS3}
  StrCpy $1 ${SEC_DS4}
FunctionEnd

LangString DESC_Section1 ${LANG_ENGLISH} "DirectX, MSVC 2013 x86, MSVC 2013 x64, Xpadder."
LangString DESC_Section2 ${LANG_ENGLISH} "Create program shortcuts in the start menu and on the desktop."
#LangString DESC_Section2 ${LANG_ENGLISH} "Search for ROMS on your Hard Drive and move them to the ROMS folder found in the Emulators folder within the root SteamConsole folder."
LangString DESC_Section3 ${LANG_ENGLISH} "Import ROMS in the subfolders found in the Emulators folder within the root SteamConsole folder."
LangString DESC_Section4 ${LANG_ENGLISH} "Dualshock 3 & Dualshock 4 controller support (DSTool Reloaded)."
LangString DESC_Section5 ${LANG_ENGLISH} "Dualshock 4 controller support only (DS4Tool)."

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_PREREQS} $(DESC_Section1)
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_STARTMENU} $(DESC_Section2)
  #!insertmacro MUI_DESCRIPTION_TEXT ${SEC_ROMSEARCH} $(DESC_Section2)
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_ROMIMPORT} $(DESC_Section3)
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_DS3} $(DESC_Section4)
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_DS4} $(DESC_Section5)
!insertmacro MUI_FUNCTION_DESCRIPTION_END
 
Function .onSelChange
	${If} ${SectionIsSelected} ${SEC_DS3}
		${If} ${SectionIsSelected} ${SEC_DS4}
			MessageBox MB_OK "WARNING: Do not select both Dualshock options, only one"
			!insertmacro UnSelectSection ${SEC_DS3}
			!insertmacro UnSelectSection ${SEC_DS4}
		${EndIf}
	${EndIf}
	${IfNot} ${SectionIsSelected} ${SEC_PREREQS}
		MessageBox MB_OK "WARNING: If you uncheck to install prerequisites and not all are installed, SteamConsole won't function properly. Prereqs: DirectX9 (latest version), Microsoft Visual C++ 2013 x86 (32bit windows) both x86 & x64 for 64bit windows, and Xpadder.)"
	${EndIf}
	#${If} ${SectionIsSelected} ${SEC_ROMIMPORT}
		#MessageBox MB_OK "NOTE: First move all your ROM files into ..\SteamConsole\ROMS\CONSOLE where CONSOLE is the game system (ex: NES, SNES, N64, Genesis, PS2, etc). Otherwise they won't get imported into Steam."
	#${EndIf}
FunctionEnd

Function installwarning
	MessageBox MB_OK "WARNING! Do not install to C:\Program Files or C:\Program Files (x86) folders. SteamConsole won't function poperly. Also make sure that you have Steam installed and that you logged into it at least once on the PC you're installing this on."
FunctionEnd

Function setupfinished
	MessageBox MB_OK "Setup finished! If you download any new ROMS, run the ROM Import shortcut in the start menu to import the new ROMS into Steam."
FunctionEnd

#===========================
#| Initial Install Section |
#===========================
Section # create a section for installing SteamConsole
CreateUninstaller:
	SetOutPath $INSTDIR
	WriteUninstaller "$INSTDIR\SteamConsole_uninstaller.exe" # define uninstaller name
	SetShellVarContext all
	CreateShortCut "$SMPROGRAMS\SteamConsole\Remove SteamConsole.lnk" "$INSTDIR\SteamConsole_uninstaller.exe" # create a shortcut named in the start menu programs directory
	DetailPrint ""
	DetailPrint ""
	DetailPrint ""
SectionEnd

#=====================
#| Uninstall Section |
#=====================
Section "Uninstall" # create a section to define what the uninstaller does.
	MessageBox MB_YESNO "Are you sure you want to uninstall SteamConsole?" IDYES yes IDNO no
yes:
	KillProcDLL::KillProc "Xpadder.exe"
	SetOutPath "$INSTDIR\Scripts"
	ExecDos::exec /NOUNLOAD /TOSTACK "$INSTDIR\Scripts\killprocess.bat" "" ""
	MessageBox MB_YESNO "Would you like to keep your ROMs & Save files? If yes, your ROMs and save files will be moved to a folder on the desktop labeled SteamConsole_BACKUP. If no, your ROMs and save files will be permanently deleted." IDYES yes3 IDNO no3

no:
	Goto end

yes3:
	CopyFiles /SILENT "$INSTDIR\Emulators\ROMS\*.*" "$DESKTOP\SteamConsole_BACKUP\ROMS"
	CopyFiles /SILENT "$INSTDIR\Emulators\RetroArch\SAVEDATA\*.*" "$DESKTOP\SteamConsole_BACKUP\RetroArch\SAVEDATA"
	CopyFiles /SILENT "$INSTDIR\Emulators\Gamecube\Dolphin\User\GC\*.*" "$DESKTOP\SteamConsole_BACKUP\Dolphin\MemoryCards"
	CopyFiles /SILENT "$INSTDIR\Emulators\Gamecube\Dolphin\User\StateSaves\*.*" "$DESKTOP\SteamConsole_BACKUP\Dolphin\SaveStates"
	CopyFiles /SILENT "$INSTDIR\Emulators\PS1\ePSXe\memcards\*.*" "$DESKTOP\SteamConsole_BACKUP\PS1\MemoryCards"
	CopyFiles /SILENT "$INSTDIR\Emulators\PS1\ePSXe\sstates\*.*" "$DESKTOP\SteamConsole_BACKUP\PS1\SaveStates"
	CopyFiles /SILENT "$INSTDIR\Emulators\PS2\pcsx2\memcards\*.*" "$DESKTOP\SteamConsole_BACKUP\PS2\MemoryCards"
	CopyFiles /SILENT "$INSTDIR\Emulators\PS2\pcsx2\sstates\*.*" "$DESKTOP\SteamConsole_BACKUP\PS2\SaveStates"
	RMDir /r "$INSTDIR\Emulators\ROMS"
	RMDir /r "$INSTDIR\Steam_Shortcuts\Arcade"
	SetOutPath "$INSTDIR\Tools\Ice"
	ExecDos::exec /NOUNLOAD /TOSTACK "Ice-Initial-Run.bat" "" ""
	ExecWait '"ice.exe"'
	Delete "config.txt"
	CopyFiles /SILENT /FILESONLY "config_blank.txt" "config.txt"
	Delete "emulators.txt"
	CopyFiles /SILENT /FILESONLY "emulators_blank.txt" "emulators.txt"

	SetOutPath $INSTDIR
	Delete "$INSTDIR\SteamConsole_uninstaller.exe" # Always delete uninstaller first
	SetShellVarContext all
	Delete "$DESKTOP\Steam Launch.lnk"
	Delete "$DESKTOP\ROM Importer.lnk"
	RMDir /r "$INSTDIR" # now delete installed files
	RMDir /r "$SMPROGRAMS\SteamConsole" # remove the link from the start menu
	DeleteRegValue HKLM "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\Tools\Xpadder\Xpadder.exe"
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole"
	DetailPrint ""
	DetailPrint ""
	DetailPrint ""
	DetailPrint "Uninstall Complete"
	Goto end

no3:
	RMDir /r "$INSTDIR\Emulators\ROMS"
	RMDir /r "$INSTDIR\Steam_Shortcuts\Arcade"
	SetOutPath "$INSTDIR\Tools\Ice"
	ExecDos::exec /NOUNLOAD /TOSTACK "Ice-Initial-Run.bat" "" ""
	ExecWait '"ice.exe"'
	Delete "config.txt"
	CopyFiles /SILENT /FILESONLY "config_blank.txt" "config.txt"
	Delete "emulators.txt"
	CopyFiles /SILENT /FILESONLY "emulators_blank.txt" "emulators.txt"

	SetOutPath $INSTDIR
	Delete "$INSTDIR\SteamConsole_uninstaller.exe" # Always delete uninstaller first
	SetShellVarContext all
	Delete "$DESKTOP\Steam Launch.lnk"
	Delete "$DESKTOP\ROM Importer.lnk"
	RMDir /r "$INSTDIR" # now delete installed files
	RMDir /r "$SMPROGRAMS\SteamConsole" # remove the link from the start menu
	DeleteRegValue HKLM "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\Tools\Xpadder\Xpadder.exe"
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole"
	DetailPrint ""
	DetailPrint ""
	DetailPrint ""
	DetailPrint "Uninstall Complete"
	Goto end
 
end:
SectionEnd