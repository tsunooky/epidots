#!/bin/sh

if [ ! -f "$HOME/.note.lock" ];  then
    touch ~/.note.lock
    vim ~/afs/.note.txt +startinsert
    rm ~/.note.lock
fi

