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
noremap <esc> :noh<cr> " clear hl with esc

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

set colorcolumn=80,100 " Set rulers
" disable annoying jedi docstring window
autocmd FileType python setlocal completeopt-=preview

let g:SuperTabDefaultCompletionType = "<c-n>"

" Change leader to comma
let mapleader=","
let g:any_jump_search_prefered_engine = 'ag'
" Ctags Stuff
set tags=tags,./tags

noremap <Leader>c :!cd %:p:h && ctags -R *.java 
" Multi cursors
let g:VM_mouse_mappings = 1

set autochdir " Automatically cd to dir where file is.
" Show Nerdtree
noremap <Leader>k :NERDTreeToggle<CR>

" Launch terminal in split window
noremap <leader>t :sp<CR>:te<CR>
if has ("win32")
    set shell=pwsh.exe
endif
