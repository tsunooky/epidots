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

DEFAULT_WALL="$AFS_DIR/wallpapers/default.jpg"
run_step "Setting default wallpaper" \
    "feh --bg-fill \"$DEFAULT_WALL\" && cp ~/.fehbg \"$AFS_DIR/\""

run_step "Reloading i3 window manager" \
    "i3-msg restart"

run_step "! Make sure to have pywalfox extension for firefox theming to work !" \
    "firefox https://addons.mozilla.org/en-US/firefox/addon/pywalfox/"

run_step "Cleaning up installation files" \
    "cd ~ && rm -rf \"$REPO_DIR\""

echo ""
echo -e "${GREEN}=======================================${NC}"
echo -e "${GREEN}        Installation Complete!         ${NC}"
echo -e "${GREEN}     Please reboot your system...      ${NC}"
echo -e "${GREEN}=======================================${NC}"

i3-nagbar -t warning -m 'Epidots is succefully installed, you need to reboot to apply the configuration' -B 'REBOOT' 'shutdown -r now' 2&> /dev/null &

