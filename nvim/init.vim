" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/davidhalter/jedi-vim.git'
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/preservim/nerdtree.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/fatih/vim-go.git'
Plug 'https://github.com/bluz71/vim-nightfly-guicolors.git'
" Initialize plugin system
call plug#end()


syntax on " Syntax Hilighting
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set cursorline " highlight current line
set noswapfile
set background=dark
set termguicolors
colorscheme nightfly
let g:lightline = { 'colorscheme': 'nightfly' }
filetype plugin indent on
set autoindent
set smartindent
set nowrap

set incsearch 
set hlsearch
nnoremap <esc> :noh<cr><esc>
" Tab settings
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set showcmd
set spell " spell checking
set spelllang=en_us,es
set number                     " Show current line number
set relativenumber             " Show relative line numbers

set colorcolumn=80,100 " Set rulers

" Change leader to comma
let mapleader=","

set autochdir " Automatically cd to dir where file is.
" Show Nerdtree
noremap <Leader>k :NERDTreeToggle<CR>

" Launch terminal in split window
noremap <leader>t :sp<CR>:te<CR>
" Map shift+space/bs to just space/bs in terminal
tnoremap <s-space> <space>
tnoremap <s-bs> <bs>

" Allow escape to exit to normal mode.
tnoremap <Esc> <C-\><C-n>
if has ("win32")
  		set shell=pwsh
		set shellquote= shellpipe=\| shellxquote=
		set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
		set shellredir=\|\ Out-File\ -Encoding\ UTF8
endif
filetype plugin on

" Tab/shiftTab indending/deinting
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

let g:indentLine_color_gui = '#1B3B55'


