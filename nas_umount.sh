#!/bin/bash

if [ ! -f ~/.config/kdesurc ];then
  touch ~/.config/kdesurc
  echo "[super-user-command]" > ~/.config/kdesurc
  echo "super-user-command=sudo" >> ~/.config/kdesurc
fi

while IFS=, read -r source destination; do
    if (mount | grep -qs "$destination"); then
      echo "Unmounting $source from $destination"
      umount "$destination"
    fi

    if [ -z "$(ls -A $destination)" ]; then
      echo "Removing mounting directory $destination"
      rmdir "$destination"
    fi
done < mount.conf
