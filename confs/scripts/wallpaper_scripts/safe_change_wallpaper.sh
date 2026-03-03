#!/bin/sh

source "$HOME/afs/.confs/epidots/globals.sh"

DEFAULT_WALL="$WALLPAPERS/default.jpg"
TARGET_WALL=""

if [ -f "$CONFS/.bg" ]; then
    IMG_NAME=$(cat "$CONFS/.bg")
    if [ -n "$IMG_NAME" ] && [ -f "$WALLPAPERS/$IMG_NAME" ]; then
        TARGET_WALL="$WALLPAPERS/$IMG_NAME"
    fi
fi

if [ -z "$TARGET_WALL" ]; then
    TARGET_WALL="$DEFAULT_WALL"
    if [ -f "$TARGET_WALL" ]; then
        echo "default.jpg" > "$CONFS/.bg"
    else
        exit 1
    fi
fi

if command -v matugen >/dev/null 2>&1; then
    matugen image "$TARGET_WALL" > /dev/null 2>&1
fi

if command -v feh >/dev/null 2>&1; then
    feh --bg-fill "$TARGET_WALL"
    if [ -f "$HOME/.fehbg" ]; then
        cp "$HOME/.fehbg" "$CONFS/"
    fi
fi

if [ -x "$CONFS/install.sh" ]; then
    "$CONFS/install.sh" > /dev/null 2>&1
fi
