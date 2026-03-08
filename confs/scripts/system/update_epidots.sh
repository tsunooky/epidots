#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

pre_update_handle_version0()
{
    rm -rf "$tmp/confs/zshrc"
    rm -rf "$tmp/confs/bashrc"

    TMP_STARTUP_SCRIPTS_SAVE="/tmp/tmp_startup_scripts_save"
    mkdir "$TMP_STARTUP_SCRIPTS_SAVE"
    cp "$CONFIG/scripts/startup_scripts/*" "$TMP_STARTUP_SCRIPTS_SAVE/"

    rm -rf "$CONFIG/scripts"

}
post_update_handle_version0()
{
    cp "$TMP_STARTUP_SCRIPTS_SAVE/*" "$SCRIPTS/startup_scripts/"
    rm -rf "$TMP_STARTUP_SCRIPTS_SAVE"
}



{

    echo -e "=\b${RED}==== EPIDOTS UPDATE ====${NC}"
    echo -e "\b${RED}/!\\ Don't close this terminal during update${NC}"
    echo -e "\b${BLUE}::Current Version : $VERSION${NC}"
    echo -e "\b${BLUE}::Latest Version : $REPO_VERSION${NC}"
    echo -ne "${BLUE}::${NC} Updating Epidots (${BRANCH})...  "

    err=$(mktemp)

    (
        set -e
        tmp=$(mktemp -d)
        
        git clone --depth 1 -b "$BRANCH" "$REPO_EPIDOTS" "$tmp"
        
        # Pre-update version handler
        if [ "$VERSION" -eq 0 ]; then
            pre_update_handle_version0
        fi

        cp -r "$tmp/confs/"* "$CONFS/"

        if [ -f "$CONFS/.alt" ]; then
            sed -i 's/set $mod Mod4/set $mod Mod1/' "$CONFS/config/i3/config"
        fi
        
        sh "$SCRIPTS/wallpaper_scripts/safe_change_wallpaper.sh"

        chmod +x "$CONFS/install.sh" > /dev/null 2>&1
        AFS_DIR="$AFS" "$CONFS/install.sh"
        
        # Post-update version handler
        if [ "$VERSION" -eq 0 ]; then
            post_update_handle_version0
        fi

        rm -rf "$tmp"
    ) >"$err" 2>&1 &

    pid=$!
    i=0

    while kill -0 $pid 2>/dev/null; do
        case $((i % 4)) in
            0) printf "\b-" ;;
            1) printf "\b\\" ;;
            2) printf "\b|" ;;
            3) printf "\b/" ;;
        esac
        i=$((i + 1))
        sleep 0.1
    done

    wait $pid
    EXIT_CODE=$?

    if [ $EXIT_CODE -eq 0 ]; then
        rm -f "$err"
        printf "\b[${GREEN}OK${NC}]\n"

        i3-msg restart >/dev/null 2>&1
    else
        printf "\b[${RED}KO${NC}]\n"
        cat "$err"
        rm -f "$err"
        exit 1
    fi
}
