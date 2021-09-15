#!/usr/bin/env bash
if [ ! -d "${HOME}/.config/nvim" ]; then
    mkdir -p "${HOME}/.config/nvim"
fi

cp "./init.lua" "${HOME}/.config/nvim/init.lua"
