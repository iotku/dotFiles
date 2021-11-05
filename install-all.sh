#!/usr/bin/env bash
function confInstall() {
    echo "Running ${1} Install..."
    (cd "$1" && "./install-${1}.sh")
}

confInstall nvim
confInstall zsh
confInstall kitty
confInstall i3
confInstall i3blocks
