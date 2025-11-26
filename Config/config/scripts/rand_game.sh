#!/bin/sh

rand=$((RANDOM % 2))

if [ rand -eq 0 ]; then
    emacs -f tetris > dev/null 2>&1 &
elif [ rand -eq 1 ]; then
    emacs -f snake > dev/null 2>&1 &
elif [ rand -eq 2 ]; then
    emacs -f gomoku > dev/null 2>&1 &
fi
