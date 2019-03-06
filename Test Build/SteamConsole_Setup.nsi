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
#!include "zipdll.nsh"

!macro ShellExecWait verb app param workdir show exitoutvar ;only app and show must be != "", every thing else is optional
#define SEE_MASK_NOCLOSEPROCESS 0x40
System::Store S
System::Call '*(&i60)i.r0'
System::Call '*$0(i 60,i 0x40,i $hwndparent,t "${verb}",t $\'${app}$\',t $\'${param}$\',t "${workdir}",i ${show})i.r0'
System::Call 'shell32::ShellExecuteEx(ir0)i.r1 ?e'
${If} $1 <> 0
	System::Call '*$0(is,i,i,i,i,i,i,i,i,i,i,i,i,i,i.r1)' ;stack value not really used, just a fancy pop ;)
	System::Call 'kernel32::WaitForSingleObject(ir1,i-1)'
	System::Call 'kernel32::GetExitCodeProcess(ir1,*i.s)'
	System::Call 'kernel32::CloseHandle(ir1)'
${EndIf}
System::Free $0
!if "${exitoutvar}" == ""
	pop $0
!endif
System::Store L
!if "${exitoutvar}" != ""
	pop ${exitoutvar}
!endif
!macroend

Insttype "/CUSTOMSTRING=Custom"
Insttype "/COMPONENTSONLYONCUSTOM"
Insttype "Standard Installation"
#Insttype "Dualshock Installation"

!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\win-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\win-uninstall.ico"
!define VERSION "v1.6.1"

Name "SteamConsole" # The name of the installer
OutFile "SteamConsole_Setup.exe" # The file to write
InstallDir "C:\SteamConsole" # The default installation directory
DirText "Choose a folder to install SteamConsole to." # The text to prompt the user to enter a directory
ComponentText "Please choose components to install. If this is your first time running the setup, make sure prerequisites is checked."
RequestExecutionLevel admin
ShowInstDetails show

!insertmacro MUI_PAGE_LICENSE "License.rtf"
!insertmacro MUI_PAGE_README "Changelog.rtf"
!insertmacro MUI_LANGUAGE "English"

Page custom installwarning
Page directory
Page components
Page instfiles
Page custom setupfinished

