#!/bin/sh

if [ -z "$1" ]; then
  echo "Usage: bg <path_to_wallpaper>"
  exit 1
fi
if [ ! -f "$1" ]; then
  echo "Error: File not found: $1."
  exit 1
fi

echo "$(basename "$1")" > ~/afs/.confs/.bg

matugen image "$1"
feh --bg-fill "$1"
cp ~/.fehbg ~/afs/.confs/

if [ -f ~/afs/.confs/install.sh ]; then
    ~/afs/.confs/install.sh
fi
