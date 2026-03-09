#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

if [ -z "$1" ]; then
    exit 1
fi
if [ ! -f "$1" ]; then
    exit 1
fi

REL_PATH="${1#$WALLPAPERS/}"
echo "$REL_PATH" > "$CONFS/.bg"

matugen image "$1" > /dev/null 2>&1
feh --bg-fill "$1"

cp "$HOME/.fehbg" "$CONFS/"

if [ -x "$CONFS/install.sh" ]; then
    "$CONFS/install.sh" > /dev/null 2>&1
fi
