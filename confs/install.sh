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
nixpkgs#pywal
nixpkgs#pywalfox-native
nixpkgs#picom
nixpkgs#polybar
nixpkgs#autotiling
nixpkgs#papirus-icon-theme
nixpkgs#bat
nixpkgs#matugen
nixpkgs#adw-gtk3
nixpkgs#pqiv
nixpkgs#neovim
nixpkgs#clang-tools
nixpkgs#nodePackages.bash-language-server
nixpkgs#shfmt
nixpkgs#cmake-language-server
nixpkgs#cmake-format
nixpkgs#tree-sitter
nixpkgs#ripgrep
"

nix profile install $PACKAGES --impure > /dev/null 2>&1
