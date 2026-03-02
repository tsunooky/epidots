#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

bash -c 'used=$(fs quota ~/afs | cut -d'%' -f1); total=$((2*1024*1024)); echo -e "\033[0;34m::\033[0m Current AFS usage:            $used%"'

echo -ne "\033[0;34m::\033[0m Removing bloatware...        "
rm -rf "$CONF/"{bash,blerc,emacs,epiconf,jnewsrc,msmtprc,muttrc,pkgs.sh,slrnrc,thunderbird,xinitrc}
rm -rf "$CONFS/"{Windows,ble,cef_user_data,chromium,dconf,doomretro,enchant,geany,gedit,glib-2.0,gimp,GIMP,gtk-2.0,libfm,lxpanel,matplotlib,menus,mimeapps.list,mpv,pavucontrol.ini,pcmanfm,pulse,QtProject.conf,RStudio,rstudio,Syncplay,syncplay.ini,Thunar,tint2,vlc,wslu,xfce4,powermenu.rasi}
rm -rf "$CONFS/Electron"
echo -e "\033[0;32m[OK]\033[0m"

if [ -d "$CONFS/discord" ]; then
    echo -ne "\033[0;34m::\033[0m Cleaning Discord cache...    "
    rm -rf "$CONFS/discord/"{Cache,Code\ Cache,GPUCache,DawnCache,blob_storage}
    echo -e "\033[0;32m[OK]\033[0m"
fi

if [ -d "$CONF/mozilla" ]; then
    echo -ne "\033[0;34m::\033[0m Cleaning Firefox cache...    "
    find "$CONF/mozilla" -type d \( -name "cache2" -o -name "startupCache" -o -name "jumpListCache" \) -exec rm -rf {} +
    find "$CONF/mozilla" -name "*.sqlite-wal" -delete
    echo -e "\033[0;32m[OK]\033[0m"
fi

if [ -d "$CONFS/JetBrains" ]; then
    echo -ne "\033[0;34m::\033[0m Cleaning JetBrains cache...  "
    rm -rf "$CONFS/JetBrains/"*/{log,cache,system/caches}
    echo -e "\033[0;32m[OK]\033[0m"
fi

bash -c 'used=$(fs quota ~/afs | cut -d'%' -f1); total=$((2*1024*1024)); echo -e "\033[0;34m::\033[0m AFS usage after update:       $used%"'
