netsh interface ip set address `"Ethernet`" dhcp
netsh interface ip add dns `"Ethernet`" dhcp
netsh advfirewall firewall add rule name=`"Local Any`" dir=in action=allow profile=any remoteip=any
hostname
ipconfig