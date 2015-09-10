@echo off
if exist ePSXe.bak (goto backup
)else goto patch
goto :EOF

:backup
move /y ePSXe.bak ePSXe.exe > nul
ren %0 patch.cmd
goto :EOF

:patch
copy /y ePSXe.exe ePSXe.bak > nul
upx -d ePSXe.exe > nul
shark_patcher.exe
if ERRORLEVEL 1 goto backup
ren %0 unpatch.cmd