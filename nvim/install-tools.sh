#!/bin/bash
set -eo pipefail
DISTRO=$(cat /etc/os-release | grep "ID=" | head -n1)
goPKGS=()
function main {
    _header "Checking Dependencies"
    DEPS=("gcc" "curl" "tar" "go" "rustup" "java" "lua")
    for v in "${DEPS[@]}"; do
        checkDep "$v"
    done

    which rustup 1>/dev/null && _header "Syncing Rustup" && rustup update stable || installFail "rustup"
    echo -e "\n[PASS] Runtimes are installed.\n"

    function _goInstall {
        goPKGS+=("$1")
    }
    _header "Installing go tools"
    _goInstall "golang.org/x/tools/...@latest"
    _goInstall "github.com/koron/iferr@latest"
    _goInstall "github.com/josharian/impl@v1.1.0"
    _goInstall "golang.org/x/tools/gopls@latest"
    _goInstall "mvdan.cc/gofumpt@latest"
    _goInstall "github.com/fatih/gomodifytags@v1.16.0"
    _goInstall "github.com/golangci/golangci-lint/cmd/golangci-lint@v1.61.0"
    _goInstall "github.com/segmentio/golines@latest"
    _goInstall "github.com/davidrjenni/reftools/cmd/fixplurals@latest"
    _goInstall "github.com/davidrjenni/reftools/cmd/fillswitch@latest"
    _goInstall "github.com/davidrjenni/reftools/cmd/fillstruct@latest"
    _goInstall "github.com/onsi/ginkgo/v2/ginkgo@latest"
    _goInstall "github.com/cweill/gotests/gotests@latest"
    _goInstall "github.com/kyoh86/richgo@latest"
    _goInstall "github.com/go-delve/delve/cmd/dlv@latest"
    printf "%s\n" "${goPKGS[@]}" | xargs -P$(nproc) -I {} bash -c 'echo "[START]: go install {}"; go install "{}" && echo "[END]: {}" || echo "[ERROR]: {}"'
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
