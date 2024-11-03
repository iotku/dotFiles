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
    "folke/tokyonight.nvim", -- Colorscheme
    {"folke/which-key.nvim",
          event = "VeryLazy",
          init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
          end,
      opts = {}},
    -- Appearance/Bars
        -- "xiyaowong/nvim-transparent",
    "ntpeters/vim-better-whitespace",
 --   "lukas-reineke/indent-blankline.nvim",
    "windwp/nvim-autopairs",
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    {"nvim-lualine/lualine.nvim",
          dependencies = {
            'nvim-tree/nvim-web-devicons',
        }},

    "folke/neoconf.nvim",
    -- Language/LSP Support
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {"neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" }},
    "ray-x/lsp_signature.nvim",
    "nvim-lua/lsp-status.nvim",
    {"ray-x/go.nvim", ft="go",
        build = ':lua require("go.install").update_all_sync()'},
    {"simrat39/rust-tools.nvim", ft="rust"},
    {"mfussenegger/nvim-jdtls", lazy = true},
    "SmiteshP/nvim-navic",
--  "kosayoda/nvim-lightbulb", -- consier replacing with lspsaga.nvim
    {"linrongbin16/lsp-progress.nvim",
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      event = "VeryLazy",
      config = function()
        require('lsp-progress').setup()
      end},

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        -- load cmp on InsertEnter
        event = "InsertEnter",
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-nvim-lua",
          "L3MON4D3/LuaSnip",         -- Snippets plugin
          "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
        },
        config = function()
            require('completion')
        end,
    },

    {"folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            highlight = {
                exclude = { "java" },
	    }
        }},
    {"folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    },
    -- DAP (Debug Adapter Protocol)
    {"rcarriga/nvim-dap-ui",
    	dependencies = {
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
        },
        keys = {
                {'<F5>', '<cmd>lua require"dap".continue()<CR>'},
                {'<F10>', '<cmd>lua require"dap".stop_over()<CR>'},
                {'<F11>', '<cmd>lua require"dap".step_into()<CR>'},
                {'<F12>', '<cmd>lua require"dap".step_out()<CR>'},
                {'<leader>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>'}
        },
        config = function()
            require('debugging')
        end,
	opts = {}},

    -- TS
    "nvim-treesitter/nvim-treesitter",
    "norcalli/nvim-colorizer.lua",
    "nvim-lua/plenary.nvim",
    -- git
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    -- Fuzzy Finding
    { "nvim-telescope/telescope.nvim", dependencies = { 'nvim-lua/plenary.nvim' }},
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    -- Notetaking / Wiki
    {"lervag/vimtex", ft="tex"},
    --"vimwiki/vimwiki",
})