Section "Core Files (Required)"
  SectionIn RO
    # Required files here
	#KillProcDLL::KillProc "Xpadder.exe"
	#ExecDos::exec /NOUNLOAD /TOSTACK "$INSTDIR\Scripts\killprocess.bat" "" ""
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
		#WriteRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\Tools\Xpadder\Xpadder.exe" "~ RUNASADMIN WIN7RTM"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "DisplayIcon" "$INSTDIR\Images\SteamConsole.ico"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "DisplayName" "SteamConsole (64-Bit)"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "DisplayVersion" "1.6.1"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "InstallLocation" "$INSTDIR"
		WriteRegDWORD HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "NoModify" "0x00000001"
		WriteRegDWORD HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "NoRepair" "0x00000001"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "UninstallString" "$INSTDIR\SteamConsole_uninstaller.exe"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "Version" "1.6.1"
		WriteRegStr HKLM "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole" "Updater" "1.5.5"
		SetOutPath $INSTDIR\Scripts
		#ExecDos::exec /NOUNLOAD /ASYNC /TOSTACK "$INSTDIR\Scripts\open_xpadder.bat" "" ""
		#ExecDos::exec /NOUNLOAD /ASYNC /TOSTACK "$INSTIR\Tools\Xpadder\Xpadder.exe"
	#MessageBox MB_OK '"Core Files Installation Complete!"'
	SetOutPath $INSTDIR\Scripts
	#ExecDos::exec /NOUNLOAD /TOSTACK "$INSTDIR\Scripts\close_xpadder.bat" "" ""
	#ExecDos::exec /NOUNLOAD /TOSTACK TASKKILL /im "Xpadder.exe"
	#ExecDos::exec /NOUNLOAD /ASYNC "$INSTDIR\Scripts\Download_Emulators.bat" "" ""
	nsExec::ExecToLog '"$INSTDIR\Scripts\Download_Emulators.bat" "" ""'
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
	FileWrite $0 "ECHO off"
	FileWrite $0 "$\r$\n" # go to new line
	FileWrite $0 'cd "%~dp0%"'
	FileWrite $0 "$\r$\n"
	FileWrite $0 "cd .."
	FileWrite $0 "$\r$\n"
	FileWrite $0 'SET "dirpath=%cd%"'
	FileWrite $0 "$\r$\n"
	FileWrite $0 "$\r$\n"
	FileWrite $0 'IF EXIST "%dirpath%\steam_path.txt" DEL "%dirpath%\steam_path.txt" >NUL'
	FileWrite $0 "$\r$\n"
	FileWrite $0 'cscript.exe "%dirpath%\Scripts\steam_path_check.vbs" > "%dirpath%\steam_path.txt"'
	FileWrite $0 "$\r$\n"
	FileWrite $0 "$\r$\n"
	FileWrite $0 ":steampath"
	FileWrite $0 "$\r$\n"
	FileWrite $0 'FOR /f "usebackq delims=" %%i IN ("%dirpath%\steam_path.txt") DO SET "steampath=%%i"'
	FileWrite $0 "$\r$\n"
	FileWrite $0 'DEL "%dirpath%\steam_path.txt" >NUL'
	FileWrite $0 "$\r$\n"
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
	FileWrite $0 "ECHO."
	FileWrite $0 "$\r$\n"
	FileWrite $0 'TASKLIST /FI "IMAGENAME eq Custom Hotkeys.exe" 2>NUL | FIND /I /N "Custom Hotkeys.exe">NUL'
	FileWrite $0 "$\r$\n"
	FileWrite $0 'IF NOT "%ERRORLEVEL%"=="0" START "" "%dirpath%\Tools\Custom Hotkeys.exe"'
	FileWrite $0 "$\r$\n"
	FileWrite $0 'TASKLIST /FI "IMAGENAME eq antimicro.exe" 2>NUL | FIND /I /N "antimicro.exe">NUL'
	FileWrite $0 "$\r$\n"
	FileWrite $0 'IF NOT "%ERRORLEVEL%"=="0" START "" "%dirpath%\Tools\antimicro\antimicro.exe"'
	FileWrite $0 "$\r$\n"
	FileWrite $0 'START "" "%steampath%\Steam.exe" -start steam://open/bigpicture'
	FileWrite $0 "$\r$\n"
	FileWrite $0 "EXIT"
	FileClose $0

	SetOutPath "$INSTDIR\Scripts"
	CreateShortCut "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SteamConsole\Steam Launch.lnk" "$INSTDIR\Scripts\Steam_Open.bat" "" "$INSTDIR\Images\SteamConsole.ico"
	CreateShortCut "$DESKTOP\Steam Launch.lnk" "$INSTDIR\Scripts\Steam_Open.bat" "" "$INSTDIR\Images\SteamConsole.ico"
	SetOutPath "$INSTDIR\Scripts\Updater"
	CreateShortCut "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SteamConsole\Update SteamConsole.lnk" "$INSTDIR\Scripts\Updater\Update-SteamConsole.bat" "" "$INSTDIR\Images\updater.ico"
	CreateShortCut "$DESKTOP\Update SteamConsole.lnk" "$INSTDIR\Scripts\Updater\Update-SteamConsole.bat" "" "$INSTDIR\Images\updater.ico"
	SetOutPath $INSTDIR

SectionEnd

#Section "Import ROMS" SEC_ROMIMPORT
  #SectionIn 1
  # Scan user defined folders for ROM files and move them to ..\SteamConsole\Emulators\ROMS
	# Run Ice to import ROMS into Steam
	#MessageBox MB_OK '"NOTE: Please make sure you move all your ROM files to ..\SteamConsole\Emulators\ROMS\CONSOLE before continuing. Where CONSOLE is the name of the game system the ROM is for (NES, SNES, Genesis, N64, etc.)"'
	#SetOutPath "$INSTDIR\Tools\Ice"
  #!insertmacro ShellExecWait "" '"Ice-Initial-Run.bat"' "" "" ${SW_SHOW} $1
	#ExpandEnvStrings $0 %COMSPEC%
	#nsExec::ExecToLog '"Ice-Initial-Run.bat"'
	#nsExec::ExecToLog '"ice.exe" -s'
	#ExecDos::exec /NOUNLOAD /TOSTACK "Ice-Initial-Run.bat" "" ""
	#ExecWait '"ice.exe"'
	#Delete "config.txt"
	#CopyFiles /SILENT /FILESONLY "config_blank.txt" "config.txt"
	#Delete "emulators.txt"
	#CopyFiles /SILENT /FILESONLY "emulators_blank.txt" "emulators.txt"
	#Delete "consoles.txt"
	#CopyFiles /SILENT /FILESONLY "consoles_blank.txt" "consoles.txt"
#SectionEnd

Section "DS3 & DS4" SEC_DS3
  SectionIn 2
    ExecWait "$INSTDIR\Tools\ScpToolkit\ScpDriverInstaller.exe"
SectionEnd

