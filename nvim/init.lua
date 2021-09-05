vim.cmd('source ~/.config/nvim/old.vim')

-- Golang LSP (gopls)
local mapper = function(mode, key, result)
    vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

local goBind = function(client)
    mapper('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
end

require'lspconfig'.gopls.setup({
    on_attach = goBind
})

-- Colorscheme Settings
vim.opt.termguicolors = true    -- True color support
vim.cmd('colorscheme nightfly') -- Set theme

-- Appearance
vim.opt.wrap           = false     -- wrap long lines of text
vim.opt.cursorline     = true      -- highlight current line
vim.opt.colorcolumn    = {80, 100} -- set rulers
---- Line numbers
vim.opt.number         = true  -- show line numbers
vim.opt.relativenumber = true  -- line numbers are relative to current position
---- Tabline
vim.opt.laststatus     = 2      -- always display the statusline in all windows
vim.opt.showtabline    = 2      -- always display the tabline, even if there is only one tab
vim.opt.showmode       = false  -- hide the default mode text (e.g. -- INSERT -- below the statusline)

-- Editing
vim.opt.smartindent = true
---- Spell checking
vim.opt.spell       = true
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
