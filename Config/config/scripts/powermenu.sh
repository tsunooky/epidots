#!/bin/sh

# Current Theme
theme="$HOME/.config/rofi/powermenu.rasi"

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"
host=" $USER"

# Options
shutdown='  Shutdown'
reboot='  Reboot'
lock='  Lock'
logout='  Logout'
yes='  Yes'
no='  No'

# Rofi CMD
rofi_cmd() {
    rofi -dmenu -dpi 1 \
        -p "$host" \
        -theme-str "textbox-uptime { str: \"$uptime\"; }" \
        -theme ${theme}
}

# Confirmation CMD
confirm_cmd() {
    rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 400px;}' \
        -theme-str 'mainbox {children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you Sure?' \
        -theme ${theme} \
        -dpi 1
}

# Ask for confirmation
confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        if [[ $1 == '--shutdown' ]]; then
            systemctl poweroff
        elif [[ $1 == '--reboot' ]]; then
            systemctl reboot
        elif [[ $1 == '--logout' ]]; then
            i3-msg exit
        fi
    else
        exit 0
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $lock)
        i3lock
        ;;
    $logout)
        run_cmd --logout
        ;;
esac

