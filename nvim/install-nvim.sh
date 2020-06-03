#!/bin/bash
if [ ! -f ${HOME}/.local/share/nvim/site/autoload/pathogen.vim ]; then
   mkdir -p ~/.local/share/nvim/site/autoload/ ~/.config/nvim/bundle
   curl -LSso ~/.local/share/nvim/site/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

cp "./init.vim" "${HOME}/.config/nvim/init.vim"

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

cp "./init.vim" "${HOME}/.config/nvim/init.vim"
installGitPackage https://github.com/davidhalter/jedi-vim.git ${HOME}/.config/nvim/bundle/jedi-vim jedi-vim
installGitPackage https://github.com/nanotech/jellybeans.vim.git ${HOME}/.config/nvim/bundle/jellybeans.vim jellybeans.vim
installGitPackage https://github.com/rust-lang/rust.vim.git ${HOME}/.config/nvim/bundle/rust.vim rust.vim
installGitPackage https://github.com/ervandew/supertab.git ${HOME}/.config/nvim/bundle/supertab supertab
installGitPackage https://github.com/bling/vim-airline.git ${HOME}/.config/nvim/bundle/vim-airline vim-airline
installGitPackage https://github.com/terryma/vim-multiple-cursors.git ${HOME}/.config/nvim/bundle/vim-multiple-cursors vim-multiple-cursors
installGitPackage https://github.com/bluz71/vim-nightfly-guicolors.git ${HOME}/.config/nvim/bundle/vim-nightfly-guicolors vim-nightfly-guicolors
