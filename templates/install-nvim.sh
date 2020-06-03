#!/bin/bash
if [ ! -f ${HOME}/.local/share/nvim/site/autoload/pathogen.vim ]; then
   mkdir -p ~/.local/share/nvim/site/autoload/ ~/.config/nvim/bundle
   curl -LSso ~/.local/share/nvim/site/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

cp "./init.vim" "${HOME}/.config/nvim/init.vim"

function installGitPackage() {
    # $1 githuburl $2 path $3 fancy name
    # If directory already exists, git pull
    if [ -d "$2" ]; then
        echo "Checking for updates for $3"
        (cd "$2" && git pull)
    else
        echo "Cloning $3"
        git clone --recursive --depth=1 "$1" "$2"
    fi
}

