@echo off
:: https://gist.github.com/Albirew/613cbf63595647ff26b269d5271871a0
:: added rev.18 of Matt's privilege escalation script: http://stackoverflow.com/posts/12264592/revisions

:: UAC privilege escalation
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )
:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
echo.
echo Invoking UAC for Privilege Escalation
setlocal DisableDelayedExpansion
set "batchPath=%~0"
setlocal EnableDelayedExpansion
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
echo args = "ELEV " >> "%temp%\OEgetPrivileges.vbs"
echo For Each strArg in WScript.Arguments >> "%temp%\OEgetPrivileges.vbs"
echo args = args ^& strArg ^& " "  >> "%temp%\OEgetPrivileges.vbs"
echo Next >> "%temp%\OEgetPrivileges.vbs"
echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%SystemRoot%\System32\WScript.exe" "%temp%\OEgetPrivileges.vbs" %*
exit /B
:gotPrivileges
if '%1'=='ELEV' shift /1
setlocal & pushd .
cd /d %~dp0
:: /UAC privilege escalation

echo    ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo    º SMBv1 patch against malwares like WannaCry ou notPetya / Petwrap º
echo    ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
:: deactivate SMBv1 on SMB server
reg add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v SMB1 /t REG_DWORD /d 0 /f
:: deactivate SMBv1 on SMB client
sc config lanmanworkstation depend= bowser/mrxsmb20/nsi
sc config mrxsmb10 start= disabled
:: If you have any connectivity problem with your NAS after this, 
:: please uncomment the following two lines, restart this batch file and reboot your computer
::sc config lanmanworkstation depend= bowser/mrxsmb10/mrxsmb20/nsi
::sc config mrxsmb10 start= auto
echo.
echo Done. Please check above lines if no error occured.
pause
