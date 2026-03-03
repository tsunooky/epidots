#!/bin/sh

dot_list="zshrc bashrc gitconfig config mozilla signature ssh thunderbird emacs vim vimrc Xdefaults gdbinit"

for f in $dot_list; do
  rm -rf "$HOME/.$f"
  ln -s "$AFS_DIR/.confs/$f" "$HOME/.$f"
done

PACKAGES="
nixpkgs#zsh
nixpkgs#zsh-autosuggestions
nixpkgs#zsh-syntax-highlighting
nixpkgs#lsd
nixpkgs#starship
nixpkgs#nerd-fonts.jetbrains-mono
nixpkgs#rofi
nixpkgs#polybar
nixpkgs#matugen
nixpkgs#dunst
"

nix profile install $PACKAGES --impure > /dev/null 2>&1
