#!/usr/bin/env bash
CONFDIR="${HOME}/.emacs.d"
if [ ! -d "$CONFDIR" ]; then
    mkdir -p "$CONFDIR"
fi

cp "./init.el" "${CONFDIR}/init.el"

