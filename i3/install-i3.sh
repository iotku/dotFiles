#!/usr/bin/env bash
CONFDIR="${HOME}/.config/i3"
if [ ! -d "$CONFDIR" ]; then
    mkdir -p "$CONFDIR"
fi

cp ./config "${CONFDIR}/config"
cp ./lock-screen.sh "${CONFDIR}/"
