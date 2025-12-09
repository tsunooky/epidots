#!/bin/sh

if [ ! -f "$HOME/.note.lock" ] || ! (kill -s 0 $(cat ~/.note.lock));  then
    touch ~/.note.lock
    echo $PPID > ~/.note.lock
    vim ~/afs/.note.txt +startinsert
    rm ~/.note.lock
fi

