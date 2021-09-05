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
