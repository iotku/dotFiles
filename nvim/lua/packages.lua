local fn = vim.fn
-- Bootstrap Packer (Package Management) -- Remember to :PackerInstall
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Packages
require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Packception
    -- Appearance/Bars
    use 'folke/tokyonight.nvim'  -- Colorscheme
    use 'romgrk/barbar.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'windwp/nvim-autopairs'
    use 'windwp/windline.nvim'
    use 'norcalli/nvim-colorizer.lua'
    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'lewis6991/spellsitter.nvim',  config = function() require('spellsitter').setup() end}
    use 'romgrk/nvim-treesitter-context'
    -- Completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'     -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip'         -- Snippets plugin
    -- Language/LSP Support
    use 'neovim/nvim-lspconfig'
    use 'ray-x/lsp_signature.nvim'
    use 'nvim-lua/lsp-status.nvim'
    use 'ray-x/go.nvim'
    use 'simrat39/rust-tools.nvim'
    use 'mfussenegger/nvim-jdtls'
    use "SmiteshP/nvim-gps"
    -- Notetaking / Wiki
    use 'lervag/vimtex'
    use 'vimwiki/vimwiki'
        use { 'kyazdani42/nvim-tree.lua', 
        requires = { 'kyazdani42/nvim-web-devicons', },
        config = function() require'nvim-tree'.setup {
            actions = {
                open_file = {
                    quit_on_open = true,
                    resize_window = true,
                }
            }
        } end
    }
    -- Git
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'junegunn/gv.vim'
    use {'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }}
    -- DAP (Debug Adapter Protocol)
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use 'theHamsta/nvim-dap-virtual-text'
    use 'leoluz/nvim-dap-go'
    -- Fuzzy Finding
    use 'nvim-lua/plenary.nvim' -- required by telescope
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {'nvim-telescope/telescope-ui-select.nvim' }
    use {"folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons",
        config = function() 
            require("trouble").setup {} 
        end
    }
 --   use 'github/copilot.vim'   -- nice meme
end)

