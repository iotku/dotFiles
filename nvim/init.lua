-- disable netrw (recommended by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' ' -- Set the leader prior to seting up keybindings
require('packages')
require('keybindings')
require('statusline')
require('context')
require('lang')
require('lsp')
require('gui-settings')
require('autocmds')

-- Appearance
vim.cmd([[colorscheme tokyonight]])
vim.opt.wrap           = false     -- wrap long lines of text
vim.opt.cursorline     = true      -- highlight current line
vim.opt.colorcolumn    = {80, 100} -- set rulers
---- Line numbers
vim.opt.number         = true  -- show line numbers
vim.opt.relativenumber = true  -- line numbers are relative to current position
---- Tabline
vim.opt.laststatus     = 3      -- Display single "global" statusline
vim.opt.showtabline    = 2      -- always display the tabline, even if there is only one tab
vim.opt.showmode       = false  -- hide the default mode text (e.g. -- INSERT -- below the statusline)
-- Editing
vim.opt.smartindent = false -- use treesitter indent
vim.api.nvim_command('filetype indent off')
---- Spell checking
vim.opt.spell       = false
vim.opt.spelllang   = "en_us"
-- System Clipboard
vim.api.nvim_set_option("clipboard","unnamed")
-- Tab settings
local indent = 4 -- How much to indent on tabs
vim.opt.tabstop     = indent
vim.opt.softtabstop = indent
vim.opt.shiftwidth  = indent
vim.opt.expandtab   = true
vim.opt.smarttab    = true
vim.opt.listchars = { tab = '  →', trail = '•' } -- Listchars for set list (toggled by <leader>l)
vim.opt.list = true
-- Misc
vim.opt.swapfile   = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr   = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 1
vim.opt.timeoutlen = 500
-- vimtex
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.opt.conceallevel = 2
