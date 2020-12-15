# Load (aka "dot-source) the Function 
. .\Convert-WindowsImage.ps1 
# Prepare all the variables in advance (optional) 
$ConvertWindowsImageParam = @{  
    SourcePath          = ".\nanoserver.wim"  
    Edition             = "CORESYSTEMSERVER_INSTALL"
    Package = @(  
        #Drivers for hosting Nano Server as a virtual machine
        ".\Packages\Microsoft-NanoServer-Guest-Package.cab"
        ".\Packages\en-us\Microsoft-NanoServer-Guest-Package.cab"
        #Basic drivers for a variety of network adapters and storage controllers
        ".\Packages\Microsoft-NanoServer-OEM-Drivers-Package.cab"
        ".\Packages\en-us\Microsoft-NanoServer-OEM-Drivers-Package.cab"
        #running software micro .net
        ".\Packages\Microsoft-OneCore-ReverseForwarders-Package.cab"
        ".\Packages\en-us\Microsoft-OneCore-ReverseForwarders-Package.cab"  
        #Hyper-V role
        ".\Packages\Microsoft-NanoServer-Compute-Package.cab"
        ".\Packages\en-us\Microsoft-NanoServer-Compute-Package.cab"
        #Failover Clustering
        ".\Packages\Microsoft-NanoServer-FailoverCluster-Package.cab"
        ".\Packages\en-us\Microsoft-NanoServer-FailoverCluster-Package.cab"
        #File Server role and other storage components
        ".\Packages\Microsoft-NanoServer-Storage-Package.cab"
        ".\Packages\en-us\Microsoft-NanoServer-Storage-Package.cab"
    )
	#this will copies the unattend file before anything else I want it closer to the end.
    #Unattend             = ".\Unattend.xml"
}
$ConvertWindowsImageGPT = @{
    VHDPath             = ".\nanoserver.vhdx"
    VHDFormat           = "VHDx"
    VHDPartitionStyle   = "GPT"
}
#switch for legacy output
$ConvertWindowsImageMBR = @{
    VHDPath             = ".\nanoserver.vhd"
    VHDFormat           = "VHD"
    VHDPartitionStyle   = "MBR"
    BCDinVHD            = "NativeBoot"
    ExpandOnNativeBoot  = $false
}
# Produce the images 
Convert-WindowsImage @ConvertWindowsImageParam @ConvertWindowsImageGPT #-verbose

#why isnt this in convert-image?
Remove-Item .\mountdir -recurse
md mountdir
. dism /Mount-Image /ImageFile:.\NanoServer.vhdx /Index:1 /MountDir:.\mountdir
. dism /image:.\mountdir /Apply-Unattend:.\unattend.xml  /norestart
md .\mountdir\windows\panther
copy .\unattend.xml .\mountdir\windows\panther
md .\mountdir\Windows\Setup\Scripts
copy .\SetupComplete.cmd .\mountdir\Windows\Setup\Scripts
. dism /Unmount-Image /MountDir:.\mountdir /Commit
. dism /cleanup-mountpoints