#!/bin/sh

set -e

AFS="$HOME/afs"
CONFS="$AFS/.confs"
WALLPAPERS="$CONFS/wallpapers"
CONFIG_SRC="confs"
REPO_DIR="$HOME/epidots"
REPO_WALLPAPER="https://github.com/tsunooky/epidots-wallpapers.git"

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
    "mkdir -p \"$CONFS\" && cp -r \"$CONFIG_SRC/\"* \"$CONFS/\""

run_step "Downloading Default Wallpapers" \
    "if [ ! -d \"$WALLPAPERS\" ]; then \
        git clone \"$REPO_WALLPAPER\" \"$WALLPAPERS\" && \
        rm -rf \"$WALLPAPERS/.git\"; \
    else \
        echo \"[SKIP] Folder already exists\"; \
    fi"

run_step "Downloading Vundle plugin manager" \
    "if[ ! -d \"$CONFS/vim/bundle/Vundle.vim\" ]; then \
        git clone https://github.com/VundleVim/Vundle.vim.git \"$CONFS/vim/bundle/Vundle.vim\"; \
    else \
        echo \"[SKIP] Vundle already installed\"; \
    fi"

run_step "Installing Vim plugins" \
    "vim +PluginInstall +qall"

DEFAULT_WALL="$WALLPAPERS/default.jpg"
run_step "Setting default wallpaper" \
    "feh --bg-fill \"$DEFAULT_WALL\" && cp ~/.fehbg \"$CONFS/\""

run_step "Reloading i3 window manager" \
    "i3-msg restart"

run_step "! Check pywalfox extension for firefox color theming !" \
    "firefox https://addons.mozilla.org/en-US/firefox/addon/pywalfox/"

run_step "Cleaning up installation files" \
    "cd \"$HOME\" && rm -rf \"$REPO_DIR\""

echo ""
echo -e "${GREEN}=======================================${NC}"
echo -e "${GREEN}        Installation Complete!         ${NC}"
echo -e "${GREEN}     Please logout and reconnect...    ${NC}"
echo -e "${GREEN}=======================================${NC}"
echo ""

i3-nagbar -t warning -m 'Epidots installed! Logout and reconnect to apply.' -B ' -> LOGOUT <- ' 'i3-msg exit' 2&> /dev/null &
