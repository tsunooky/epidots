#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

if [ -z "$CONFS" ] || [ -z "$CONFIG" ]; then
    printf "${RED}Error: CONFS or CONFIG variables are not set. Aborting.${NC}\n"
    exit 1
fi

used=$(fs quota ~/afs 2>/dev/null | cut -d'%' -f1)
printf "${BLUE}::${NC} %-42s" "Current AFS usage:"
echo -e "[${RED} $used%${NC}]"

printf "${BLUE}::${NC} %-42s" "Removing bloatware..."

confs_bloat="bash blerc emacs epiconf jnewsrc msmtprc muttrc pkgs.sh slrnrc xinitrc startup.sh .gitignore .git sqlfluff"
for item in $confs_bloat; do
    [ -e "$CONFS/$item" ] && rm -rf "$CONFS/$item"
done

config_bloat="autostart Windows ble cef_user_data chromium dconf doomretro enchant geany gedit glib-2.0 gimp GIMP gtk-2.0 libfm lxpanel matplotlib menus mimeapps.list mpv pavucontrol.ini pcmanfm pulse QtProject.conf RStudio rstudio Syncplay syncplay.ini Thunar tint2 vlc wslu xfce4 powermenu.rasi Electron"
for item in $config_bloat; do
    [ -e "$CONFIG/$item" ] && rm -rf "$CONFIG/$item"
done

printf "[${GREEN}OK${NC}]\n"

if [ -d "$CONFS/thunderbird" ]; then
    printf "${BLUE}::${NC} %-42s" "Cleaning Thunderbird cache..."
    find "$CONFS/thunderbird" -type d \( -name "cache2" -o -name "startupCache" -o -name "jumpListCache" \) -exec rm -rf {} + 2>/dev/null
    printf "[${GREEN}OK${NC}]\n"
fi

if [ -d "$CONFIG/discord" ]; then
    printf "${BLUE}::${NC} %-42s" "Cleaning Discord cache..."
    rm -rf "$CONFIG/discord/Cache" \
           "$CONFIG/discord/Code Cache" \
           "$CONFIG/discord/GPUCache" \
           "$CONFIG/discord/DawnCache" \
           "$CONFIG/discord/blob_storage"
    printf "[${GREEN}OK${NC}]\n"
fi

if [ -d "$CONFS/mozilla" ]; then
    printf "${BLUE}::${NC} %-42s" "Cleaning Firefox cache & telemetry..."
    find "$CONFS/mozilla" -type d \( -name "cache2" -o -name "startupCache" -o -name "jumpListCache" -o -name "crashes" -o -name "minidumps" -o -name "datareporting" \) -exec rm -rf {} + 2>/dev/null
    find "$CONFS/mozilla" -name "*.sqlite-wal" -exec rm -f {} + 2>/dev/null
    printf "[${GREEN}OK${NC}]\n"
fi

if [ -d "$CONFIG/JetBrains" ]; then
    printf "${BLUE}::${NC} %-42s" "Cleaning JetBrains cache..."
    find "$CONFIG/JetBrains" -maxdepth 3 -type d \( -name "log" -o -name "cache" \) -exec rm -rf {} + 2>/dev/null
    find "$CONFIG/JetBrains" -path "*/system/caches" -type d -exec rm -rf {} + 2>/dev/null
    printf "[${GREEN}OK${NC}]\n"
fi

if [ -d "$CONFIG/Code" ] || [ -d "$CONFIG/Code - OSS" ] || [ -d "$CONFIG/VSCodium" ]; then
    printf "${BLUE}::${NC} %-42s" "Cleaning VS Code & VSCodium cache..."
    for code_dir in "Code" "Code - OSS" "VSCodium"; do
        if [ -d "$CONFIG/$code_dir" ]; then
            rm -rf "$CONFIG/$code_dir/Cache" \
                   "$CONFIG/$code_dir/CachedData" \
                   "$CONFIG/$code_dir/CachedExtensionVSIXs" \
                   "$CONFIG/$code_dir/CachedExtensions" \
                   "$CONFIG/$code_dir/Crash Reports" \
                   "$CONFIG/$code_dir/User/workspaceStorage"
        fi
    done
    printf "[${GREEN}OK${NC}]\n"
fi

printf "${BLUE}::${NC} %-42s" "Hunting large core dumps and trash..."
find "$AFS" -type d -name ".Trash-*" -exec rm -rf {} + 2>/dev/null
find "$AFS" -type f -name "core.*" -size +50M -exec rm -f {} + 2>/dev/null
printf "[${GREEN}OK${NC}]\n"

used_after=$(fs quota ~/afs 2>/dev/null | cut -d'%' -f1)
printf "${BLUE}::${NC} %-42s" "Current AFS usage:"
echo -e "[${GREEN} $used_after%${NC}]"
