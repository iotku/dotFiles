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

    which rustup 1>/dev/null && _header "Syncing Rustup" && rustup update stable || echo "[NOTE] rustup not installed. Assuming system rust."
    echo -e "\n[PASS] Runtimes are installed.\n"

    if [ ! -d "${HOME}/.local/bin" ]; then
        echo "Creating ~/.local/bin"
        echo "Ensure it is in your PATH"
        mkdir -p ~/.local/bin
    fi

    # gopls
    function _goInstall {
        echo "[START]: go install $1"
        go install "$1" && installSuccess "$1" || installFail "$1"
    }
    _header "Installing go tools"
    _goInstall "golang.org/x/tools/...@latest"
    _goInstall "github.com/koron/iferr@latest"
    _goInstall "github.com/josharian/impl@v1.1.0"
    _goInstall "golang.org/x/tools/gopls@latest"
    _goInstall "mvdan.cc/gofumpt@latest"
    _goInstall "github.com/fatih/gomodifytags@v1.16.0"
    _goInstall "github.com/golangci/golangci-lint/cmd/golangci-lint@v1.45.2"
    _goInstall "github.com/segmentio/golines@latest"
    _goInstall "github.com/davidrjenni/reftools/cmd/fixplurals@latest"
    _goInstall "github.com/davidrjenni/reftools/cmd/fillswitch@latest"
    _goInstall "github.com/davidrjenni/reftools/cmd/fillstruct@latest"
    _goInstall "github.com/onsi/ginkgo/v2/ginkgo@latest"
    _goInstall "github.com/cweill/gotests/gotests@latest"
    _goInstall "github.com/kyoh86/richgo@latest"

    _header "Installing delve"
    go install github.com/go-delve/delve/cmd/dlv@latest && installSuccess "delve" || installFail "delve"
    # rust-analyzer
    _header "Installing rust-analyzer"
    curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | 
        gunzip -c - > ~/.local/bin/rust-analyzer && chmod +x ~/.local/bin/rust-analyzer && installSuccess "rust-analyzer" || installFail "rust-analyzer"

# TODO: lua_ls
#    _header "Installing lua-language-server"
#    mkdir -p ~/.local/share/lua-language-server
#    curl -L "https://github.com/sumneko/lua-language-server/releases/download/3.5.6/lua-language-server-3.5.6-linux-x64.tar.gz" > ~/.local/share/lua-language-server/lua-language-server.tar.gz &&
#        pushd ~/.local/share/lua-language-server 1>/dev/null && tar xf lua-language-server.tar.gz &&
#        ln -s "${HOME}/.local/share/lua-language-server/bin/lua-language-server" "${HOME}/.local/bin" &&
#    rm lua-language-server.tar.gz && popd 1>/dev/null && installSuccess "lua-language-server" || installFail "lua-language-server"

    # jdtls
    _header "Installing jdtls"
    mkdir -p ~/.local/share/jdtls
    JDTLS="jdt-language-server-1.21.0-202303161431.tar.gz"
    curl "https://download.eclipse.org/jdtls/milestones/1.21.0/$JDTLS" > ~/.local/share/jdtls/$JDTLS &&
    pushd ~/.local/share/jdtls/ 1>/dev/null && tar xf "$JDTLS" &&
    rm "$JDTLS" && popd 1>/dev/null || installFail "jdtls"
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
    if ! command -v $1 &> /dev/null; then
	echo -e "\033[0;31m[FATAL] Cannot find $1: ensure $1 is installed\033[0m"
    exit
    fi
}

function fedoraInstallPkg {
    declare -A fedoraNames
    fedoraNames[java]="java-latest-openjdk"
    fedoraNames[rustc]="rust"
    fedoraNames[go]="golang"

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

main;