#Section "DS4 Only" SEC_DS4
  #SectionIn 2
    #ExecWait "$INSTDIR\Tools\DS4Tool-1.2.2\Virtual Bus Driver\ScpDriver.exe"
	#CreateShortCut "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\DS4Tool ScpServer Start.lnk" "$INSTDIR\Tools\DS4Tool-1.2.2\ScpServer.exe" "" "$INSTDIR\Tools\DS4Tool-1.2.2\ScpServer.exe"
		#FileOpen $0 "$INSTDIR\Scripts\Steam_Open.bat" w
	#FileWrite $0 "echo off"
	#FileWrite $0 "$\r$\n" # go to new line
	#FileWrite $0 "cd .."
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "set dirpath=%cd%"
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 'if exist "%dirpath%\steam_path.txt" del "%dirpath%\steam_path.txt"'
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 '  taskkill /f /im "Custom Hotkeys.exe"'
	#FileWrite $0 "$\r$\n"
    #FileWrite $0 '  cscript.exe "%dirpath%\Scripts\steam_path_check.vbs" > "%dirpath%\steam_path.txt"'
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 ":steampath"
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 'for /F "usebackq delims=" %%i in ("%dirpath%\steam_path.txt") do set "steampath=%%i"'
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 'del "%dirpath%\steam_path.txt"'
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 '"%dirpath%\Tools\Xpadder\Xpadder.exe" /C'
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "cls"
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "ECHO."
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "ECHO."
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "ECHO          **       ****    *****   ***     ****  **    **    *****"
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "ECHO          **      **  **  **   **  ** **    **   ***   **   **   **"
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "ECHO          **      **  **  *******  **  **   **   ** *  **  **"
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "ECHO          **      **  **  **   **  **  **   **   **  * **  **  ****"
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "ECHO          ******  **  **  **   **  ** **    **   **   ***   **   **"
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "ECHO          ******   ****   **   **  ***     ****  **    **    *****"
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "ECHO."
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "ECHO."
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "ECHO."
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "echo."
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 'start "" "%dirpath%\Tools\DS4Tool-1.2.2\ScpServer.exe"'
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 'start "" "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"'
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 'start "" "%dirpath%\Tools\Xpadder\Xpadder.exe" /M "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile" "%dirpath%\Tools\Xpadder\Controller-Profiles\Steam_Xbox360.xpadderprofile"'
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 'start "" "%steampath%\Steam.exe" -start steam://open/bigpicture'
	#FileWrite $0 "$\r$\n"
	#FileWrite $0 "exit"
	#FileClose $0
#SectionEnd

Function .onInit
  StrCpy $1 ${SEC_PREREQS}
  StrCpy $1 ${SEC_STARTMENU}
  #StrCpy $1 ${SEC_ROMIMPORT}
  StrCpy $1 ${SEC_DS3}
  #StrCpy $1 ${SEC_DS4}
FunctionEnd

LangString DESC_Section1 ${LANG_ENGLISH} "DirectX, MSVC 2013 x86, MSVC 2013 x64, Xpadder."
LangString DESC_Section2 ${LANG_ENGLISH} "Create program shortcuts in the start menu and on the desktop."
#LangString DESC_Section3 ${LANG_ENGLISH} "Import ROMS in the subfolders found in the Emulators folder within the root SteamConsole folder."
LangString DESC_Section4 ${LANG_ENGLISH} "Dualshock 3 & Dualshock 4 controller support (ScpToolkit)."
#LangString DESC_Section5 ${LANG_ENGLISH} "Dualshock 4 controller support only (DS4Tool)."

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_PREREQS} $(DESC_Section1)
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_STARTMENU} $(DESC_Section2)
  #!insertmacro MUI_DESCRIPTION_TEXT ${SEC_ROMIMPORT} $(DESC_Section3)
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_DS3} $(DESC_Section3)
  #!insertmacro MUI_DESCRIPTION_TEXT ${SEC_DS4} $(DESC_Section5)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Function .onSelChange
	#${If} ${SectionIsSelected} ${SEC_DS3}
		#${If} ${SectionIsSelected} ${SEC_DS4}
			#MessageBox MB_OK "WARNING: Do not select both Dualshock options, only one"
			#!insertmacro UnSelectSection ${SEC_DS3}
			#!insertmacro UnSelectSection ${SEC_DS4}
		#${EndIf}
	#${EndIf}
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
	MessageBox MB_OK 'Setup finished! Add ROMS to "..\SteamConsole\Emulators\ROMS\.." and Run the ROM Import shortcut in the start menu/desktop to import the ROMS into Steam. Note that everytime you run the ROM Import shortcut, it will delete all your steam custom shortcuts not added with SteamConsole. This is due to a bug in the ICE program used to import ROMS to steam.'
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
SectionEnd

#=====================
#| Uninstall Section |
#=====================
Section "Uninstall" # create a section to define what the uninstaller does.
	MessageBox MB_YESNO "Are you sure you want to uninstall SteamConsole?" IDYES yes IDNO no
