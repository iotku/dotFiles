local fn = vim.fn
local mapper = function(mode, key, result) -- Helpful keybinding function
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

-- Keybindings
vim.g.mapleader = ' '                                   -- Leader
mapper('n', '<esc>', '<cmd>noh<cr><esc>')               -- Clear Highlighting
mapper('n', '<C-p>', '<cmd>Telescope find_files<cr>')   -- Telescope
mapper('n', '<leader>ss', '<cmd>lua toggleSpell()<cr>') -- Toggle Spell Check
mapper('n', '<leader>k', '<cmd>CHADopen<cr>')           -- Open File browser Sidebar
mapper('n', '<leader>?', '<cmd>TroubleToggle<cr>')      -- Open Trouble Toggle Panel
mapper('n', '<leader>;', 'A;<esc>')                     -- add semicolon to end of line

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
    use 'lervag/vimtex'
    use 'vimwiki/vimwiki'
    use {'ms-jpq/coq_nvim', branch = 'coq'}
    use 'ms-jpq/coq.artifacts'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'windwp/windline.nvim'
    use 'windwp/nvim-autopairs'
    use 'navarasu/onedark.nvim'
    use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps'}
    use 'mhinz/vim-signify'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'junegunn/gv.vim'
--    use 'mfussenegger/nvim-dap'
    use 'neovim/nvim-lspconfig'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'lewis6991/spellsitter.nvim',  config = function() require('spellsitter').setup() end}
    use 'nvim-lua/lsp-status.nvim'
    use 'nvim-lua/plenary.nvim' -- required by telescope
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use 'romgrk/barbar.nvim'
    -- Trouble Toggle
    use {"folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() 
            require("trouble").setup {} 
        end
    }
end)
-- vimtex
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.opt.conceallevel = 2

-- Signify settings
vim.g.signify_sign_change = '~'
vim.o.updatetime = 100

-- Autopairs
-- recommended settings when using coq with autopairs
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false })

vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

-- Statusline (windline.nvim)
require('wlsample.evil_line')

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
--
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {"latex"},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
--
-- LSP Stuff
--
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
vim.g.onedark_style = 'deep'
require('onedark').setup()
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
