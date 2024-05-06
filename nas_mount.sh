#!/bin/bash


if [ ! -f ~/.config/kdesurc ];then
  touch ~/.config/kdesurc
  echo "[super-user-command]" > ~/.config/kdesurc
  echo "super-user-command=sudo" >> ~/.config/kdesurc
fi

while IFS=, read -r source destination; do
    if [ ! -d "$destination" ]; then
      echo "Creating mounting directory $destination"
      mkdir "$destination"
    fi

    if (! mount | grep -qs "$destination"); then
      echo "Mounting $source to $destination"
      mount -t smb3 "$source" "$destination" -o credentials=/home/deck/Documents/credentials/share,uid=1000,gid=1000,iocharset=utf8,mapposix,actimeo=6,echo_interval=1,nostrictsync,cache=loose,nocase,soft,vers=3.1.1
    fi
done < mount.conf
