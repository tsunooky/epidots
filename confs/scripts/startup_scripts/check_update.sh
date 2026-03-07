#!/bin/sh

source "$HOME/afs/.confs/scripts/globals.sh"

if [ "$VERSION" -lt "$REPO_VERSION" ]; then
    dunstify "New Epidots update available \!" "Please run update-conf\n(Current: $VERSION, Latest: $REPO_VERSION)" -t 60000
fi
