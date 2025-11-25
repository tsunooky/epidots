#!/bin/sh

if [ -z "$1" ]; then
  echo "Usage: bg <path_to_wallpaper>"
  return 1
fi
if [ ! -f "$1" ]; then
  echo "Error: File not found: $1."
  return 1
fi

i3 workspace 11 > /dev/null
sleep 0.2
matugen image "$1"
feh --bg-fill "$1"
sleep 0.6
i3 workspace back_and_forth > /dev/null
