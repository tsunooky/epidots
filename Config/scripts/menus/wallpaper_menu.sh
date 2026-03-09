#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

PREVIEW=true \
rofi -no-config -theme $CONFIG/rofi/wallpaper_chooser.rasi \
    -show filebrowser -filebrowser-command $SCRIPTS/wallpaper_scripts/change_wallpaper.sh \
    -filebrowser-directory "$WALLPAPERS" \
    -filebrowser-sorting-method name \
    -selected-row 1 >/dev/null \
    -dpi 1 \
