#!/bin/sh

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

REPO_URL="https://github.com/tsunooky/epidots.git"
TARGET_DIR="$HOME/epidots"

echo -e "${BLUE}=== EPIDOTS SETUP ===${NC}"

printf "${BLUE}::${NC} Cloning repository...             "
if git clone "$REPO_URL" "$TARGET_DIR" > /dev/null 2>&1; then
    echo -e "${GREEN}[OK]${NC}"
else
    echo -e "${RED}[FAIL]${NC}"
    exit 1
fi

(
    cd "$TARGET_DIR" || exit 1
    chmod +x setup.sh
    ./setup.sh
)
