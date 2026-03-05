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
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE} /\$\$\$\$\$\$\$\$           /\$\$       /\$\$             /\$\$             ${NC}";
echo -e "${BLUE}| \$\$_____/          |__/      | \$\$            | \$\$             ${NC}";
echo -e "${BLUE}| \$\$        /\$\$\$\$\$\$  /\$\$  /\$\$\$\$\$\$\$  /\$\$\$\$\$\$  /\$\$\$\$\$\$   /\$\$\$\$\$\$\$${NC}";
echo -e "${BLUE}| \$\$\$\$\$    /\$\$__  \$\$| \$\$ /\$\$__  \$\$ /\$\$__  \$\$|_  \$\$_/  /\$\$_____/${NC}";
echo -e "${BLUE}| \$\$__/   | \$\$  \\ \$\$| \$\$| \$\$  | \$\$| \$\$  \\ \$\$  | \$\$   |  \$\$\$\$\$\$ ${NC}";
echo -e "${BLUE}| \$\$      | \$\$  | \$\$| \$\$| \$\$  | \$\$| \$\$  | \$\$  | \$\$ /\$\$\\____  \$\$${NC}";
echo -e "${BLUE}| \$\$\$\$\$\$\$\$| \$\$\$\$\$\$\$/| \$\$|  \$\$\$\$\$\$\$|  \$\$\$\$\$\$/  |  \$\$\$\$//\$\$\$\$\$\$\$/${NC}";
echo -e "${BLUE}|________/| \$\$____/ |__/ \\_______/ \\______/    \\___/ |_______/ ${NC}";
echo -e "${BLUE}          | \$\$                                                 ${NC}";
echo -e "${BLUE}          | \$\$                                                 ${NC}";
echo -e "${BLUE}          |__/                                                 ${NC}";

printf "${BLUE}::${NC} %-42s" "Deploying config to AFS..."
mkdir -p "$CONFS" && cp -r "$CONFIG_SRC/"* "$CONFS/"
mv "version" "$AFS/.version"
printf "[${GREEN}OK${NC}]\n"

printf "${BLUE}::${NC} %-42s" "Downloading Default Wallpapers..."
if [ ! -d "$WALLPAPERS" ]; then
    git clone "$REPO_WALLPAPER" "$WALLPAPERS" && rm -rf "$WALLPAPERS/.git" > /dev/null 2>&1
fi
printf "[${GREEN}OK${NC}]\n"

printf "${BLUE}::${NC} %-42s" "Downloading Vundle plugin manager..."
if [ ! -d "$CONFS/vim/bundle/Vundle.vim" ]; then
    mkdir -p "$CONFS/vim/bundle" && git clone https://github.com/VundleVim/Vundle.vim.git "$CONFS/vim/bundle/Vundle.vim"
fi
printf "[${GREEN}OK${NC}]\n"

printf "${BLUE}::${NC} %-42s" "Installing Vim plugins..."
vim +PluginInstall +qall > /dev/null 2>&1
printf "[${GREEN}OK${NC}]\n"

printf "${BLUE}::${NC} %-42s" "Setting default wallpaper..."
feh --bg-fill "$WALLPAPERS/default.jpg" && cp "$HOME/.fehbg" "$CONFS/"
printf "[${GREEN}OK${NC}]\n"

printf "${BLUE}::${NC} %-42s" "Restoring user backup files..."
[ -d "$AFS/user_scripts" ] && mv "$AFS/user_scripts/"* "$CONFS/scripts/startup_scripts/" 2>/dev/null && rm -rf "$AFS/user_scripts"
[ -d "$AFS/user_wallpapers" ] && mv "$AFS/user_wallpapers/"* "$WALLPAPERS/" 2>/dev/null && rm -rf "$AFS/user_wallpapers"
printf "[${GREEN}OK${NC}]\n"

printf "${BLUE}::${NC} %-42s" "Cleaning up installation files..."
cd "$HOME" && rm -rf "$REPO_DIR"
printf "[${GREEN}OK${NC}]\n"

printf "${BLUE}::${NC} Be sure to have ${RED}Pywalfox${BLUE} installed to theme Firefox accordingly to your wallpaper.\n"
firefox https://addons.mozilla.org/en-US/firefox/addon/pywalfox/ > /dev/null 2>&1 &

printf "\n${BLUE}┌──────────────────────────────────────────┐${NC}\n"
printf "${BLUE}│         INSTALLATION COMPLETED !         │${NC}\n"
printf "${BLUE}│      Please logout and reconnect...      │${NC}\n"
printf "${BLUE}└──────────────────────────────────────────┘${NC}\n\n"

i3-nagbar -t warning -m 'Epidots installed! Logout and reconnect to apply.' -B ' -> LOGOUT <- ' 'i3-msg exit' 2&> /dev/null &
