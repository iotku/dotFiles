#!/bin/bash
CONFDIR="${HOME}/.config/termite"
if [ ! -d "$CONFDIR" ]; then
    mkdir -p "$CONFDIR"
fi

cp ./config "${CONFDIR}/config"

