#!/bin/sh

WallDir=${1:-~/afs/.confs/wallpapers/}

PREVIEW=true \
rofi -no-config -theme ~/afs/.confs/config/rofi/bg_chooser.rasi \
    -show filebrowser -filebrowser-command ~/afs/.confs/config/scripts/change_wallpaper.sh \
    -filebrowser-directory "$WallDir" \
    -filebrowser-sorting-method name \
    -selected-row 1 >/dev/null \
    -dpi 1 \
