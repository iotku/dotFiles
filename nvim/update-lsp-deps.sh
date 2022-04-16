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

function _header {
    echo -e "\e[1m\e[4m$*\e[0m"
}

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

go install golang.org/x/tools/gopls@latest || installFail "gopls"
echo -e "done.\n"
# rust-analyzer
_header "Installing rust-analyzer"
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer || installFail "rust-analyzer"
chmod +x ~/.local/bin/rust-analyzer
echo -e "done.\n"

# jdtls
_header "Installing jdtls"
mkdir -p ~/.local/share/jdtls
curl https://download.eclipse.org/jdtls/milestones/1.9.0/jdt-language-server-1.9.0-202203031534.tar.gz > ~/.local/share/jdtls/jdt-language-server-1.9.0-202203031534.tar.gz || installFail "jdtls"
pushd ~/.local/share/jdtls/ 1>/dev/null
tar xf jdt-language-server-1.9.0-202203031534.tar.gz
rm jdt-language-server-1.9.0-202203031534.tar.gz
popd 1>/dev/null
