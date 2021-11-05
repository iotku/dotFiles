#!/usr/bin/env bash
CONFDIR="${HOME}/.config/kitty"
if [ ! -d "$CONFDIR" ]; then
    mkdir -p "$CONFDIR"
fi

cp ./kitty.conf "${CONFDIR}/kitty.conf"