yes:
	KillProcDLL::KillProc "antimicro.exe"
	KillProcDLL::KillProc "Custom Hotkeys.exe"
	MessageBox MB_YESNO "Would you like to keep your ROMs & Save files? If yes, your ROMs and save files will be moved to a folder in ..\SteamConsole\Emulators labeled BACKUP. If no, your ROMs and save files will be permanently deleted." IDYES yes3 IDNO no3

no:
	Goto end

yes3:
	CopyFiles /SILENT "$INSTDIR\Emulators\RetroArch\SAVEDATA\*.*" "$INSTDIR\Emulators\BACKUP\RetroArch\SAVEDATA"
	CopyFiles /SILENT "$INSTDIR\Emulators\Gamecube\Dolphin\User\GC\*.*" "$INSTDIR\Emulators\BACKUP\Dolphin\MemoryCards"
	CopyFiles /SILENT "$INSTDIR\Emulators\Gamecube\Dolphin\User\StateSaves\*.*" "$INSTDIR\Emulators\BACKUP\Dolphin\SaveStates"
	CopyFiles /SILENT "$INSTDIR\Emulators\PS2\pcsx2\memcards\*.*" "$INSTDIR\Emulators\BACKUP\PS2\MemoryCards"
	CopyFiles /SILENT "$INSTDIR\Emulators\PS2\pcsx2\sstates\*.*" "$INSTDIR\Emulators\BACKUP\PS2\SaveStates"
	RMDir /r "$INSTDIR\Emulators\ROMS\Apps"
	RMDir /r "$INSTDIR\Emulators\ROMS\Launchers"
	RMDir /r "$INSTDIR\Emulators\ROMS\PC_Games"
	RMDir /r "$INSTDIR\Emulators\Gamecube"
	RMDir /r "$INSTDIR\Emulators\PS2"
	RMDir /r "$INSTDIR\Emulators\RetroArch"
	MessageBox MB_YESNO "Would you like to remove the ScpToolkit (DS3/DS4 Tool) completely from your system?" IDYES yes4 IDNO no4
	
yes4:
	ExecWait "$INSTDIR\Tools\ScpToolkit\ScpCleanWipe.exe"
	Goto no4

no4:
	SetOutPath $INSTDIR
	Delete "$INSTDIR\SteamConsole_uninstaller.exe" # Always delete uninstaller first
	SetShellVarContext all
	Delete "$INSTDIR\SteamConsole Settings-Alpha_v0.4.exe"
	Delete "$INSTDIR\Changelog.rtf"
	Delete "$INSTDIR\License.rtf"
	Delete "$INSTDIR\README.txt"
	Delete "$INSTDIR\debug.log"
	Delete "$INSTDIR\Steam Launch.lnk"
	Delete "$DESKTOP\Steam Launch.lnk"
	Delete "$DESKTOP\ROM Importer.lnk"
	Delete "$DESKTOP\Update SteamConsole.lnk"
	RMDir /r "$INSTDIR\Config"
	RMDir /r "$INSTDIR\Images"
	RMDir /r "$INSTDIR\Installs"
	RMDir /r "$INSTDIR\Scripts"
	RMDir /r "$INSTDIR\Tools"
	RMDir /r "$INSTDIR\Voice Control"
	RMDir /r "$SMPROGRAMS\SteamConsole" # remove the link from the start menu
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole"
	DetailPrint ""
	DetailPrint ""
	DetailPrint ""
	DetailPrint "Uninstall Complete"
	Goto end

no3:
	RMDir /r "$INSTDIR\Emulators\ROMS"
	MessageBox MB_YESNO "Would you like to remove the ScpToolkit (DS3/DS4 Tool) completely from your system?" IDYES yes5 IDNO no5
	
yes5:
	ExecWait "$INSTDIR\Tools\ScpToolkit\ScpCleanWipe.exe"
	Goto no5
	
no5:
	SetOutPath $INSTDIR
	Delete "$INSTDIR\SteamConsole_uninstaller.exe" # Always delete uninstaller first
	SetShellVarContext all
	Delete "$INSTDIR\Changelog.rtf"
	Delete "$INSTDIR\License.rtf"
	Delete "$INSTDIR\README.txt"
	Delete "$INSTDIR\Steam Launch.lnk"
	Delete "$DESKTOP\Steam Launch.lnk"
	Delete "$DESKTOP\ROM Importer.lnk"
	Delete "$DESKTOP\Update SteamConsole.lnk"
	RMDir /r "$INSTDIR" # now delete installed files
	RMDir /r "$SMPROGRAMS\SteamConsole" # remove the link from the start menu
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SteamConsole"
	DetailPrint ""
	DetailPrint ""
	DetailPrint ""
	DetailPrint "Uninstall Complete"
	Goto end

end:
SectionEnd
