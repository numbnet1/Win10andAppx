##=== Install WinGet, OpenSSH Win10===


##  Start as Administrator
param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
	if ($elevated) 
	{
		# tried to elevate, did not work, aborting
	}
	else {
		Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
	}
	exit
}

##  Add New Directory
New-Item -Path "$env:SYSTEMDRIVE\" -Name "PS\OpenSSH" -ItemType Directory -force;

##====================================================
### ОПРЕДЕЛЯЕМ АРХИТЕКТУРУ os Download OpenSSH x64 or x86

If([IntPtr]::Size -eq 4)
{
    Write-Host "Windows x86";   # OpenSSH  --x32
	echo "##--------v8.1.0.0p1-Beta------------"
	Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/v8.1.0.0p1-Beta/OpenSSH-Win32.zip" -OutFile "$env:SYSTEMDRIVE\PS\OpenSSH\OpenSSH-Win32.zip"

	##=====================================
	echo "===============Unzip the files==================="
	Expand-Archive -Path $env:SYSTEMDRIVE\PS\OpenSSH\OpenSSH-Win32.Zip -DestinationPath $env:ProgramFiles\OpenSSH\;

	##================= ≠≠≠ =================
	echo "===============Copy \OpenSSH\OpenSSH-Win32\  \OpenSSH ==============="
	copy $env:ProgramFiles\OpenSSH\OpenSSH-Win32\* $env:ProgramFiles\OpenSSH;


}
Else
{
    Write-Host "Windows x64";  ##---------v8.1.0.0p1-Beta-----------
	Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/v8.1.0.0p1-Beta/OpenSSH-Win64.zip" -OutFile "$env:SYSTEMDRIVE\PS\OpenSSH\OpenSSH-Win64.zip"


	##=====================================
	echo "===============Unzip the files==========="
	Expand-Archive -Path "$env:SYSTEMDRIVE\PS\OpenSSH\OpenSSH-Win64.Zip" -DestinationPath "$env:ProgramFiles\OpenSSH\";

	##================= ≠≠≠ =================
	echo "===============Copy \OpenSSH\OpenSSH-Win64\  \OpenSSH============="
	copy $env:ProgramFiles\OpenSSH\OpenSSH-Win64\* $env:ProgramFiles\OpenSSH;

}



##================= ≠≠≠ =================
echo "===============Install service==============="
. "$env:ProgramFiles\OpenSSH\install-sshd.ps1";

##================= ≠≠≠ =================
echo "===============Set firewall permissions============"
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22;

##================= ≠≠≠ =================
echo "===============Set service startup END"
Set-Service sshd -StartupType Automatic | Start-Service sshd;

##================= ≠≠≠ =================
echo "===============Set Authentication to public key"
((Get-Content -path $env:ProgramData\ssh\sshd_config -Raw) ` -replace '#PubkeyAuthentication yes','PubkeyAuthentication yes' ` -replace '#PasswordAuthentication yes','PasswordAuthentication yes' ` -replace 'Match Group administrators','#Match Group administrators' ` -replace 'AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys','#AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys') | Set-Content -Path $env:ProgramData\ssh\sshd_config;

##================= ≠≠≠ =================
echo "===============Restart after changes"
Restart-Service sshd;

##================= ≠≠≠ =================
echo "===============force file creation
New-item -Path $env:USERPROFILE -Name .ssh -ItemType Directory -force;

##================= ≠≠≠ =================
echo "##		 Gen SSH-KEY:"
# ssh-keygen -t ed25519 -C "$env:USERNAME" -f $env:USERPROFILE\.ssh\$env:COMPUTERNAME.$(Get-Random).ed25519.key
ssh-keygen -t ed25519 -C "$env:USERNAME" -f "$env:USERPROFILE\.ssh\$env:COMPUTERNAME.$env:USERNAME.ed25519.key";

##================= ≠≠≠ =================
##		 Copy SSH-KEY V1:
# echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKp3bxeApwQec9N6DaIP1Iq3o7Ks4jcL66wHi1YdqkFC root" | Out-File $env:USERPROFILE\.ssh\authorized_keys -Encoding ascii;
echo "===============Copy SSH-KEY V2:"
cat $env:USERPROFILE\.ssh\*$env:COMPUTERNAME.$env:USERNAME.ed25519.key.pub | Out-File $env:USERPROFILE\.ssh\authorized_keys -Encoding ascii;

##================= ≠≠≠ =================
echo "===============Cleaning Dir"
Remove-Item -Path $env:SYSTEMDRIVE\PS\OpenSSH -Recurse;
If([IntPtr]::Size -eq 4)
{
  Write-Host "Windows x86";
  Remove-Item -Path $env:ProgramFiles\OpenSSH\OpenSSH-Win32 -Recurse;
}
Else
{
  Write-Host "Windows x64";
  Remove-Item -Path $env:ProgramFiles\OpenSSH\OpenSSH-Win64 -Recurse;
}

##================= ≠≠≠ =================
exit



##================= ≠≠≠ =================
##================= INFO =================
##  Variant 1
# if ((Get-WmiObject win32_operatingsystem | select osarchitecture).osarchitecture -like "64*")
# {Write "Windows x64";}
# else
# {Write "Windows x86";}

##================= ≠≠≠ =================
##  Variant 2
# If([IntPtr]::Size -eq 4)
# { Write-Host "32 bit"; }
# Else
# { Write-Host "64 bit"; }
