#!/bin/bash
set -eo pipefail
function depNotFound {
    echo -e "\033[0;31m[FATAL] Cannot find $1: ensure $1 is installed\033[0m"
    exit
}

function depFound {
    echo -e "[OK] Found $*"
}

function installFail {
    echo -e "\033[0;31mFailed to install $1"
}

function installSuccess {
    echo -e "[DONE] $*"
}

function _header {
    echo -e "\e[1m\e[4m$*\e[0m"
}

_header "Checking/Installing treesitter dependencies"
DISTRO=$(cat /etc/os-release | grep "ID=" | head -n1)
if [[ "$DISTRO" == "ID=arch" ]]; then
    pacman -Q gcc 1> /dev/null
    [[ $? == 0 ]] && depFound "gcc" || echo "Installing gcc for treesitter" sudo pacman -S gcc
elif [[ "$DISTRO" == "ID=fedora" ]]; then
    [[ "$(rpm -qa gcc-c++)" == "" ]] && [[ "$(rpm -qa libstdc++-static)" == "" ]] && depFound "gcc" || 
        echo "Installing gcc and libstdc++-static for treesitter" &&
        sudo dnf install gcc-c++ libstdc++-static
fi

_header "Checking for language runtimes"
which go 1>/dev/null && depFound "go" || depNotFound "go"
which rustc 1>/dev/null && depFound "rustc"  || depNotFound "rustc"
which java 1>/dev/null && depFound "java" || depNotFound "java"

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
