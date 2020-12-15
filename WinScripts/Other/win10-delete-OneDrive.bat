@echo off
:: OneDrive removal tool for windows 10
:: edited version of: http://wayback.archive.org/web/20150811115546/http://secondclock.net/?p=28
echo.
echo          ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo          º  OneDrive remover  º
echo          ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
pause
color 0e
set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"

echo Closing OneDrive process.
echo.
taskkill /f /im OneDrive.exe > NUL 2>&1
timeout 5

echo Uninstalling OneDrive.
echo.
if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
timeout 5

echo Removing OneDrive leftovers.
echo.
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "%SYSTEMDRIVE%\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 

echo Removing OneDrive from the Explorer Side Panel.
echo.
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f

color 0a
echo You must restart your computer to finish OneDrive uninstallation, have a nice day.
pause