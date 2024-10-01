#!/usr/bin/env bash
set -e
# neovim
cp -v "${HOME}/.config/nvim/init.lua" "./nvim/init.lua"
cp -rv "${HOME}/.config/nvim/lua/"* "./nvim/lua/"
cp "./templates/install-nvim.sh" "./nvim/install-nvim.sh"

# zsh
#cp -v "${HOME}/.zshrc" "./zsh/zshrc"
#cp -v "${HOME}/.zsh_plugins.txt" "./zsh/zsh_plugins.txt"

# i3
cp -v "${HOME}/.config/i3/config" "./i3/config"

#i3blocks
cp -v "${HOME}/.config/i3blocks/config" "./i3blocks/config"
cp -v "${HOME}/.config/i3blocks/minimal-config" "./i3blocks/minimal-config"
cp -vr "${HOME}/.config/i3blocks/scripts/"* "./i3blocks/scripts/"

#emacs
#cp "${HOME}/.emacs.d/init.el" "./emacs/init.el"
