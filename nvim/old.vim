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

" Change leader to comma
let mapleader=","

set autochdir " Automatically cd to dir where file is.
" Show Nerdtree
noremap <Leader>k :NERDTreeToggle<CR>
