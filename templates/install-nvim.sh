#!/bin/bash
if [ ! -d "${HOME}/.config/nvim" ]; then
    mkdir -p "${HOME}/.config/nvim"
fi

if [ ! -f "${HOME}/.local/share/nvim/site/autoload/plug.vim" ]; then
       curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

cp "./init.vim" "${HOME}/.config/nvim/init.vim"
cp "./ginit.vim" "${HOME}/.config/nvim/ginit.vim"
