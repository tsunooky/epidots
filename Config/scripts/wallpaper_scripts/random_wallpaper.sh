#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

RANDOM_IMAGE=$(find "$WALLPAPERS" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | shuf -n 1)

"$SCRIPTS/wallpaper_scripts/change_wallpaper.sh" "$RANDOM_IMAGE"
