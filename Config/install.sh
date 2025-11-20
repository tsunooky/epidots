#!/bin/sh

dot_list="bashrc config gitignore gitconfig signature jnewsrc mozilla msmtprc muttrc slrnrc ssh thunderbird vim vimrc Xdefaults gdbinit"

for f in $dot_list; do
  rm -rf "$HOME/.$f"
  ln -s "$AFS_DIR/.confs/$f" "$HOME/.$f"
done
