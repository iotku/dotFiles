#!/usr/bin/env bash
if [ ! -d "${HOME}/.config/nvim" ]; then
    mkdir -p "${HOME}/.config/nvim"
fi

if [ ! -f "${HOME}/.local/share/nvim/site/autoload/plug.vim" ]; then
       curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

cp "./init.lua" "${HOME}/.config/nvim/init.lua"
cp "./old.vim" "${HOME}/.config/nvim/old.vim"
