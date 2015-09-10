echo off
cls

if exist "C:\Program Files (x86)" (
    taskkill /T /IM "Custom Hotkeys.exe"
    goto end
)
taskkill /T /IM "Custom Hotkeys x86.exe"

:end
exit