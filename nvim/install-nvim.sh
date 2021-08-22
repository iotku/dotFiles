#!/bin/bash
if [ ! -f ${HOME}/.local/share/nvim/site/autoload/pathogen.vim ]; then
   mkdir -p ~/.local/share/nvim/site/autoload/ ~/.config/nvim/bundle
   curl -LSso ~/.local/share/nvim/site/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

cp "./init.vim" "${HOME}/.config/nvim/init.vim"
cp "./ginit.vim" "${HOME}/.config/nvim/ginit.vim"

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

installGitPackage https://github.com/Yggdroot/indentLine ${HOME}/.config/nvim/bundle/indentLine indentLine
installGitPackage https://github.com/davidhalter/jedi-vim.git ${HOME}/.config/nvim/bundle/jedi-vim jedi-vim
installGitPackage https://github.com/itchyny/lightline.vim ${HOME}/.config/nvim/bundle/lightline.vim lightline.vim
installGitPackage https://github.com/preservim/nerdtree.git ${HOME}/.config/nvim/bundle/nerdtree nerdtree
installGitPackage https://github.com/airblade/vim-gitgutter.git ${HOME}/.config/nvim/bundle/vim-gitgutter vim-gitgutter
installGitPackage https://github.com/fatih/vim-go.git ${HOME}/.config/nvim/bundle/vim-go vim-go
installGitPackage https://github.com/bluz71/vim-nightfly-guicolors.git ${HOME}/.config/nvim/bundle/vim-nightfly-guicolors vim-nightfly-guicolors
