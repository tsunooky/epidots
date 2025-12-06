#!/bin/sh

set -e

AFS_DIR=~/afs/.confs
CONFIG_SRC="Config"
REPO_DIR=~/epidots
WALLPAPER_REPO="https://github.com/tsunooky/epidots-wallpapers.git"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
GRAY='\033[0;90m'
RED='\033[0;31m'
NC='\033[0m'

STEP=1
TOTAL_STEPS=7

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

run_step "Deploying config to AFS" \
    "mkdir -p \"$AFS_DIR\" && cp -r \"$CONFIG_SRC/\"* \"$AFS_DIR/\""

run_step "Downloading Default Wallpapers" \
    "if [ ! -d \"$AFS_DIR/wallpapers\" ]; then \
        git clone \"$WALLPAPER_REPO\" \"$AFS_DIR/wallpapers\" && \
        rm -rf \"$AFS_DIR/wallpapers/.git\"; \
    else \
        echo \"[SKIP] Folder already exists\"; \
    fi"

run_step "Installing Vim plugins" \
    "vim +PluginInstall +qall"

DEFAULT_WALL="$AFS_DIR/wallpapers/default.jpg"
run_step "Setting default wallpaper" \
    "feh --bg-fill \"$DEFAULT_WALL\" && cp ~/.fehbg \"$AFS_DIR/\""

run_step "Reloading i3 window manager" \
    "i3-msg restart"

run_step "! Check pywalfox extension for firefox color theming !" \
    "firefox https://addons.mozilla.org/en-US/firefox/addon/pywalfox/"

run_step "Cleaning up installation files" \
    "cd ~ && rm -rf \"$REPO_DIR\""

echo ""
echo -e "${GREEN}=======================================${NC}"
echo -e "${GREEN}        Installation Complete!         ${NC}"
echo -e "${GREEN}     Please logout and reconnect...    ${NC}"
echo -e "${GREEN}=======================================${NC}"
echo ""

i3-nagbar -t warning -m 'Epidots installed! Logout and reconnect to apply.' -B ' -> LOGOUT <- ' 'i3-msg exit' 2&> /dev/null &
