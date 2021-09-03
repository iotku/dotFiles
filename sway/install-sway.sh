#!/usr/bin/env bash
if [ ! -d "${HOME}/.config/sway" ]; then
    mkdir -p "${HOME}/.config/sway"
fi

cp ./config "${HOME}/.config/sway"

