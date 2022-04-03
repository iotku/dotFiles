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
    use 'folke/tokyonight.nvim'  -- Colorscheme
    use 'norcalli/nvim-colorizer.lua'
 --   use 'github/copilot.vim'   -- nice meme
    use 'romgrk/nvim-treesitter-context'
    use 'lervag/vimtex'
    use 'vimwiki/vimwiki'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'     -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip'         -- Snippets plugin
    use 'ray-x/go.nvim'
    use 'ray-x/lsp_signature.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'windwp/windline.nvim'
    use "SmiteshP/nvim-gps"
    use 'windwp/nvim-autopairs'
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
    use 'tpope/vim-fugitive'
    use {'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }}
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
    use {"folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons",
        config = function() 
            require("trouble").setup {} 
        end
    }
end)

