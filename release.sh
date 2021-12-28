#!/bin/bash

echo "== Copying Dotfiles =="

# global git config resources
cp ~/.gitignore ./.gitignore
cp ~/.gitconfig ./.gitconfig

# x files
cp ~/.Xresources ./.Xresources
cp ~/.xprofile ./.xprofile

# zsh files
cp ~/.zshrc ./.zshrc
cp ~/.zshenv ./.zshenv

# i3 configs
mkdir -p i3
cp ~/.config/i3/config ./i3/config
mkdir -p i3status 
cp ~/.config/i3status/config ./i3status/config

# nvim configs
mkdir -p nvim
cp ~/.config/nvim/init.vim ./nvim/init.vim

# pavucontrol
cp ~/.config/pavucontrol.ini ./pavucontrol.ini

echo "== Finished! =="
