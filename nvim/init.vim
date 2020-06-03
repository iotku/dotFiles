execute pathogen#infect()
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set cursorline " highlight current line

set background=dark
set termguicolors
colorscheme nightfly
syntax on
filetype plugin indent on
set autoindent
set nowrap

set incsearch 
set hlsearch

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set showcmd
set number
set showmatch

" disable annoying jedi docstring window
autocmd FileType python setlocal completeopt-=preview
let g:SuperTabDefaultCompletionType = "<c-n>"
