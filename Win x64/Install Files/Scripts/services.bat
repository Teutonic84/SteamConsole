echo off
cls

::cd ..
set dirpath=%1

sc create Xpadder binpath= "%dirpath%\Tools\Xpadder\Xpadder.exe"
::sc create "Custom Hotkeys" binpath= "%dirpath%\Tools\Xpadder\Custom Hotkeys.exe"

sc config Xpadder start= auto
::sc config "Custom Hotkeys start= auto

:end
exit