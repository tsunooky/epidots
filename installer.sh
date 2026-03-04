#!/bin/sh

BRANCH="dev"
REPO_URL="https://github.com/tsunooky/epidots.git"
TARGET_DIR="$HOME/epidots"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

printf "${BLUE}::${NC} %-42s" "Cloning repository (${BRANCH})..."
if git clone -b "$BRANCH" "$REPO_URL" "$TARGET_DIR" > /dev/null 2>&1; then
    printf "[${GREEN}OK${NC}]\n"
else
    printf "[${RED}KO${NC}]\n"
    exit 1
fi

(
    cd "$TARGET_DIR" || exit 1
    chmod +x setup.sh
    ./setup.sh
)
