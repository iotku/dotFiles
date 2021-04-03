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
set smartindent
set nowrap

set incsearch 
set hlsearch
nnoremap <esc> :noh<cr><esc>
" Tab settings
set tabstop=4
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

set omnifunc=syntaxcomplete#Complete
"let g:SuperTabLeadingSpaceCompletion = 0
"let g:SuperTabClosePreviewOnPopupClose = 1
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabDefaultCompletionType = "<c-n>"
autocmd FileType java setlocal omnifunc=javacomplete#Complete

set completeopt-=preview
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:deoplete#enable_at_startup = 1
" Pasting for genovim
nnoremap <S-Insert> a<C-r>+<Esc>
inoremap <S-Insert> <C-r>+
cnoremap <S-Insert> <C-r>+

" Tab/shiftTab indending/deinting
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

let g:indentLine_color_gui = '#1B3B55'
