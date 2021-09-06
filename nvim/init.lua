vim.cmd('source ~/.config/nvim/old.vim')
local fn = vim.fn
local mapper = function(mode, key, result) -- Helpful keybinding function
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

-- Keybindings
mapper('n', '<esc>', ':noh<cr><esc>') -- Clear Highlighting
-- Tab/shiftTab indent/unindent
mapper('n', '<Tab>', '>>_')
mapper('n', '<S-Tab>', '<<_')
mapper('v', '<Tab>', '>gv')
mapper('v', '<S-Tab>', '<gv')
-- Terminal
mapper('n', '<leader>t', ':sp<CR>:te<CR>a') -- Open terminal in horizontal split
mapper('t', '<Esc>', '<C-Bslash><C-n>') -- Go back to normal mode
-- Bootstrap Packer (Package Management) -- Remember to :PackerInstall
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Packages
require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Packception
    use {'neoclide/coc.nvim', branch = 'release'}
    use 'lukas-reineke/indent-blankline.nvim'
    use 'itchyny/lightline.vim'
    use 'preservim/nerdtree'
    use 'airblade/vim-gitgutter'
--   use 'mfussenegger/nvim-dap'
    use 'bluz71/vim-nightfly-guicolors'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp-status.nvim'
    use 'nvim-lua/plenary.nvim' -- required by telescope
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
end)

-- Telescope Setup
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

require('telescope').load_extension('fzf') 

-- Golang LSP (gopls)
local local_mapper = function(mode, key, result) -- Helpful keybinding function
    vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end
local goBind = function(client)
    local_mapper('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
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
