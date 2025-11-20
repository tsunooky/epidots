#!/bin/sh

BASE_DIR="~/afs/.confs/wallpapers"

RANDOM_IMAGE=$(find "$BASE_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | shuf -n 1)

~/afs/.confs/Config/scripts/change_wallpaper.sh "$RANDOM_IMAGE"
