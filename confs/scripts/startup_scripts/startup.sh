#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

nohup firefox intra.forge.epita.fr > /dev/null 2>&1 &
nohup alacritty > /dev/null 2>&1 &

printf "${BLUE}=== Epidots Startup ===${NC}\n"

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

printf "${BLUE}::${NC} Configuring Pywalfox...                 "
if pywalfox install > /dev/null 2>&1; then
    printf "${GREEN}[OK]${NC}\n"
else
    printf "[SKIP]\n"
fi

printf "${BLUE}::${NC} Restarting i3...                        "
if i3-msg restart > /dev/null 2>&1; then
    printf "${GREEN}[OK]${NC}\n"
else
    printf "[SKIP]\n"
fi

printf "${BLUE}::${NC} Re-applying wallpaper theme...          "
if sh "$SCRIPTS/wallpaper_scripts/safe_change_wallpaper.sh" > /dev/null 2>&1; then
    printf "${GREEN}[OK]${NC}\n"
else
    printf "${RED}[FAIL]${NC}\n"
fi

printf "${GREEN}All done!${NC}\n"


printf "${GRAY}Closing installer...${NC}\n"

if [ -d "$SCRIPTS/startup_scripts" ]; then
    for f in "$SCRIPTS/startup_scripts"/*; do
        [ -f "$f" ] || continue
        fname="${f##*/}"
        if [ "$fname" != "startup.sh" ]; then
            chmod +x "$f"
            "$f"
        fi
    done
fi

sleep 0.1
kill -9 $PPID
