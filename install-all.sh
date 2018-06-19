#!/bin/bash
function confInstall() {
    echo "Running ${1} Install..."
    (cd "$1" && "./install-${1}.sh")
}

confInstall vim
confInstall i3
confInstall xorg
confInstall zsh
confInstall termite

