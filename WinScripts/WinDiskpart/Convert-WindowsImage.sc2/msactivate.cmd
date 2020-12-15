@echo off
mode con cols=90 lines=70
chcp 437 >nul
openfiles >nul 2>&1
if %errorlevel% NEQ 0 goto :UACPrompt
goto :gotAdmin
:UACPrompt
Echo CreateObject^("Shell.Application"^).ShellExecute WScript.Arguments^(0^),"%*","","runas",1 >"%temp%\elevating.vbs"
%systemroot%\system32\cscript.exe //nologo "%temp%\elevating.vbs" "%~dpnx0"
del /f /q "%temp%\elevating.vbs" >nul 2>&1
exit /b

:gotAdmin
set spp=SoftwareLicensingProduct
for /f "tokens=2 delims==" %%G in ('"wmic path %spp% where (PartialProductKey !=NULL) get ID /format:list"') do (set app=%%G&call :chk)
goto :end

echo +
echo   FIX FOR IASTATE KMS DNS ISSUES
echo ____________________________________________________________________________
echo +
:chk
set /a _win=0
wmic path %spp% where ID='%app%' get Name /format:list | findstr /i "Windows" 1>nul && set /a _win=1
if %_win% equ 1 (
echo.
echo ************************************************************
echo ***                   Windows Activate                   ***
echo ************************************************************
cscript //nologo %systemroot%\System32\slmgr.vbs /skms kms.iastate.edu
cscript //nologo %systemroot%\System32\slmgr.vbs /ato
exit /b
)
echo ************************************************************
echo ***                   Office Activate                    ***
echo ************************************************************
cscript.exe //nologo %systemroot%\system32\slmgr.vbs /skms kms.iastate.edu %app%
cscript.exe //nologo %systemroot%\system32\slmgr.vbs /ato %app%
exit /b

:end
echo ____________________________________________________________________________
echo+
echo Press any key...
pause >nul