#!/bin/sh

if [ ! -f "$HOME/.note.lock" ] || ! (kill -s 0 $(cat ~/.note.lock));  then
    rm ~/.note.lock.swp
    touch ~/.note.lock
    echo $PPID > ~/.note.lock
    vim ~/afs/.note.txt +startinsert
    rm ~/.note.lock
fi

