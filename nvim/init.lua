local fn = vim.fn
local mapper = function(mode, key, result) -- Helpful keybinding function
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

-- Keybindings
vim.g.mapleader = ' '                                   -- Leader
mapper('n', '<esc>', '<cmd>noh<cr><esc>')               -- Clear Highlighting
mapper('n', '<C-p>', '<cmd>Telescope find_files<cr>')   -- Telescope
mapper('n', '<leader>ss', '<cmd>lua toggleSpell()<cr>') -- Toggle Spell Check
mapper('n', '<leader>k', '<cmd>NvimTreeToggle<cr>')           -- Open File browser Sidebar
mapper('n', '<leader>?', '<cmd>TroubleToggle<cr>')      -- Open Trouble Toggle Panel
mapper('n', '<leader>;', 'A;<esc>')                     -- add semicolon to end of line
mapper('n', '<leader>c', '<cmd>TSContextToggle<cr>')    --  Toggle treesitter-context
---- Tab/shiftTab indent/unindent
mapper('n', '<Tab>', '>>_')
mapper('n', '<S-Tab>', '<<_')
mapper('v', '<Tab>', '>gv')
mapper('v', '<S-Tab>', '<gv')
---- Terminal
mapper('n', '<leader>t', '<cmd>sp<CR><cmd>te<CR>a') -- Open terminal in horizontal split
mapper('t', '<Esc>', '<C-Bslash><C-n>')             -- Go back to normal mode

-- Bootstrap Packer (Package Management) -- Remember to :PackerInstall
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Packages
require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Packception
 --   use 'github/copilot.vim' -- nice meme
    use 'romgrk/nvim-treesitter-context'
    use 'lervag/vimtex'
    use 'vimwiki/vimwiki'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'lukas-reineke/indent-blankline.nvim'
    use 'windwp/windline.nvim'
    use "SmiteshP/nvim-gps"
    use 'windwp/nvim-autopairs'
    use 'navarasu/onedark.nvim'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function() require'nvim-tree'.setup {} end
    }
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

-- cmp completion
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

local local_mapper = function(mode, key, result) -- Helpful keybinding function
    vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

local setLspBindings = function(client)
    local_mapper('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    local_mapper('n', '<F6>', '<cmd>lua vim.lsp.buf.rename()<CR>')
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'gopls', 'rust_analyzer', 'jdtls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = setLspBindings,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
require('nvim-autopairs').setup{}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Statusline (windline.nvim)
require("nvim-gps").setup()
require('iotku-evil-wl')

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

-- Colorscheme Settings
vim.opt.termguicolors = true    -- True color support
require('onedark').setup {
    style = 'darker',
    toggle_style_key = '<leader>st'
}
require('onedark').load()


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

-- Context
require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    throttle = true, -- Throttles plugin updates (may improve performance)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
        },
        -- Example for a specific filetype.
        --   rust = {
        --       'impl_item',
        --   },
    },
}
-- Experimental
-- Possible workaround for github copilot completion
-- See https://www.reddit.com/r/neovim/comments/r6ppfl/how_do_remap_copilotaccept_in_a_lua_function/
-- local function complete()
--   return function ()
--     if cmp.visible() then
--       cmp.mapping.confirm({select = true})()
--     else
--       vim.api.nvim_feedkeys(fn['copilot#Accept'](), 'i', true)
--     end
--   end
-- end
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_refresh_rate = 60
vim.o.guifont = "JetBrainsMono Nerd Font:h20"

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

