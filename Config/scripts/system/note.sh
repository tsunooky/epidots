#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"
LOCK_FILE="${XDG_RUNTIME_DIR:-/tmp}/note.lock"
NOTE_FILE="$AFS/.note.txt"

if [ -f "$LOCK_FILE" ] && kill -0 "$(cat "$LOCK_FILE" 2>/dev/null)" 2>/dev/null; then
    exit 0
fi

[ -f "$NOTE_FILE.swp" ] && rm -f "$NOTE_FILE.swp"
echo "$PPID" > "$LOCK_FILE"
vim "$NOTE_FILE" +startinsert
rm -f "$LOCK_FILE"
