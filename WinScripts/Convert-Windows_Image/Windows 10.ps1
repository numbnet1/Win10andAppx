
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

Get-NetFirewallRule -Name "{61e3f01d-eb10-411e-96b5-7d27b58016c8}" | Remove-NetFirewallRule

New-NetFirewallRule -DisplayName "Search" -Name "{61e3f01d-eb10-411e-96b5-7d27b58016c8}" `
	-Direction Outbound -Action Block -Profile "Domain, Private, Public" `
	-Program "C:\Windows\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy\SearchUI.exe"

Get-ScheduledTask -TaskPath "\Microsoft\Windows\Customer Experience Improvement Program\" | Disable-ScheduledTask

