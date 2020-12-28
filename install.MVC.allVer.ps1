## ================================================================ ##
## === ins NetBeans






####====================================================
#### Downloading Apache NetBeans 12.0
#Invoke-WebRequest -Uri "https://www2.apache.paket.ua/netbeans/netbeans/12.0/Apache-NetBeans-12.0-bin-windows-x64.exe" -OutFile "$env:SYSTEMDRIVE\PS\Apache-NetBeans-12.0-bin-windows-x64.exe"
# . "$env:SYSTEMDRIVE\PS\Apache-NetBeans-12.0-bin-windows-x64.exe"







if ((Get-WmiObject win32_operatingsystem | select osarchitecture).osarchitecture -like "64*")
{
Write "Windows x64";		# for Windows x64
####====================================================
		echo "START Install for Win x64"

		echo "Microsoft Visual C++ 2005 Service Pack 1 Redistributable Package MFC Security Update (x64) Ver.: 8.0.61000"
winget install "Microsoft.VC++2005Redist-x64" --force
		echo "Microsoft Visual C++ 2008 Service Pack 1 Redistributable Package MFC Security Update (x64) Ver.: 9.0.30729.6161"
winget install "Microsoft.VC++2008Redist-x64" --force
		echo "Microsoft Visual C++ 2010 Service Pack 1 Redistributable Package MFC Security Update (x64) Ver.: 10.0.40219.325"
winget install "Microsoft.VC++2010Redist-x64" --force
		echo "Microsoft Visual C++ Redistributable for Visual Studio 2012 Update 4 (x64) Ver.: 11.0.61030"
#winget install "Microsoft.VC++2012Redist-x64" --force
		echo "Microsoft Visual C++ 2013 Update 5 Redistributable Package (x64) Ver.: 12.0.40664"
#winget install "Microsoft.VC++2013Redist-x64" --force
#		echo "Microsoft Visual C++ 2015-2019 Redistributable (x64) Ver.: 14.28.29325.2"
###  winget install "Microsoft.VC++2015-2019Redist-x64" --force
#		echo "Microsoft Visual C++ 2015 Redistributable (x64) Ver.: 14.0.24215.1"
###  winget install "Microsoft.VC++2015Redist-x64" --force
#		echo "Microsoft Visual C++ 2017 Redistributable (x64) Ver.: 14.16.27027.1"
###  winget install "Microsoft.VC++2017Redist-x64" --force

		echo "TEST END"

} else
{
Write "Windows x86";		# for Windows x86
####====================================================
		echo "START Install for Win x86"

		echo "Microsoft Visual C++ 2005 Service Pack 1 Redistributable Package MFC Security Update (x86)  Ver.: 8.0.61001"
#winget install "Microsoft.VC++2005Redist-x86" --force
		echo "Microsoft Visual C++ 2008 Service Pack 1 Redistributable Package MFC Security Update (x86)  Ver.: 9.0.30729.6161"
#winget install "Microsoft.VC++2008Redist-x86" --force
		echo "Microsoft Visual C++ 2010 Service Pack 1 Redistributable Package MFC Security Update (x86)  Ver.: 10.0.40219.325"
#winget install "Microsoft.VC++2010Redist-x86" --force
		echo "Microsoft Visual C++ Redistributable for Visual Studio 2012 Update 4 (x86)  Ver.: 11.0.61030"
#winget install "Microsoft.VC++2012Redist-x86" --force
		echo "Microsoft Visual C++ 2013 Update 5 Redistributable Package (x86)  Ver.: 12.0.40664"
#winget install "Microsoft.VC++2013Redist-x86" --force
		echo "Microsoft Visual C++ 2015-2019 Redistributable (x86)  Ver.: 14.28.29325.2"
#winget install "Microsoft.VC++2015-2019Redist-x86" --force
#		echo "Microsoft Visual C++ 2015 Redistributable (x86)  Ver.: 14.0.24215.1"
#winget install "Microsoft.VC++2015Redist-x86" --force
#		echo "Microsoft Visual C++ 2017 Redistributable (x86)  Ver.: 14.16.27027.1"
#winget install "Microsoft.VC++2017Redist-x86" --force

		echo "TEST END"
}


####====================================================
####====================================================
#### Downloading Visual Studio 2019 v16.8.30804.86 & install
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/v16.8.30804.86/vs_community__360051548.1609162113.exe" -OutFile "$env:SYSTEMDRIVE\PS\vs_community.exe"
. "$env:SYSTEMDRIVE\PS\vs_community.exe"

####====================================================
#### Downloading Java SE Development Kit 15 & install
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/15.0.1/jdk-15.0.1_windows-x64_bin.exe.zip" -OutFile "$env:SYSTEMDRIVE\PS\jdk-15.0.1_windows-x64_bin.exe.zip";
Expand-Archive -Path "$env:SYSTEMDRIVE\PS\jdk-15.0.1_windows-x64_bin.exe.zip" -DestinationPath "$env:SYSTEMDRIVE\PS";
 . "$env:SYSTEMDRIVE\PS\jdk-15.0.1_windows-x64_bin.exe"

####====================================================
#### Downloading Apache NetBeans 12.0
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/v12.0/Apache-NetBeans-12.0-bin-windows-x64.exe.zip" -OutFile "$env:SYSTEMDRIVE\PS\Apache-NetBeans-12.0-bin-windows-x64.exe.zip";
Expand-Archive -Path "$env:SYSTEMDRIVE\PS\Apache-NetBeans-12.0-bin-windows-x64.exe.zip" -DestinationPath "$env:SYSTEMDRIVE\PS";
 . "$env:SYSTEMDRIVE\PS\Apache-NetBeans-12.0-bin-windows-x64.exe"
