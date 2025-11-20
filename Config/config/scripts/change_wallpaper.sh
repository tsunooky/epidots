#!/bin/sh

if [ -z "$1" ]; then
  echo "Usage: bg <path_to_wallpaper>"
  exit 1
fi
if [ ! -f "$1" ]; then
  echo "Error: File not found: $1."
  exit 1
fi

#matugen "$1"
feh --bg-fill "$1"
cp ~/.fehbg ~/afs/.confs/
#.~/afs/.confs/install.sh

