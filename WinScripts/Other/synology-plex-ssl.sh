openssl pkcs12 -export -name "plex" -passout pass:"plex" \
-out "/volume1/homes/plex/plex.pfx" \
-in "/usr/syno/etc/certificate/system/default/cert.pem" \
-inkey "/usr/syno/etc/certificate/system/default/privkey.pem" \
-certfile "/usr/syno/etc/certificate/system/default/chain.pem"
synopkg restart "Plex Media Server"