<#
    Correct the default UEFI partition layout created by ConfigMgr to save some disk space.

    https://docs.microsoft.com/de-de/windows-hardware/manufacture/desktop/configure-uefigpt-based-hard-drive-partitions

    ## Notes:

    * The recovery partition size for Windows 10 1703 needs to  be at least 900 MB or the partition will ignored.
    * Windows 10 1511 Winre.wim size: 313.009.179 Bytes
    * Windows 10 1607 Winre.wim size: 324.995.101 Bytes
    * Windows 10 1703 Winre.wim size: 497.695.264 Bytes
    * Windows 10 1709 Winre.wim size: 374.062.331 Bytes

    ## Variables:

    * Make sure the sizes in the 'Format and Partition' Task Sequence Step match the sizes in this script. They will be used
    to calculate the maximum size for the Windows Partition.
    
    * The recovery partition size is an exception to that, leave the default dynamic partitioning in the Task Sequence.

    * The $windows_partition_label variable is used to copy the logfile to the windows partition for later inspection, the default
    label for the windows partition is 'Windows'.

    ## Boot image requirements:

    * WinPE-EnhancedStorage
    * WinPE-PowerShell

    https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpe-add-packages--optional-components-reference
#>

try
{
    ## Start Logging:
    Start-Transcript -Path "$env:SystemDrive\CorrectRecoveryPartitionSize.log" -Append

    ## Disk Variables:
    $msr = 16
    $uefi = 500
    $recovery = 900
    $windows_partition_label = "OSDisk"

    ## Diskpart Variables:
    $diskpart_count = 1
    $diskpart_retries = 3
    $diskpart_wait_timeout = 15 # Seconds

    ## Script Start:

    ## Guess the disk to operate on from DiskPath, assuming the system has only one disk with a "System" aka EFI partition:
    $disk = Get-Disk -Path ((Get-Partition | Where-Object { $_.Type -eq "System" }).DiskPath)

    ## Write Info to console:
    Write-Host "Disk model:" $disk.Model
    Write-Host "Disk size:" $disk.Size
    Write-Host "Disk SN:" $disk.SerialNumber

    ## Calculate partition sizes:
    [uint64]$size_msr = $msr * 1024 * 1024
    [uint64]$size_uefi = $uefi * 1024 * 1024
    [uint64]$size_recovery = $recovery * 1024 * 1024
    [uint64]$size_windows = $disk.size - ($size_msr + $size_uefi + $size_recovery)

    ## Remove recovery partition:
    $p_recovery = Get-Partition -DiskNumber $disk.DiskNumber | Where-Object { $_.Type -eq "Recovery" }
    Remove-Partition -DiskNumber $p_recovery.DiskNumber -PartitionNumber $p_recovery.PartitionNumber -Confirm:$false

    ## Get Windows partition:
    $p_windows = Get-Partition -DiskNumber $disk.DiskNumber | Where-Object { $_.Type -eq "Basic" }
    Write-Host "Old Windows partition size:" $p_windows.Size
    Write-Host "New Windows partition size: $size_windows"

    ## Calculate saved space:
    $space_saved = ((($size_windows - $p_windows.Size) / 1024) / 1024)
    Write-Host "Saved: $space_saved MB through repartitioning."
    
    ## Resize Windows partition:
    Resize-Partition -DiskNumber $p_windows.DiskNumber -PartitionNumber $p_windows.PartitionNumber -Size $size_windows

    ## Create diskpart script:
    $diskpart_script = @()
    $diskpart_script += "select disk " + $disk.Number
    $diskpart_script += "create partition primary"
    $diskpart_script += 'format quick fs=ntfs label="Recovery"'
    $diskpart_script += 'set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac"'
    $diskpart_script += "gpt attributes=0x8000000000000001"

    ## Export diskpart script:
    $diskpart_script | Out-File -FilePath "$env:SystemDrive\RecoveryPartition.txt" -Encoding utf8

    <#
		Diskpart is used because I found no way to set the gpt attribute 0x8000000000000001 with
		New-Partition / Set-Partition.
	
        Diskpart sometimes errors out with "-2147023174" "RPC Server not available" according to cmtrace error lookup.
        I suspect this to be some kind of timing issue since it happens very rarely, so the given workaround is to run the
        the diskpart script multiple times.

        Anyway, i recommend adding the default partitioning step after this powershell script and filter the step with:

        TS Variable: "_SMSTSLastActionSucceeded"
        Condition: is equal to "false"

        This will ensure a successful OSD should the correction fail all re-runs, something I have not encountered so far.
    #>

    do
    {
        Write-Host "Waiting $diskpart_wait_timeout seconds before creating Partition, attempt: $diskpart_count"
        Start-Sleep $diskpart_wait_timeout
        $diskpart = Start-Process -FilePath "$env:systemroot\system32\diskpart.exe" -ArgumentList "/s $env:SystemDrive\RecoveryPartition.txt" -PassThru -Wait
        Write-Host "Diskpart exited with exitcode:" $diskpart.ExitCode
        $diskpart_count++
    }
    until (($diskpart.ExitCode -eq 0) -or ($diskpart_count -gt $diskpart_retries))
}

catch
{
    Write-Error $_.Exception.Message
}

finally
{
    Stop-Transcript

    ## Copy transcript to Windows partition:
    Copy-Item -Path "$env:SystemDrive\CorrectRecoveryPartitionSize.log" -Destination ((Get-Volume -FileSystemLabel $windows_partition_label).DriveLetter + ":" + "\" + "CorrectRecoveryPartitionSize.log")
}