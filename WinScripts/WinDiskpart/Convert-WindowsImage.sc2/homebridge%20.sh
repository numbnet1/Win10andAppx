apt-get install libavahi-compat-libdnssd-dev curl build-essential avahi-utils
update-rc.d avahi-daemon disable
cat >/etc/avahi/services/web.service <<EOL
<?xml version="1.0" standalone='no'?><!--*-nxml-*-->
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
<name replace-wildcards="yes">%h HTTP</name>
<service>
<type>_http._tcp</type>
<port>80</port>
</service>
</service-group>
EOL
cat >/etc/avahi/services/hap.service <<EOL
<?xml version="1.0" standalone='no'?><!--*-nxml-*-->
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
<name replace-wildcards="yes">%h HAP</name>
<service>
<type>_hap._tcp</type>
<port>51826</port>
</service>
</service-group>
EOL

curl -sL https://deb.nodesource.com/setup_13.x | bash -
apt-get install -y nodejs
npm install -g --unsafe-perm homebridge 
npm install -g --unsafe-perm homebridge-config-ui-x

cat >/etc/default/homebridge <<EOL
# Defaults / Configuration options for homebridge
# The following settings tells homebridge where to find the config.json file and where to persist the data (i.e. pairing and others)
HOMEBRIDGE_OPTS=-U /var/homebridge
# If you uncomment the following line, homebridge will log more 
# You can display this via systemd's journalctl: journalctl -f -u homebridge
# DEBUG=*
EOL

cat >/etc/systemd/system/homebridge.service <<EOL
[Unit]
Description=Node.js HomeKit Server 
After=syslog.target network-online.target
[Service]
Type=simple
User=root
EnvironmentFile=/etc/default/homebridge
ExecStart=/usr/bin/homebridge $HOMEBRIDGE_OPTS
Restart=on-failure
RestartSec=10

KillMode=process
[Install]
WantedBy=multi-user.target
EOL

mkdir /var/homebridge
cp -r ~/.homebridge/persist /var/homebridge
cat >/var/homebridge/config.json <<EOL
{
    "mdns": {
        "interface": "192.168.1.121"
    },
    "bridge": {
        "name": "Homebridge",
        "username": "11:22:33:44:55:66",
        "port": 51826,
        "pin": "111-22-333"
    },
    "accessories": [],
    "platforms": [
        {
            "name": "Config",
            "port": 80,
            "sudo": false,
            "auth": "none",
            "theme": "auto",
            "tempUnits": "c",
            "restart": "systemctl restart homebridge",
            "log": {
                "method": "systemd"
            },
            "platform": "config"
        }
    ]
}
EOL
systemctl daemon-reload
systemctl enable homebridge
systemctl start homebridge
systemctl status homebridge
journalctl -f -u homebridge
avahi-browse-domains -a