@echo off
title disable telemetry
color 0a
sc delete DiagTrack
sc delete dmwappushservice
echo "" > C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLoggerDiagtrack‐Listener.etl
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
pause >nul 2>nul