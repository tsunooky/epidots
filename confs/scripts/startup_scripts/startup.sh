#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

nohup firefox intra.forge.epita.fr > /dev/null 2>&1 &
nohup alacritty > /dev/null 2>&1 &

dunstify "=== Epidots Startup ==="
dunstify -r 42 "Installing additional packages..."

PACKAGES="
nixpkgs#autotiling
nixpkgs#picom
nixpkgs#pywal
nixpkgs#pywalfox-native
nixpkgs#papirus-icon-theme
nixpkgs#bat
nixpkgs#adw-gtk3
nixpkgs#pqiv
nixpkgs#neovim
nixpkgs#clang-tools
nixpkgs#nodePackages.bash-language-server
nixpkgs#shfmt
nixpkgs#cmake-language-server
nixpkgs#cmake-format
nixpkgs#tree-sitter
nixpkgs#ripgrep
nixpkgs#flameshot
"

nix profile install $PACKAGES --impure > /dev/null 2>&1


dunstify -r 42 "Configuring Pywalfox..."
if pywalfox install > /dev/null 2>&1; then
    dunstify -r 42 "Configuring Pywalfox [OK]"
else
    dunstify -u critical "Configuring Pywalfox [FAIL]"
fi

dunstify -r 42  "Restarting i3..."
if i3-msg restart > /dev/null 2>&1; then
    dunstify -r 42 "Restarting i3 [OK]"
else
    dunstify -r 42 "Restarting i3 [SKIP]"
fi

dunstify -r 42 "Re-applying wallpaper theme..."
if sh "$SCRIPTS/wallpaper_scripts/safe_change_wallpaper.sh" > /dev/null 2>&1; then
    dunstify -r 42 "Re-applying wallpaper theme [OK]"
else
    dunstify -u critical "Re-applying wallpaper theme [FAIL]"
fi

dunstify -r 42 "All done!"


LOG_FILE="/tmp/startup_scripts.log"

if [ -d "$SCRIPTS/startup_scripts" ]; then
    for f in "$SCRIPTS/startup_scripts"/*; do
        [ -f "$f" ] || continue
        fname="${f##*/}"
        if [ "$fname" != "startup.sh" ]; then
            chmod +x "$f"
            echo "===== LOG $fname =====" >> $LOG_FILE
            dunstify -r 42 "Execution startup script : $fname"
            if ! "$f" >> $LOG_FILE 2<&1; then
                dunstify -u critical "Error executing : $fname" "See log in $LOG_FILE"
            fi
        fi
    done
fi

sleep 0.1
kill -9 $PPID
