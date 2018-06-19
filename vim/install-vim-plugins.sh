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

cp "./vimrc" "${HOME}/.vimrc"
installGitPackage https://github.com/davidhalter/jedi-vim.git ${HOME}/.vim/bundle/jedi-vim jedi-vim
installGitPackage https://github.com/nanotech/jellybeans.vim.git ${HOME}/.vim/bundle/jellybeans.vim jellybeans.vim
installGitPackage https://github.com/rust-lang/rust.vim.git ${HOME}/.vim/bundle/rust.vim rust.vim
installGitPackage https://github.com/ervandew/supertab.git ${HOME}/.vim/bundle/supertab supertab
installGitPackage https://github.com/bling/vim-airline.git ${HOME}/.vim/bundle/vim-airline vim-airline
installGitPackage https://github.com/terryma/vim-multiple-cursors.git ${HOME}/.vim/bundle/vim-multiple-cursors vim-multiple-cursors
