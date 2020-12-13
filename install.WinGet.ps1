

mkdir C:\PS\

##=======================================================
##  Download Build and Release File

# Add-AppxPackage "C:\PS\WinGet.appxbundle"Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v0.1.4331-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle" -OutFile "C:\PS\WinGet.appxbundle"

##-------------------
Add-AppxPackage "C:\PS\WinGet.appxbundle"Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v0.2.2941-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle" -OutFile "C:\PS\WinGet.appxbundle"

##=======================================================
##  Install File
Add-AppxPackage "C:\PS\WinGet.appxbundle"

winget install Microsoft.VisualStudioCode --force
winget install "Microsoft.WindowsTerminal" --silent
winget install "Xampp" --silent
winget install "CodeLite.CodeLite" --silent
winget install "OpenJS.NodeJS" --silent
 winget install "Nodist.Nodist" --silent
 winget install "NuGet" --silent
winget install "NuGetPackageExplorer.NuGetPackageExplorer" --silent
winget search 'Microsoft.VC++'
 winget install "Microsoft.PowerShell" --silent
winget install "Microsoft.PowerShell-Preview" --silent



Find-Module Posh-SSH | Install-Module
Import-Module Posh-SSH
Install-Module -Name Posh-SSH
iex (New-Object Net.WebClient).DownloadString("https://gist.github.com/darkoperator/6152630/raw/c67de4f7cd780ba367cccbc2593f38d18ce6df89/instposhsshdev")




echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA1kDD0kTWp0+m17hUY+FnDHE0YKdWJXCAuo4oiYyHsv zusyurec@gmail.com" | Out-File $env:USERPROFILE\.ssh\authorized_keys -Encoding ascii;