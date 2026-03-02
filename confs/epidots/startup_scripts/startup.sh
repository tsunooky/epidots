#!/bin/bash

source "$HOME/afs/.confs/epidots/globals.sh"

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
    echo -e "\b${RED}[FAIL]${NC}"
    echo -e "${GRAY}An error occurred. Check /tmp/epidots_install.log for details.${NC}"
fi

printf "${BLUE}::${NC} Configuring Pywalfox...                 "
pywalfox install > /dev/null 2>&1 && echo -e "${GREEN}[OK]${NC}" || echo -e "[SKIP]"

printf "${BLUE}::${NC} Restarting i3...                        "
i3-msg restart > /dev/null 2>&1 && echo -e "${GREEN}[OK]${NC}" || echo -e "[SKIP]"

# Utilisation de la variable $SCRIPTS de globals.sh
SCRIPT_BG="$SCRIPTS/change_wallpaper.sh"

if [ -f "$DOTBG" ]; then
    IMG_NAME=$(cat "$DOTBG")
    FULL_PATH="$WALLPAPERS/$IMG_NAME"
    if [ -f "$FULL_PATH" ] &&[ -f "$SCRIPT_BG" ]; then
        printf "${BLUE}::${NC} Re-applying wallpaper theme...          "
        chmod +x "$SCRIPT_BG"
        "$SCRIPT_BG" "$FULL_PATH" > /dev/null 2>&1 && echo -e "${GREEN}[OK]${NC}" || echo -e "${RED}[FAIL]${NC}"
    fi
fi

echo -e "${GREEN}All done!${NC}"

nohup firefox intra.forge.epita.fr > /dev/null 2>&1 & disown
nohup alacritty > /dev/null 2>&1 & disown

echo -e "${GRAY}Closing installer...${NC}"

# Lancement des scripts de démarrage perso
for f in "$SCRIPTS/startup_scripts/"* ; do
    if [ -f "$f" ]; then
        chmod +x "$f"
        echo "Executed script: $f"
        "$f"
    fi
done

# "$SCRIPTS/aklog.sh" > /dev/null 2>&1 & disown

killall emacs > /dev/null 2>&1
sleep 0.1
kill -9 $PPID

