#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

if [ -z "$1" ]; then
  echo "Usage: bg <path_to_wallpaper>"
  exit 1
fi
if [ ! -f "$1" ]; then
  echo "Error: File not found: $1."
  exit 1
fi

echo "$(basename "$1")" > $CONFS/.bg

i3 workspace 42 > /dev/null 2>&1
sleep 0.05
matugen image "$1" > /dev/null 2>&1
feh --bg-fill "$1"

cp "$HOME/.fehbg" "$CONFS"
"$CONFS/install.sh"

sleep 0.3
i3 workspace back_and_forth > /dev/null 2>&1

