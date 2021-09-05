" Plug plugin system
call plug#begin('~/.config/nvim/plugged')
Plug 'Yggdroot/indentLine'
Plug 'davidhalter/jedi-vim'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
"Plug 'fatih/vim-go'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mfussenegger/nvim-dap'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
" Initialize plugin system
call plug#end()
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <c-space> coc#refresh()
let g:lightline = { 'colorscheme': 'nightfly' }
let g:indentLine_color_gui = '#1B3B55'

nnoremap <esc> :noh<cr><esc>
set showcmd

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

" Tab/shiftTab indending/deinting
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
