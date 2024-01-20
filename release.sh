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

# tmux configs
cp ~/.tmux.conf ./.tmux.conf

# nvim configs
mkdir -p nvim
cp -r ~/.config/nvim/* ./nvim/
cp ~/.config/nvim/init.vim.old ./nvim/init.vim.old

# pavucontrol
cp ~/.config/pavucontrol.ini ./pavucontrol.ini

# emacs files
mkdir -p .emacs.d
cp ~/.emacs ./.emacs
cp ~/.emacs.d/configuration.org ./.emacs.d/configuration.org
cp ~/.emacs.d/configuration.el ./.emacs.d/configuration.el

# rofi configuration
mkdir -p rofi
cp -r ~/.config/rofi/* ./rofi

# config scripts related
mkdir -p scripts
cp -r ~/scripts/ ./

# cmus config
mkdir -p cmus
cp ~/.config/cmus/rc cmus/rc

# zathura config
mkdir -p zathura
cp ~/.config/zathura/zathurarc zathura/zathurarc

# ranger config
mkdir -p ranger
cp ~/.config/ranger/* ranger/

# lightdm config
mkdir -p lightdm
cp /etc/lightdm/lightdm.conf lightdm/
cp /etc/lightdm/lightdm-gtk-greeter.conf lightdm/

# picom config
mkdir -p picom
cp ~/.config/picom/picom.conf picom/

echo "== Finished! =="
