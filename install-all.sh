#!/bin/bash
function confInstall() {
    echo "Running ${1} Install..."
    (cd "$1" && "./install-${1}.sh")
}

confInstall nvim
confInstall zsh
confInstall i3
confInstall i3blocks
confInstall termite
