#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

if [ -n "$1" ]; then
    TARGET_WALL="$1"
else
    DEFAULT_WALL="$WALLPAPERS/default.jpg"
    if [ -f "$CONFS/.bg" ]; then
        IMG_NAME=$(cat "$CONFS/.bg")
        if [ -n "$IMG_NAME" ] && [ -f "$WALLPAPERS/$IMG_NAME" ]; then
            TARGET_WALL="$WALLPAPERS/$IMG_NAME"
        fi
    fi
    [ -z "$TARGET_WALL" ] && TARGET_WALL="$DEFAULT_WALL"
fi

if [ -f "$TARGET_WALL" ]; then
    if command -v matugen >/dev/null 2>&1; then
        matugen image "$TARGET_WALL" > /dev/null 2>&1
    fi

    if command -v feh >/dev/null 2>&1; then
        feh --bg-fill "$TARGET_WALL"
        [ -f "$HOME/.fehbg" ] && cp "$HOME/.fehbg" "$CONFS/"
    fi
fi
