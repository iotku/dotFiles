local fn = vim.fn
local mapper = function(mode, key, result) -- Helpful keybinding function
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

-- Keybindings
vim.g.mapleader = ' '                                   -- Leader
mapper('n', '<esc>', '<cmd>noh<cr><esc>')               -- Clear Highlighting
mapper('n', '<C-p>', '<cmd>Telescope find_files<cr>')   -- Telescope
mapper('n', '<leader>ss', '<cmd>lua toggleSpell()<cr>') -- Toggle Spell Check
mapper('n', '<leader>k', '<cmd>NvimTreeToggle<cr>')     -- Open File browser Sidebar
mapper('n', '<leader>?', '<cmd>TroubleToggle<cr>')      -- Open Trouble Toggle Panel
mapper('n', '<leader>;', 'A;<esc>')                     -- add semicolon to end of line
mapper('n', '<leader>,', 'A,<esc>')                     -- add comma to end of the line
mapper('n', '<CR>', 'o<esc>cc')
mapper('n', '<leader>c', '<cmd>TSContextToggle<cr>')    -- Toggle treesitter-context
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
    use 'folke/tokyonight.nvim' -- Colorscheme
 --   use 'github/copilot.vim' -- nice meme
    use 'romgrk/nvim-treesitter-context'
    use 'lervag/vimtex'
    use 'vimwiki/vimwiki'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'ray-x/lsp_signature.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'windwp/windline.nvim'
    use "SmiteshP/nvim-gps"
    use 'windwp/nvim-autopairs'
    use {'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' },
        config = function() require'nvim-tree'.setup {} end
    }
    use 'tpope/vim-fugitive'
    use {'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup()
      end
    }
    use 'tpope/vim-rhubarb'
    use 'junegunn/gv.vim'
    use 'mfussenegger/nvim-dap'
    use 'simrat39/rust-tools.nvim'
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
    local_mapper('n', 'gr', '<cmd>TroubleToggle lsp_references<cr>')
    local_mapper('n', '<c-K>', '<cmd>lua vim.lsp.buf.hover()<CR>')
    local_mapper('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
end

-- Rust Tools for enhanced Rust LSP
require('rust-tools').setup({})

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'gopls', 'rust_analyzer', 'jdtls', 'clangd' }
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
vim.cmd[[colorscheme tokyonight]]

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
---- 

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

 cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x = 1, -- adjust float windows x position.
  floating_window_off_y = 1, -- adjust float windows y position.


  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = false, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

-- recommended:
require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

-- You can also do this inside lsp on_attach
-- note: on_attach deprecated
require'lsp_signature'.on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key
