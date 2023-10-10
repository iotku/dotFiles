--local fn = vim.fn --needed still after upgrading from packer?

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
      {"folke/which-key.nvim",
          event = "VeryLazy",
          init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
          end,
      opts = {}},
    { "folke/neoconf.nvim", cmd = "Neoconf" },

    -- Appearance/Bars
    "folke/tokyonight.nvim",
    -- "xiyaowong/nvim-transparent",
    "ntpeters/vim-better-whitespace",
    "lukas-reineke/indent-blankline.nvim",
    "windwp/nvim-autopairs",
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    {"nvim-lualine/lualine.nvim",
          dependencies = {
            'nvim-tree/nvim-web-devicons',
            'linrongbin16/lsp-progress.nvim',
        }},
    "gelguy/wilder.nvim", -- Does this actually init correctly without the config block?

    -- Completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cm
    "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
    "L3MON4D3/LuaSnip",         -- Snippets plugin

    -- Language/LSP Support
    "neovim/nvim-lspconfig",
    "ray-x/lsp_signature.nvim",
    "nvim-lua/lsp-status.nvim",
    "ray-x/go.nvim",
    "simrat39/rust-tools.nvim",
    "mfussenegger/nvim-jdtls",
    "SmiteshP/nvim-navic",
    "kosayoda/nvim-lightbulb",
    {"linrongbin16/lsp-progress.nvim",
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('lsp-progress').setup()
      end},
    "folke/neodev.nvim",
    "folke/todo-comments.nvim",
    "folke/trouble.nvim",

    -- DAP (Debug Adapter Protocol)
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "leoluz/nvim-dap-go",

    -- TS
    "nvim-treesitter/nvim-treesitter",
    "norcalli/nvim-colorizer.lua",
    "nvim-lua/plenary.nvim", -- required by telescope
    -- git
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "junegunn/gv.vim",

    -- Fuzzy Finding
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    -- Notetaking / Wiki
    "lervag/vimtex",
    "vimwiki/vimwiki",
})
