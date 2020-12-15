@echo off
setlocal
set v=Unimplemented version of Windows...
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set v=%%j.%%k) else (set v=%%i.%%j))
if "%v%" == "10.0" set v=Windows10
if "%v%" == "6.3" set v=Windows8.1
if "%v%" == "6.2" set v=Windows8
if "%v%" == "6.1" set v=Windows7
echo %v%...
echo.
echo %v% >> %~dp0\%v%.txt
For /f "tokens=2 delims=," %%a in ('wmic path SoftwareLicensingService get OA3xOriginalProductKey^,VLRenewalInterval /value /format:csv') do set key=%%a
if NOT [%key%]==[] (
  echo %key% >> %~dp0\%v%.txt 
  ) else (
  echo.
  echo ERROR: BATCH EXPORT NOT SUPPORTED >> %~dp0\%v%.txt
  color 0c
  echo ERROR: BATCH EXPORT NOT SUPPORTED
  )
echo -------------------------------------------------------- >> %~dp0\%v%.txt
echo. >> %~dp0\%v%.txt
timeout 5
endlocal