#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"
LOCK_FILE="/tmp/note.lock"
NOTE_FILE="$AFS/.note.txt"

if [ ! -f "$LOCK_FILE" ] || ! (kill -s 0 $(cat "$LOCK_FILE"));  then
    rm "$NOTE_FILE.swp"
    touch "$LOCK_FILE"
    echo "$PPID" > "$LOCK_FILE"
    vim "$NOTE_FILE" +startinsert
    rm "$LOCK_FILE"
fi

