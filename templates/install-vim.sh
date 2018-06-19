#!/bin/bash
if [ ! -f ${HOME}/.vim/autoload/pathogen.vim ]; then
   mkdir -p ~/.vim/autoload ~/.vim/bundle
   curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

cp "./vimrc" "${HOME}/.vimrc"

function installGitPackage() {
    # $1 githuburl $2 path $3 fancy name
    # If directory already exists, git pull
    if [ ! -f "$2" ]; then
        echo "Checking for updates for $3"
        (cd "$2" && git pull)
    else
        echo "Cloning $3"
        git clone --recursive --depth=1 "$1" "$2"
    fi
}
