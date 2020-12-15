apt update --allow-releaseinfo-change
apt-get install curl build-essential
curl -sL https://deb.nodesource.com/setup_13.x | bash -
apt-get install -y nodejs
npm install -g --unsafe-perm node-red
npm rebuild
npm install -g --unsafe-perm node-red-admin
npm rebuild


cat >/etc/default/nodered <<EOL
# Defaults / Configuration options for Node Red
NODE_RED_OPTIONS=-p 80 -v
#  -p, --port     PORT  port to listen on
#  -s, --settings FILE  use specified settings file
#      --title    TITLE process window title
#  -u, --userDir  DIR   use specified user directory
#  -v, --verbose        enable verbose output
#      --safe           enable safe mode
EOL

cat >/etc/systemd/system/nodered.service <<EOL
[Unit]
Description=Node-RED graphical event wiring tool
After=syslog.target network-online.target
[Service]
Type=simple
User=root
EnvironmentFile=/etc/default/nodered
ExecStart=/usr/bin/node-red $NODE_RED_OPTIONS
KillMode=process
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOL

systemctl daemon-reload
systemctl enable nodered
systemctl start nodered
systemctl status nodered
journalctl -f -u nodered
