#!/usr/bin/env bash
if [ ! -d "${HOME}/.config/nvim" ]; then
    mkdir -p "${HOME}/.config/nvim"
    mkdir -p "${HOME}/.config/nvim/lua"
fi

cp "./init.lua" "${HOME}/.config/nvim/init.lua"
cp -a "./lua/." "${HOME}/.config/nvim/lua/"
