#!/bin/bash
CONFDIR="${HOME}/.config/i3"
if [ ! -d "$CONFDIR" ]; then
    mkdir -p "$CONFDIR"
fi

cp ./config "${CONFDIR}/config"

