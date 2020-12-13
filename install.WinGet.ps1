

mkdir C:\PS\

##=======================================================
##  Download Build and Release File

# Add-AppxPackage "C:\PS\WinGet.appxbundle"Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v0.1.4331-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle" -OutFile "C:\PS\WinGet.appxbundle"

##-------------------
Add-AppxPackage "C:\PS\WinGet.appxbundle"Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v0.2.2941-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle" -OutFile "C:\PS\WinGet.appxbundle"

##=======================================================
##  Install File
Add-AppxPackage "C:\PS\WinGet.appxbundle"

