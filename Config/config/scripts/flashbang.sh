#!/bin/sh

if [-f /tmp/flashbang.lock ]
    exit 0

touch /tmp/flashbang.lock

xrandr --output DP-1 --brightness 30 > /dev/null 2>&1
xrandr --output HDMI-1 --brightness 30 > /dev/null 2>&1

b=30
while [ "$(echo "$b 1" | awk '{print ($1 > $2)}')" = 1 ]; do
    xrandr --output DP-1 --brightness "$b" > /dev/null 2>&1
    xrandr --output HDMI-1 --brightness "$b" > /dev/null 2>&1
    b=$(echo "$b * 0.99" | bc)
done

xrandr --output DP-1 --brightness 1 > /dev/null 2>&1
xrandr --output HDMI-1 --brightness 1 > /dev/null 2>&1

rm /tmp/flashbang
