#!/bin/sh

if pgrep -x "redshift" > /dev/null; then
    dunstify -u critical \
             -h string:x-dunst-stack-tag:brightness \
             "Action Blocked" \
             "Please disable Redshift to change brightness." \
             -t 3000
    exit 1
fi

OUTPUT=$(xrandr --query | grep " connected" | cut -d ' ' -f1 | head -n 1)

send_notif() {
    local current=$(xrandr --verbose --query | grep -A 5 "$OUTPUT" | grep "Brightness" | cut -d ' ' -f2)
    
    local percent=$(echo "$current * 100" | bc | cut -d '.' -f1)

    dunstify -h string:x-dunst-stack-tag:brightness \
             "Luminosité : $percent%" \
             -t 1500 -a "System"
}

STEP=0.05

case "$1" in
    up)
        curr=$(xrandr --verbose --query | grep -A 5 "$OUTPUT" | grep "Brightness" | cut -d ' ' -f2)
        new=$(echo "$curr + $STEP" | bc)
        xrandr --output "$OUTPUT" --brightness "$new"
        send_notif
        ;;
    down)
        curr=$(xrandr --verbose --query | grep -A 5 "$OUTPUT" | grep "Brightness" | cut -d ' ' -f2)
        new=$(echo "$curr - $STEP" | bc)
        # On évite de descendre à 0 (écran noir complet)
        if (( $(echo "$new > 0.1" | bc -l) )); then
            xrandr --output "$OUTPUT" --brightness "$new"
            send_notif
        fi
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac
