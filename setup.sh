#!/bin/sh

set -e

AFS_DIR=~/afs/.confs
CONFIG_SRC="Config"
REPO_DIR=~/epidots

GREEN='\033[0;32m'
BLUE='\033[0;34m'
GRAY='\033[0;90m'
RED='\033[0;31m'
NC='\033[0m'

STEP=1
TOTAL_STEPS=6

run_step() {
    local description=$1
    local command=$2

    printf "${BLUE}[%d/%d]${NC} %-40s " "$STEP" "$TOTAL_STEPS" "$description..."

    if eval "$command" > /dev/null 2>&1; then
        echo -e "${GREEN}[OK]${NC}"
    else
        echo -e "${RED}[FAIL]${NC}"
    fi

    STEP=$((STEP + 1))
}

echo -e "${BLUE}=== EPIDOTS SETUP ===${NC}"

run_step "Deploying configs to AFS" \
    "mkdir -p \"$AFS_DIR\" && cp -r \"$CONFIG_SRC/\"* \"$AFS_DIR/\""

run_step "Installing Vim plugins" \
    "vim +PluginInstall +qall"

WALLPAPER_SCRIPT="$AFS_DIR/config/scripts/change_wallpaper.sh"
DEFAULT_WALL="$AFS_DIR/wallpapers/default.jpg"
run_step "Setting default wallpaper" \
    "chmod +x \"$WALLPAPER_SCRIPT\" && \"$WALLPAPER_SCRIPT\" \"$DEFAULT_WALL\""

run_step "Reloading i3 window manager" \
    "i3-msg restart"

run_step "Opening Pywalfox setup" \
    "nohup firefox https://addons.mozilla.org/en-US/firefox/addon/pywalfox/ &"

echo -e "${GRAY}   -> Please install the Pywalfox extension in the opened window.${NC}"
echo -e "${GRAY}   -> Press ENTER once installed to cleanup and reboot.${NC}"
read -r

run_step "Cleaning up installation files" \
    "cd ~ && rm -rf \"$REPO_DIR\""

echo ""
echo -e "${GREEN}=======================================${NC}"
echo -e "${GREEN}        Installation Complete!         ${NC}"
echo -e "${GREEN}        Rebooting system...            ${NC}"
echo -e "${GREEN}=======================================${NC}"

sleep 2
reboot
