#!/bin/bash
if [ ! -f ${HOME}/.vim/autoload/pathogen.vim ]; then
   mkdir -p ~/.vim/autoload ~/.vim/bundle &&
   curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim 
fi
cp "./vimrc" "${HOME}/.vimrc"
git clone https://github.com/trusktr/seti.vim ${HOME}/.vim/bundle/seti.vim
git clone https://github.com/terryma/vim-multiple-cursors.git ${HOME}/.vim/bundle/vim-multiple-cursors
