#!/bin/sh

{
    source "$HOME/afs/.confs/scripts/globals.sh"

    printf "\n${RED}=== FACTORY RESET ===${NC}\n"

    printf "${BLUE}::${NC} Comparing with remote repositories... "

    tmp_chk=$(mktemp -d)

    if git clone --depth 1 -b "$BRANCH" "$REPO_EPIDOTS" "$tmp_chk/main" >/dev/null 2>&1 && \
       git clone --depth 1 "$REPO_WALLPAPER" "$tmp_chk/walls" >/dev/null 2>&1; then
        printf "${GREEN}[OK]${NC}\n"
    else
        rm -rf "$tmp_chk"
        printf "${RED}[FAIL]${NC}\n"
        exit 1
    fi

    printf "${BLUE}::${NC} Backing up user files...            "

    # Backup Scripts
    if [ -d "$SCRIPTS/startup_scripts" ]; then
        mkdir -p "$AFS/user_scripts"
        ls "$tmp_chk/main/confs/scripts/startup_scripts" > "$tmp_chk/defaults_scripts.txt"
        
        for sc in "$SCRIPTS/startup_scripts"/*; do
            [ -e "$sc" ] || continue
            fname="${sc##*/}"
            if ! grep -Fqx "$fname" "$tmp_chk/defaults_scripts.txt"; then
                mv "$sc" "$AFS/user_scripts/"
            fi
        done
    fi

    # Backup Wallpapers
    if [ -d "$WALLPAPERS" ]; then
        mkdir -p "$AFS/user_wallpapers"
        ls "$tmp_chk/walls" > "$tmp_chk/defaults_walls.txt"

        for wp in "$WALLPAPERS"/*; do
            [ -e "$wp" ] || continue
            fname="${wp##*/}"
            if [ "$fname" = ".git" ]; then continue; fi
            if ! grep -Fqx "$fname" "$tmp_chk/defaults_walls.txt"; then
                mv "$wp" "$AFS/user_wallpapers/"
            fi
        done
    fi
    
    rm -rf "$tmp_chk"
    printf "${GREEN}[OK]${NC}\n"

    printf "${BLUE}::${NC} Restoring defaults...               "

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

    printf "${BLUE}::${NC} Cleaning files...                   "

    i3c="$CONFS/config/i3/config"
    if [ -f "$i3c" ]; then
        cp "$i3c" "$HOME/config.temp"
    fi

    rm -rf "$CONFS/wallpapers" \
           "$CONFS/scripts" \
           "$CONFS/config/scripts" \
           "$CONFS/config/alacritty" \
           "$CONFS/config/matugen" \
           "$CONFS/config/gtk-3.0" \
           "$CONFS/config/gtk-4.0" \
           "$CONFS/config/qt5ct" \
           "$CONFS/config/qt6ct" \
           "$CONFS/config/rofi" \
           "$CONFS/config/dunst" \
           "$CONFS/config/picom" \
           "$CONFS/config/polybar" \
           "$CONFS/config/flameshot" \
           "$CONFS/config/nvim" \
           "$CONFS/config/i3/colors.conf" \
           "$CONFS/config/starship.toml" \
           "$CONFS/startup.sh" \
           "$CONFS/gdbinit" \
           "$CONFS/zshrc" \
           "$CONFS/vimrc" \
           "$CONFS/clang-format"

    if [ -f "$HOME/config.temp" ]; then
        mkdir -p "$(dirname "$i3c")"
        mv "$HOME/config.temp" "$i3c"
    fi

    rm -f "$CONFS/config/i3/config"
    i3-config-wizard >/dev/null 2>&1

    printf "${GREEN}[OK]${NC}\n"

    pkill polybar >/dev/null 2>&1
    pkill picom >/dev/null 2>&1
    pkill dunst >/dev/null 2>&1
    i3-msg restart >/dev/null 2>&1

    if [ -x "$CONFS/install.sh" ]; then
        "$CONFS/install.sh" >/dev/null 2>&1
    fi

    printf "${GREEN}Reset done.${NC} Restart terminal to finish reset. See you soon on Epidots!\n"
}
