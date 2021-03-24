execute pathogen#infect()
syntax on " Syntax Hilighting
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set cursorline " highlight current line

set background=dark
set t_Co=256
set termguicolors
colorscheme nightfly
let g:lightline = { 'colorscheme': 'nightfly' }
filetype plugin indent on
set autoindent
set nowrap

set incsearch 
set hlsearch

" Tab settings
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set showcmd
set number
set showmatch

set number                     " Show current line number
set relativenumber             " Show relative line numbers

" disable annoying jedi docstring window
autocmd FileType python setlocal completeopt-=preview
let g:SuperTabDefaultCompletionType = "<c-n>"
