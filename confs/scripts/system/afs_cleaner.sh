#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

used=$(fs quota ~/afs 2>/dev/null | cut -d'%' -f1)
printf "${BLUE}::${NC} %-42s" "Current AFS usage:"
printf "[${RED} $used%${NC}]\n"

printf "${BLUE}::${NC} %-42s" "Removing bloatware..."
rm -rf "$CONFS"/{bash,blerc,emacs,epiconf,jnewsrc,msmtprc,muttrc,pkgs.sh,slrnrc,xinitrc,startup.sh,.gitignore,.git,sqlfluff}
rm -rf "$CONFIG"/{autostart,Windows,ble,cef_user_data,chromium,dconf,doomretro,enchant,geany,gedit,glib-2.0,gimp,GIMP,gtk-2.0,libfm,lxpanel,matplotlib,menus,mimeapps.list,mpv,pavucontrol.ini,pcmanfm,pulse,QtProject.conf,RStudio,rstudio,Syncplay,syncplay.ini,Thunar,tint2,vlc,wslu,xfce4,powermenu.rasi,Electron}
printf "[${GREEN}OK${NC}]\n"

if [ -d "$CONFS/thunderbird" ]; then
    printf "${BLUE}::${NC} %-42s" "Cleaning Thunderbird cache..."
    find "$CONFS/thunderbird" -type d \( -name "cache2" -o -name "startupCache" -o -name "jumpListCache" \) -exec rm -rf {} + 2>/dev/null
    printf "[${GREEN}OK${NC}]\n"
fi

if [ -d "$CONFIG/discord" ]; then
    printf "${BLUE}::${NC} %-42s" "Cleaning Discord cache..."
    rm -rf "$CONFIG/discord/"{Cache,Code\ Cache,GPUCache,DawnCache,blob_storage}
    printf "[${GREEN}OK${NC}]\n"
fi

if [ -d "$CONFS/mozilla" ]; then
    printf "${BLUE}::${NC} %-42s" "Cleaning Firefox cache..."
    find "$CONFS/mozilla" -type d \( -name "cache2" -o -name "startupCache" -o -name "jumpListCache" \) -exec rm -rf {} + 2>/dev/null
    find "$CONFS/mozilla" -name "*.sqlite-wal" -delete
    printf "[${GREEN}OK${NC}]\n"
fi

if [ -d "$CONFIG/JetBrains" ]; then
    printf "${BLUE}::${NC} %-42s" "Cleaning JetBrains cache..."
    rm -rf "$CONFIG/JetBrains/"*/*/{log,cache,system/caches}
    printf "[${GREEN}OK${NC}]\n"
fi

used_after=$(fs quota ~/afs 2>/dev/null | cut -d'%' -f1)
printf "${BLUE}::${NC} %-42s" "Current AFS usage:"
printf "[${GREEN} $used_after%${NC}]\n"

