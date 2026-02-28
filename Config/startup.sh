#!/bin/sh

# Fix Epita emacs config
for F in ~/afs/.confs/emacs ~/.emacs; do
    [ -f "$F" ] && sed -i 's/(global-linum-mode)/(global-display-line-numbers-mode)/g' "$F"
done

~/afs/.confs/config/scripts/rand_game.sh

GREEN='\033[0;32m'
BLUE='\033[0;34m'
GRAY='\033[0;90m'
NC='\033[0m'

echo -e "${BLUE}=== Epidots Startup ===${NC}"

PACKAGES=(
    "nixpkgs#lsd"
    "nixpkgs#starship"
    "nixpkgs#nerd-fonts.jetbrains-mono"
    "nixpkgs#rofi"
    "nixpkgs#pywal"
    "nixpkgs#pywalfox-native"
    "nixpkgs#picom"
    "nixpkgs#polybar"
    "nixpkgs#autotiling"
    "nixpkgs#papirus-icon-theme"
    "nixpkgs#bat"
    "nixpkgs#matugen"
    "nixpkgs#adw-gtk3"
    "nixpkgs#zsh"
    "nixpkgs#zsh-autosuggestions"
    "nixpkgs#zsh-syntax-highlighting"
    "nixpkgs#pqiv"
)

echo -ne "${BLUE}::${NC} Installing ${#PACKAGES[@]} packages...  "

nix profile install "${PACKAGES[@]}" --impure > /tmp/epidots_install.log 2>&1 &
PID=$!

sp="/-\|"
i=0
while kill -0 $PID 2>/dev/null; do
    printf "\b${sp:i++%${#sp}:1}"
    sleep 0.1
done

wait $PID
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo -e "\b${GREEN}[DONE]${NC}"
else
    echo -e "\b\033[0;31m[FAIL]${NC}"
    echo -e "${GRAY}An error occurred. Check /tmp/epidots_install.log for details.${NC}"
fi

printf "${BLUE}::${NC} Configuring Pywalfox...                 "
pywalfox install > /dev/null 2>&1 && echo -e "${GREEN}[OK]${NC}" || echo -e "[SKIP]"

printf "${BLUE}::${NC} Restarting i3...                        "
i3-msg restart > /dev/null 2>&1 && echo -e "${GREEN}[OK]${NC}" || echo -e "[SKIP]"

BG_FILE=~/afs/.confs/.bg
WALL_DIR=~/afs/.confs/wallpapers
SCRIPT_BG=~/afs/.confs/config/scripts/change_wallpaper.sh

if [ -f "$BG_FILE" ]; then
    IMG_NAME=$(cat "$BG_FILE")
    FULL_PATH="$WALL_DIR/$IMG_NAME"
    if [ -f "$FULL_PATH" ] && [ -f "$SCRIPT_BG" ]; then
        printf "${BLUE}::${NC} Re-applying wallpaper theme...          "
        chmod +x "$SCRIPT_BG"
        "$SCRIPT_BG" "$FULL_PATH" > /dev/null 2>&1 && echo -e "${GREEN}[OK]${NC}" || echo -e "\033[0;31m[FAIL]${NC}"
    fi
fi

echo -e "${GREEN}All done!${NC}"

nohup firefox intra.forge.epita.fr > /dev/null 2>&1 & disown
nohup alacritty > /dev/null 2>&1 & disown

echo -e "${GRAY}Closing installer...${NC}"
for f in ~/afs/.confs/config/scripts/startup_scripts/* ; do
    chmod +x "$f"
    echo "Executed script: $f"
    $f
done

# ~/afs/.confs/config/scripts/aklog.sh > /dev/null 2>&1 & disown

kill emacs > /dev/null
sleep 0.1
kill -9 $PPID
