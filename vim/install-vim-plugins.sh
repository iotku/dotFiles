#!/bin/bash
if [ ! -f ${HOME}/.vim/autoload/pathogen.vim ]; then
   mkdir -p ~/.vim/autoload ~/.vim/bundle &&
   curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim 
fi
cp "./vimrc" "${HOME}/.vimrc"
git clone --recursive --depth=1 https://github.com/davidhalter/jedi-vim.git ${HOME}/.vim/bundle/jedi-vim
git clone --recursive --depth=1 https://github.com/nanotech/jellybeans.vim.git ${HOME}/.vim/bundle/jellybeans.vim
git clone --recursive --depth=1 https://github.com/rust-lang/rust.vim.git ${HOME}/.vim/bundle/rust.vim
git clone --recursive --depth=1 https://github.com/ervandew/supertab.git ${HOME}/.vim/bundle/supertab
git clone --recursive --depth=1 https://github.com/bling/vim-airline.git ${HOME}/.vim/bundle/vim-airline
git clone --recursive --depth=1 https://github.com/terryma/vim-multiple-cursors.git ${HOME}/.vim/bundle/vim-multiple-cursors
