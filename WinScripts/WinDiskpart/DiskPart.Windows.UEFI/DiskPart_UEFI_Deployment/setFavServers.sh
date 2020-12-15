#!/bin/bash
servers=("smb://server/share"
"smb://anotherserver/anothershare")

###### SCRIPT #######
# Run as the user via ARD
for i in "${!servers[@]}"
do
  sfltool add-item -n "${servers[$i]}" com.apple.LSSharedFileList.FavoriteServers "${servers[$i]}"
done
