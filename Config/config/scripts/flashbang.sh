#!/bin/sh

if [ -f "/tmp/flashbang.lock" ]; then
    exit 0
fi

touch "/tmp/flashbang.lock"

pw-play --volume 0.6 ~/afs/.confs/config/scripts/fb1.mp3 &
pqiv "$HOME/afs/.confs/config/scripts/fb.gif" --transparent-background=true --window-title="fbgif" --scale-images-up -i &
sleep 0.1
xprop -name "fbgif" -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_DOCK
sleep 3.4
pkill pqiv

pw-play --volume 0.6 ~/afs/.confs/config/scripts/fb2.mp3 &

xrandr --output DP-1 --brightness 40 > /dev/null 2>&1
xrandr --output HDMI-1 --brightness 40 > /dev/null 2>&1

b=40
while [ "$(echo "$b 1" | awk '{print ($1 > $2)}')" = 1 ]; do
    xrandr --output DP-1 --brightness "$b" > /dev/null 2>&1
    xrandr --output HDMI-1 --brightness "$b" > /dev/null 2>&1
    b=$(echo "$b * 0.99" | bc)
done

xrandr --output DP-1 --brightness 1 > /dev/null 2>&1
xrandr --output HDMI-1 --brightness 1 > /dev/null 2>&1

rm "/tmp/flashbang.lock"

