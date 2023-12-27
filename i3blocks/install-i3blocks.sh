#!/usr/bin/env bash
CONFDIR="${HOME}/.config/i3blocks"
if [ ! -d "$CONFDIR" ]; then
    mkdir -p "$CONFDIR"
fi

cp ./config "${CONFDIR}/config"
cp ./minimal-config "${CONFDIR}/minimal-config"
cp -r ./scripts "${CONFDIR}/scripts"
