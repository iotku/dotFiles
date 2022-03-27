require('packages')
require('keybindings')
require('completion')
require('context')
require('lsp')
require('gui-settings')
require('iotku-evil-wl') -- Statusline (windline.nvim)
require('go').setup{}
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
-- Appearance
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
vim.opt.smartindent = true
---- Spell checking 
local spellOn = false -- spell on by default?
function toggleSpell()
    spellOn = not spellOn
    vim.opt.spell = spellOn
end
    
vim.opt.spell       = spellOn
vim.opt.spelllang   = "en_us,es"

-- Tab settings
local indent = 4 -- How much to indent on tabs
vim.opt.tabstop     = indent
vim.opt.softtabstop = indent
vim.opt.shiftwidth  = indent
vim.opt.expandtab   = true
vim.opt.smarttab    = true

-- Misc
vim.opt.swapfile  = false

-- vimtex
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.opt.conceallevel = 2

-- Colorscheme Settings
vim.opt.termguicolors = true    -- True color support
vim.cmd[[colorscheme tokyonight]]
