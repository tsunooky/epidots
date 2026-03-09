#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

PRESENCE_FILE="$CONFS/.check_presence_url"
theme="$CONFIG/rofi/epita_menu.rasi"
host="  Epita Hub"

check_pres='  Check Presence'
moodle='  Moodle'
intranet='  Intranet'
news='  Epita News'
set_check='  Set Check Presence'

rofi_cmd() {
    rofi -dmenu -dpi 1 \
        -p "$host" \
        -theme ${theme}
}

ask_url_cmd() {
    rofi -theme-str 'listview {lines: 0;}' \
         -theme-str 'inputbar {children: [ "prompt", "entry" ]; background-color: @on-primary;}' \
         -theme-str 'prompt {background-color: @selected; text-color: @background; padding: 8px 15px; border-radius: 20px;}' \
         -theme-str 'entry {background-color: inherit; text-color: @selected; placeholder-color: @selected; padding: 8px 15px;}' \
         -dmenu \
         -p ' Link' \
         -theme ${theme} \
         -dpi 1
}

run_rofi() {
    echo -e "$check_pres\n$moodle\n$intranet\n$news\n$set_check" | rofi_cmd
}

chosen="$(run_rofi)"
case ${chosen} in
    $check_pres)
        if [ -f "$PRESENCE_FILE" ]; then
            url=$(cat "$PRESENCE_FILE")
            if [ -n "$url" ]; then
                firefox "$url" &
            else
                notify-send "Error" "The link is empty. Please use 'Set Check Presence'."
            fi
        else
            notify-send "Error" "No link found. Please use 'Set Check Presence' first."
        fi
        ;;
    $moodle)
        firefox "https://moodle.epita.fr/" &
        ;;
    $intranet)
        firefox "https://intra.forge.epita.fr/" &
        ;;
    $news)
        firefox "https://news.epita.fr/" &
        ;;
    $set_check)
        new_url=$(ask_url_cmd)
        if [ -n "$new_url" ]; then
            echo "$new_url" > "$PRESENCE_FILE"
            notify-send "Epita Hub" "Presence link successfully saved!"
        fi
        ;;
esac
