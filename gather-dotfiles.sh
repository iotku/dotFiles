#!/usr/bin/env bash
set -e
# vim
cp "${HOME}/.config/nvim/init.vim" "./nvim/init.vim"
NVIMPLUGINS="./nvim/install-nvim.sh"
cp "./templates/install-nvim.sh" "$NVIMPLUGINS"

# zsh
cp "${HOME}/.zshrc" "./zsh/zshrc"

# i3
cp "${HOME}/.config/i3/config" "./i3/config"

#i3blocks
cp "${HOME}/.config/i3blocks/config" "./i3blocks/config"
cp -r "${HOME}/.config/i3blocks/scripts/" "./i3blocks/"

#emacs
cp "${HOME}/.emacs.d/init.el" "./emacs/init.el"
