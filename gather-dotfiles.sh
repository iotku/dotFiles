#!/usr/bin/env bash
set -e
# neovim
cp "${HOME}/.config/nvim/init.lua" "./nvim/init.lua"
cp "./templates/install-nvim.sh" "./nvim/install-nvim.sh"

# zsh
cp "${HOME}/.zshrc" "./zsh/zshrc"

# i3
cp "${HOME}/.config/i3/config" "./i3/config"

#i3blocks
cp "${HOME}/.config/i3blocks/config" "./i3blocks/config"
cp -r "${HOME}/.config/i3blocks/scripts/" "./i3blocks/"

#emacs
#cp "${HOME}/.emacs.d/init.el" "./emacs/init.el"
