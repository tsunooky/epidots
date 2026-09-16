#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

LOCK_FILE="${XDG_RUNTIME_DIR:-/tmp}/flashbang.lock"

if [ -f "$LOCK_FILE" ]; then
    exit 0
fi

touch "$LOCK_FILE"

#pw-play --volume 0.0 ~/afs/.confs/config/scripts/fb1.mp3 &
pqiv "$SCRIPTS/flashbang/fb.gif" --transparent-background=true --window-title="fbgif" --scale-images-up -i &
sleep 3.6
pkill pqiv

#pw-play --volume 0.0 ~/afs/.confs/config/scripts/fb2.mp3 &

OUTPUTS=$(xrandr --query 2>/dev/null | grep " connected" | cut -d ' ' -f1)

set_brightness() {
    for output in $OUTPUTS; do
        xrandr --output "$output" --brightness "$1" > /dev/null 2>&1
    done
}

set_brightness 40

b=40
while [ "$(echo "$b 1" | awk '{print ($1 > $2)}')" = 1 ]; do
    set_brightness "$b"
    b=$(echo "$b * 0.99" | bc)
done

set_brightness 1

rm "$LOCK_FILE"

