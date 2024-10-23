#!/bin/bash
set -eo pipefail
goPKGS=()
function main {
    _header "Checking Dependencies"
    DEPS=("gcc" "curl" "tar" "go" "rustup" "java" "lua")
    for v in "${DEPS[@]}"; do
        checkDep "$v"
    done

    which rustup 1>/dev/null && _header "Syncing Rustup" && rustup update stable || installFail "rustup"
    echo -e "\n[PASS] Runtimes are installed.\n"
}

function depNotFound {
    if ! command -v $1 &> /dev/null; then
	echo -e "\033[0;31m[FATAL] Cannot find $1: ensure $1 is installed\033[0m"
    exit
    fi
}

function depFound {
    echo -e "\033[0;32m[OK]\033[0m Found $*"
}

function installFail {
    echo -e "\033[0;31mFailed to install $1"
    exit
}

function checkDep {
    which "$1" 1>/dev/null && depFound "$1" || depNotFound "$1"
}

function installSuccess {
    echo -e "\033[0;32m[DONE]\033[0m $*"
}

function _header {
    echo -e "\e[1m\e[4m$*\e[0m"
}

main
