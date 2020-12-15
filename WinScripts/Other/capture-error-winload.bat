@echo off
:: script to use when capture image capture shows error 0xc000000f (failed to start winload.*) under 2012r2
:: https://gist.github.com/Albirew/ff86c4871b252acf6d7b5c298283859c
echo    ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo    º Bypass error 0xc000000f on capture.wim (failed to start winload.*) º
echo    ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍŒ
echo.
if [%1]==[] goto noarg
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

mkdir %~d1\mountmp
dism /mount-wim /wimfile:%1 /mountdir:%~d1\mountmp /Index:1
timeout 3
dism /unmount-wim /mountdir:%~d1\mountmp /commit
rmdir %~d1\mountmp
echo OK!
exit

:noarg
echo Usage: drop on this .bat file the capture.wim file to fix.
echo Or use the command line: %~nx0 X:\path\to\capture.wim
echo Default is C:\RemoteInstall\Boot\x64\Images\
pause
exit