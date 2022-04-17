#!/bin/bash
set -eo pipefail
DISTRO=$(cat /etc/os-release | grep "ID=" | head -n1)
function main {
    _header "Checking/Installing treesitter dependencies"

    if [[ "$DISTRO" == "ID=arch" ]]; then
        pacman -Q gcc 1> /dev/null
        if [[ $? == 0 ]]; then
            depFound "gcc"
        else     
            echo "Installing gcc for treesitter"
            sudo pacman -S gcc
        fi
    elif [[ "$DISTRO" == "ID=fedora" ]]; then
        if [[ "$(rpm -qa gcc-c++)" != "" ]] && [[ "$(rpm -qa libstdc++-static)" != "" ]]; then
            depFound "gcc"
        else
            echo "Installing gcc and libstdc++-static for treesitter" &&
            sudo dnf install gcc-c++ libstdc++-static
        fi
    fi


    _header "Checking Dependencies"
    DEPS=("curl" "tar" "go" "rustc" "java" "lua")
    for v in "${DEPS[@]}"; do
        checkDep "$v"
    done

    which rustup 1>/dev/null && _header "Syncing Rustup" && rustup update || echo "[NOTE] rustup not installed. Assuming system rust."
    echo -e "\n[PASS] Runtimes are installed.\n"

    if [ ! -d "${HOME}/.local/bin" ]; then
        echo "Creating ~/.local/bin"
        echo "Ensure it is in your PATH"
        mkdir -p ~/.local/bin
    fi

    # gopls
    _header "Installing gopls"
    go install golang.org/x/tools/gopls@latest && installSuccess "gopls" || installFail "gopls"

    _header "Installing delve"
    go install github.com/go-delve/delve/cmd/dlv@latest && installSuccess "delve" || installFail "delve"
    # rust-analyzer
    _header "Installing rust-analyzer"
    curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | 
        gunzip -c - > ~/.local/bin/rust-analyzer && chmod +x ~/.local/bin/rust-analyzer && installSuccess "rust-analyzer" || installFail "rust-analyzer"

    # jdtls
    _header "Installing jdtls"
    mkdir -p ~/.local/share/jdtls
    curl https://download.eclipse.org/jdtls/milestones/1.9.0/jdt-language-server-1.9.0-202203031534.tar.gz > ~/.local/share/jdtls/jdt-language-server-1.9.0-202203031534.tar.gz &&
    pushd ~/.local/share/jdtls/ 1>/dev/null && tar xf jdt-language-server-1.9.0-202203031534.tar.gz
    rm jdt-language-server-1.9.0-202203031534.tar.gz && popd 1>/dev/null || installFail "jdtls"
}

function depNotFound {
    echo "Attempting to install dependency $1"
    case "$DISTRO" in
        "ID=arch")
            archInstallPkg "$1"
            ;;
        "ID=fedora")
            fedoraInstallPkg "$1"
            ;;
    esac
    which "$1" 1>/dev/null || echo -e "\033[0;31m[FATAL] Cannot find $1: ensure $1 is installed\033[0m"
}

function fedoraInstallPkg {
    declare -A fedoraNames
    fedoraNames[java]="java-latest-openjdk"
    fedoraNames[rustc]="rust"

    if [[ fedoraNames["$1"] != "" ]]; then
        sudo dnf install "${fedoraNames[$1]}"
    else 
        sudo dnf install "$1"
    fi
}

function archInstallPkg {
    declare -A archNames
    archNames[java] = "jre-openjdk"
    archNames[rustc] = "rust"

    if [[ archNames["$1"] != "" ]]; then
        sudo pacman -S "${archNames[$1]}"
    else
        sudo pacman -S $1
    fi
}

function depFound {
    echo -e "\033[0;32m[OK]\033[0m Found $*"
}

function installFail {
    echo -e "\033[0;31mFailed to install $1"
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

main;
