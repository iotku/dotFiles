local fn = vim.fn
local mapper = function(mode, key, result) -- Helpful keybinding function
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

-- Keybindings
vim.g.mapleader = ' '                                  -- Leader
mapper('n', '<esc>', '<cmd>noh<cr><esc>')              -- Clear Highlighting
mapper('n', '<C-p>', '<cmd>Telescope find_files<cr>')  -- Telescope
mapper('n', '<leader>ss', '<cmd>lua toggleSpell()<cr>')
mapper('n', '<leader>k', '<cmd>CHADopen<cr>')
mapper('n', '<leader>?', '<cmd>TroubleToggle<cr>')

---- Tab/shiftTab indent/unindent
mapper('n', '<Tab>', '>>_')
mapper('n', '<S-Tab>', '<<_')
mapper('v', '<Tab>', '>gv')
mapper('v', '<S-Tab>', '<gv')

---- Terminal
mapper('n', '<leader>t', '<cmd>sp<CR><cmd>te<CR>a') -- Open terminal in horizontal split
mapper('t', '<Esc>', '<C-Bslash><C-n>')     -- Go back to normal mode

-- Bootstrap Packer (Package Management) -- Remember to :PackerInstall
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Packages
require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Packception
    use 'vimwiki/vimwiki'
    use 'jiangmiao/auto-pairs'
 --   use {'neoclide/coc.nvim', branch = 'release'}
    use {'ms-jpq/coq_nvim', branch = 'coq'}
    use 'ms-jpq/coq.artifacts'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'itchyny/lightline.vim'
    use 'ayu-theme/ayu-vim'
    use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps'}
    use 'airblade/vim-gitgutter'
--    use 'mfussenegger/nvim-dap'
    use 'neovim/nvim-lspconfig'
--    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
--    use {'lewis6991/spellsitter.nvim',  config = function() require('spellsitter').setup() end}
    use 'nvim-lua/lsp-status.nvim'
    use 'nvim-lua/plenary.nvim' -- required by telescope
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

    -- Trouble Toggle
    use {"folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() 
            require("trouble").setup {} 
        end
    }
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

-- treesitter
--[[
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
--]]
local lsp = require "lspconfig"
-- Coq Completion
vim.g.coq_settings = { auto_start = "shut-up" }
local coq = require "coq" -- add this
-- Golang LSP (gopls)
local local_mapper = function(mode, key, result) -- Helpful keybinding function
    vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end
local setLspBindings = function(client)
    local_mapper('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
end
lsp.gopls.setup({
    on_attach = setLspBindings
})

-- Java LSP (jdtls)
lsp.jdtls.setup{
    cmd = { 'jdtls' },
    on_attach = setLspBindings
}

-- Colorscheme Settings
vim.opt.termguicolors = true    -- True color support
vim.cmd('colorscheme ayu') -- Set theme
vim.g.lightline = {colorscheme = 'ayu_dark'}
vim.g.ayucolor="dark" 

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
