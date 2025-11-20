#!/bin/sh

GREEN='\033[0;32m'
BLUE='\033[0;34m'
GRAY='\033[0;90m'
NC='\033[0m'

install_pkg() {
    local pkg_full=$1
    local current_idx=$2
    local total_pkgs=$3
    local pkg_name="${pkg_full#nixpkgs.}"

    printf "${BLUE}[%d/%d]${NC} Installing %-30s " "$current_idx" "$total_pkgs" "$pkg_name..."

    if nix-env -iA "$pkg_full" > /dev/null 2>&1; then
        echo -e "${GREEN}[OK]${NC}"
    else
        echo -e "\033[0;31m[FAIL]${NC}"
    fi
}

echo -e "${BLUE}=== Starting Epidots Setup ===${NC}"

printf "${BLUE}::${NC} Updating Nix channels... "
{
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable
    nix-channel --update
} > /dev/null 2>&1
echo -e "${GREEN}[DONE]${NC}"

PACKAGES=(
    "nixpkgs.starship"
    "nixpkgs.lsd"
    "nixpkgs.nerd-fonts.jetbrains-mono"
    "nixpkgs.pywal"
    "nixpkgs.pywalfox-native"
    "nixpkgs.rofi"
    "nixpkgs.picom"
    "nixpkgs.polybar"
    "nixpkgs.autotiling"
    "nixpkgs.papirus-icon-theme"
    "nixpkgs.bat"
    "nixpkgs.blueman"
    "nixpkgs.matugen"
    "nixpkgs.adw-gtk3"
)

TOTAL_PKGS=${#PACKAGES[@]}
CURRENT_COUNT=1

echo -e "${GRAY}Installing packages...${NC}"

for pkg in "${PACKAGES[@]}"; do
    install_pkg "$pkg" "$CURRENT_COUNT" "$TOTAL_PKGS"
    CURRENT_COUNT=$((CURRENT_COUNT + 1))
done

printf "${BLUE}::${NC} Configuring Pywalfox...                 "
pywalfox install > /dev/null 2>&1 && echo -e "${GREEN}[OK]${NC}" || echo -e "[SKIP]"

printf "${BLUE}::${NC} Restarting i3...                        "
i3-msg restart > /dev/null 2>&1 && echo -e "${GREEN}[OK]${NC}" || echo -e "[SKIP]"

echo -e "${GREEN}All done!${NC}"

nohup firefox intra.forge.epita.fr > /dev/null 2>&1 &

(cd ~/afs && nohup alacritty > /dev/null 2>&1 &)

echo -e "${GRAY}Closing installer...${NC}"

sleep 1

kill -9 $PPID
