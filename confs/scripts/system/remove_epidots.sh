#!/bin/sh

{
    source "$HOME/afs/.confs/scripts/globals.sh"

    printf "\n${RED}=== FACTORY RESET ===${NC}\n"

    printf "${BLUE}::${NC} Backing up user files...  "

    if [ -d "$SCRIPTS/startup_scripts" ]; then
        for sc in "$SCRIPTS/startup_scripts"/*; do
            [ -e "$sc" ] || continue
            fname="${sc##*/}"
            if [ "$fname" != "startup.sh" ]; then
                mkdir -p "$AFS/user_scripts"
                mv "$sc" "$AFS/user_scripts/"
            fi
        done
    fi

    is_default_wp() {
        case "$1" in
            abyss.jpg|boat.jpg|cats.jpg|default.jpg|epita.jpg|island_1.jpg|island_2.jpg|island_3.jpg|island_4.jpg|lake.jpg|liquid.jpg|moon.jpg|pirates.jpg|red.jpg|sky.jpg|tower.jpg|trees.jpg|winter.jpg)
                return 0
                ;;
            *)
                return 1
                ;;
        esac
    }

    if [ -d "$WALLPAPERS" ]; then
        for wp in "$WALLPAPERS"/*; do
            [ -e "$wp" ] || continue
            fname="${wp##*/}"
            if ! is_default_wp "$fname"; then
                mkdir -p "$AFS/user_wallpapers"
                mv "$wp" "$AFS/user_wallpapers/"
            fi
        done
    fi

    printf "${GREEN}[OK]${NC}\n"

    printf "${BLUE}::${NC} Restoring defaults...     "

    tmp=$(mktemp -d)
    if git clone "https://gitlab.cri.epita.fr/forge/packages/sm-default-dotfiles.git" "$tmp" >/dev/null 2>&1; then
        cp -Rf "$tmp/"* "$CONFS/" 2>/dev/null
        cp -Rf "$tmp/".[!.]* "$CONFS/" 2>/dev/null
        rm -rf "$CONFS/.git"
        rm -rf "$tmp"
        printf "${GREEN}[OK]${NC}\n"
    else
        rm -rf "$tmp"
        printf "${RED}[FAIL]${NC}\n"
        exit 1
    fi

    printf "${BLUE}::${NC} Cleaning files...         "

    i3c="$CONFS/config/i3/config"
    if [ -f "$i3c" ]; then
        cp "$i3c" "$HOME/config.temp"
    fi

    rm -rf "$CONFS/wallpapers" \
           "$CONFS/scripts" \
           "$CONFS/config/alacritty" \
           "$CONFS/config/matugen" \
           "$CONFS/config/gtk-3.0" \
           "$CONFS/config/gtk-4.0" \
           "$CONFS/config/qt5ct" \
           "$CONFS/config/qt6ct" \
           "$CONFS/config/rofi" \
           "$CONFS/config/scripts" \
           "$CONFS/config/polybar" \
           "$CONFS/config/picom" \
           "$CONFS/config/starship.toml"

    if [ -f "$HOME/config.temp" ]; then
        mkdir -p "$(dirname "$i3c")"
        mv "$HOME/config.temp" "$i3c"
    fi

    printf "${GREEN}[OK]${NC}\n"

    pkill polybar >/dev/null 2>&1
    pkill picom >/dev/null 2>&1
    i3-msg restart >/dev/null 2>&1

    if [ -x "$CONFS/install.sh" ]; then
        "$CONFS/install.sh" >/dev/null 2>&1
    fi

    printf "${GREEN}Reset done.${NC} Restart terminal to finish reset. See you soon on Epidots!\n"
}
