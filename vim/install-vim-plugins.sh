#!/bin/bash
if [ ! -f ${HOME}/.vim/autoload/pathogen.vim ]; then
   mkdir -p ~/.vim/autoload ~/.vim/bundle &&
   curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim 
fi
cp "./vimrc" "${HOME}/.vimrc"
git clone --depth=1 https://github.com/rust-lang/rust.vim.git ${HOME}/.vim/bundle/rust.vim
git clone --depth=1 https://github.com/trusktr/seti.vim ${HOME}/.vim/bundle/seti.vim
git clone --depth=1 https://github.com/bling/vim-airline.git ${HOME}/.vim/bundle/vim-airline
git clone --depth=1 https://github.com/terryma/vim-multiple-cursors.git ${HOME}/.vim/bundle/vim-multiple-cursors
