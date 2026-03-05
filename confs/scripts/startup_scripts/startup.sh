#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

nohup firefox intra.forge.epita.fr > /dev/null 2>&1 &
nohup alacritty > /dev/null 2>&1 &

IDA=42;
IDB=43;

dunstify -r "$IDA" -t 0 "=== Epidots Startup ==="
dunstify -r "$IDB" -t 0 "Installing additional packages..."

PACKAGES="
nixpkgs#autotiling
nixpkgs#picom
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

nohup nvim --headless "+Lazy! sync" +qa > /dev/null 2>&1 &

mkdir -p "$HOME/.cache/wal"
ln -sf "$CONFS/config/matugen/pywalfox.json" "$HOME/.cache/wal/colors.json"

dunstify -r "$IDB" -t 0 "Configuring Pywalfox..."
if pywalfox install > /dev/null 2>&1; then
    dunstify -r "$IDB" "Configuring Pywalfox [OK]"
else
    dunstify -C "$IDB"
    dunstify -u critical "Configuring Pywalfox [FAIL]"
fi

dunstify -r "$IDB" -t 0 "Restarting i3..."
if i3-msg restart > /dev/null 2>&1; then
    dunstify -r "$IDB" -t 0 "Restarting i3 [OK]"
else
    dunstify -r "$IDB" -t 0 "Restarting i3 [SKIP]"
fi

dunstify -r "$IDB" -t 0 "Re-applying wallpaper theme..."
if sh "$SCRIPTS/wallpaper_scripts/safe_change_wallpaper.sh" > /dev/null 2>&1; then
    dunstify -r "$IDB" -t 0 "Re-applying wallpaper theme [OK]"
else
    dunstify -C "$IDB"
    dunstify -u critical "Re-applying wallpaper theme [FAIL]"
fi

dunstify -r "$IDB" -t 0 "All done!"

LOG_FILE="/tmp/startup_scripts.log"

if [ -d "$SCRIPTS/startup_scripts" ]; then
    for f in "$SCRIPTS/startup_scripts"/*; do
        [ -f "$f" ] || continue
        fname="${f##*/}"
        if [ "$fname" != "startup.sh" ]; then
            chmod +x "$f"
            echo "===== LOG $fname =====" >> "$LOG_FILE"
            dunstify -r "$IDB" -t 0 "Execution startup script : $fname"
            if ! "$f" >> "$LOG_FILE" 2>&1; then
                dunstify -C "$IDB"
                dunstify -u critical "Error executing : $fname" "See log in $LOG_FILE"
            fi
        fi
    done
fi

dunstify -C "$IDA"
dunstify -C "$IDB"
