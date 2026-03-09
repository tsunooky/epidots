#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

nohup firefox intra.forge.epita.fr > /dev/null 2>&1 &
nohup alacritty > /dev/null 2>&1 &

IDA=42
IDB=43

dunstify -r "$IDA" -t 0 "=== Epidots Startup ==="

if [ -f "$SCRIPTS/wallpaper_scripts/safe_change_wallpaper.sh" ]; then
    sh "$SCRIPTS/wallpaper_scripts/safe_change_wallpaper.sh" > /dev/null 2>&1
fi

if [ ! -x "$HOME/.nix-profile/bin/bat" ]; then
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
fi

if [ ! -d "$HOME/.local/share/nvim/lazy" ]; then
    nohup nvim --headless "+Lazy! sync" +qa > /dev/null 2>&1 &
fi

if [ -f "$CONFS/config/matugen/pywalfox.json" ]; then
    mkdir -p "$HOME/.cache/wal"
    ln -sf "$CONFS/config/matugen/pywalfox.json" "$HOME/.cache/wal/colors.json"

    dunstify -r "$IDB" -t 0 "Configuring Pywalfox..."
    if command -v pywalfox > /dev/null 2>&1 && pywalfox install > /dev/null 2>&1; then
        dunstify -r "$IDB" "Configuring Pywalfox [OK]"
    else
        dunstify -C "$IDB"
        dunstify -u critical "Configuring Pywalfox [FAIL]"
    fi
fi

dunstify -r "$IDB" -t 0 "Reloading i3..."
if i3-msg reload > /dev/null 2>&1; then
    dunstify -r "$IDB" -t 0 "Reloading i3 [OK]"
else
    dunstify -r "$IDB" -t 0 "Reloading i3 [SKIP]"
fi

dunstify -r "$IDB" -t 0 "All done!"

LOG_FILE="/tmp/startup_scripts.log"
echo "===== STARTUP LOG =====" > "$LOG_FILE"

if [ -d "$SCRIPTS/startup_scripts" ]; then
    for f in "$SCRIPTS/startup_scripts"/*; do
        [ -f "$f" ] || continue
        fname="${f##*/}"
        
        if [ "$fname" != "startup.sh" ] && [ "$fname" != "aklogger.sh" ] && [ "$fname" != "check_update.sh" ]; then
            chmod +x "$f"
            echo "===== LOG $fname =====" >> "$LOG_FILE"
            dunstify -r "$IDB" -t 0 "Execution startup script : $fname"
            if ! "$f" >> "$LOG_FILE" 2>&1; then
                dunstify -C "$IDB"
                dunstify -u critical "Error executing : $fname" "See log in $LOG_FILE"
            fi
        fi
    done
    
    [ -f "$SCRIPTS/startup_scripts/aklogger.sh" ] && sh "$SCRIPTS/startup_scripts/aklogger.sh" > /dev/null 2>&1 &
    [ -f "$SCRIPTS/startup_scripts/check_update.sh" ] && sh "$SCRIPTS/startup_scripts/check_update.sh" > /dev/null 2>&1 &
fi

dunstify -C "$IDB"
dunstify -C "$IDA"
