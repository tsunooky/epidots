# BRANCH
BRANCH="dev"

# COLORS
BLACK="\033[30m"
WHITE="\033[97m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
GRAY="\033[90m"
LIGHT_GRAY="\033[37m"
LIGHT_RED="\033[91m"
LIGHT_GREEN="\033[92m"
LIGHT_YELLOW="\033[93m"
LIGHT_BLUE="\033[94m"
LIGHT_MAGENTA="\033[95m"
LIGHT_CYAN="\033[96m"
NC="\033[0m"

# CONFIG DIRECTORIES
AFS="$HOME/afs"
CONFS="$AFS/.confs"
CONFIG="$CONFS/config"
SCRIPTS="$CONFS/scripts"
WALLPAPERS="$CONFS/wallpapers"

# URLS
REPO_EPIDOTS="https://github.com/tsunooky/epidots.git"
REPO_WALLPAPER="https://github.com/tsunooky/epidots-wallpapers.git"
RAW_REPO_EPIDOTS="https://raw.githubusercontent.com/tsunooky/epidots/refs/heads/$BRANCH/"

# VERSION
VERSION_FILE="$AFS/.version"
VERSION=0

if [ -f $VERSION_FILE ]; then
    VERSION=$(cat "$VERSION_FILE")
fi

REPO_VERSION_FILE="/tmp/epidots_repo_version"i
if ! [ -f "$REPO_VERSION_FILE" ]; then
    curl -L "$RAW_REPO_EPIDOTS/version" > "$REPO_VERSION_FILE"
fi

REPO_VERSION="$(cat $REPO_VERSION_FILE)"


