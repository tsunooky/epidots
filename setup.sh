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
TOTAL_STEPS=8

run_step() {
    local description=$1
    local command=$2

    printf "${BLUE}[%d/%d]${NC} %-40s " "$STEP" "$TOTAL_STEPS" "$description..."

    if eval "$command" > /dev/null 2>&1; then
        printf "${GREEN}[OK]${NC}\n"
    else
        printf "${RED}[FAIL]${NC}\n"
    fi

    STEP=$((STEP + 1))
}

printf "${BLUE}=== EPIDOTS SETUP ===${NC}\n"

run_step "Deploying config to AFS" \
    "mkdir -p \"$CONFS\" && cp -r \"$CONFIG_SRC/\"* \"$CONFS/\""

run_step "Downloading Default Wallpapers" \
    "if [ ! -d \"$WALLPAPERS\" ]; then \
        git clone \"$REPO_WALLPAPER\" \"$WALLPAPERS\" && \
        rm -rf \"$WALLPAPERS/.git\"; \
    else \
        echo \"[SKIP]\"; \
    fi"

run_step "Downloading Vundle plugin manager" \
    "if [ ! -d \"$CONFS/vim/bundle/Vundle.vim\" ]; then \
        mkdir -p \"$CONFS/vim/bundle\" && \
        git clone https://github.com/VundleVim/Vundle.vim.git \"$CONFS/vim/bundle/Vundle.vim\"; \
    else \
        echo \"[SKIP]\"; \
    fi"

run_step "Installing Vim plugins" \
    "vim +PluginInstall +qall"

DEFAULT_WALL="$WALLPAPERS/default.jpg"
run_step "Setting default wallpaper" \
    "feh --bg-fill \"$DEFAULT_WALL\" && cp \"$HOME/.fehbg\" \"$CONFS/\""

run_step "Reloading i3 window manager" \
    "i3-msg restart"

run_step "! Check pywalfox extension for firefox color theming !" \
    "firefox https://addons.mozilla.org/en-US/firefox/addon/pywalfox/"

run_step "Restoring user backup files" \
    "if [ -d \"$AFS/user_scripts\" ]; then \
        mv \"$AFS/user_scripts/\"* \"$CONFS/scripts/startup_scripts/\" 2>/dev/null; \
        rm -rf \"$AFS/user_scripts\"; \
    fi; \
    if [ -d \"$AFS/user_wallpapers\" ]; then \
        mv \"$AFS/user_wallpapers/\"* \"$WALLPAPERS/\" 2>/dev/null; \
        rm -rf \"$AFS/user_wallpapers\"; \
    fi"

run_step "Cleaning up installation files" \
    "cd \"$HOME\" && rm -rf \"$REPO_DIR\""

printf "\n${GREEN}=======================================${NC}\n"
printf "${GREEN}        Installation Complete!         ${NC}\n"
printf "${GREEN}     Please logout and reconnect...    ${NC}\n"
printf "${GREEN}=======================================${NC}\n\n"

i3-nagbar -t warning -m 'Epidots installed! Logout and reconnect to apply.' -B ' -> LOGOUT <- ' 'i3-msg exit' 2&> /dev/null &
