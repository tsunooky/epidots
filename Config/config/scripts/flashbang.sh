#!/bin/sh

xrandr --output DP-1 --brightness 10 > /dev/null 2>&1
xrandr --output HDMI-1 --brightness 10 > /dev/null 2>&1

sleep 0.1

xrandr --output DP-1 --brightness 1 > /dev/null 2>&1
xrandr --output HDMI-1 --brightness 1 > /dev/null 2>&1
