
sc delete DiagTrack
sc delete dmwappushservice

sc config diagnosticshub.standardcollector.service start= disabled
sc config WMPNetworkSvc start= disabled

sc config AdobeARMservice start= disabled
schtasks /Change /DISABLE /TN "Adobe Acrobat Update Task"

sc config "Razer Game Scanner Service" start= disabled

REM this makes dropbox do UAC prompts multiple times a day
sc config dbupdate start= disabled
sc config dbupdatem start= disabled
schtasks /Change /DISABLE /TN "DropboxUpdateTaskMachineCore
schtasks /Change /DISABLE /TN "DropboxUpdateTaskMachineUA"

sc config gupdate start= disabled
sc config gupdatem start= disabled
schtasks /Change /DISABLE /TN "GoogleUpdateTaskMachineCore"
schtasks /Change /DISABLE /TN "GoogleUpdateTaskMachineUA"

echo "" > C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v NoPreviousVersionsPage /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f
