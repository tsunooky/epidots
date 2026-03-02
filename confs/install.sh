#!/bin/sh

dot_list="sqlfluff zshrc bashrc gitconfig config mozilla signature ssh thunderbird emacs vim vimrc Xdefaults gdbinit"

for f in $dot_list; do
  rm -rf "$HOME/.$f"
  ln -s "$AFS_DIR/.confs/$f" "$HOME/.$f"
done
