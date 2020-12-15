@ECHO Creating Diskpart scripting file
ECHO CREATE VDISK FILE=%~f1 MAXIMUM=%2 TYPE=%3 >> diskpart.txt
ECHO SELECT VDISK FILE=%~f1 >> diskpart.txt
ECHO ATTACH VDISK >> diskpart.txt
ECHO CREATE PARTITION PRIMARY >> diskpart.txt
ECHO ASSIGN LETTER=%4 >> diskpart.txt
ECHO FORMAT QUICK FS=NTFS LABEL=VHD >> diskpart.txt
diskpart /s diskpart.txt
powershell $p = Get-ExecutionPolicy;Set-ExecutionPolicy ByPass -Force;.\Install-WindowsImage.ps1 -WIM %5 -Apply -Index 1 -Destination %4:;Set-ExecutionPolicy $p -Force
BCDBOOT.EXE  %4:\Windows
del diskpart.txt
