-- navic for context
local navic = require("nvim-navic")

-- Mason to download LSPs
require("mason").setup()
-- cmp completion
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- LSP Specific settings.
local lsp_settings = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      }
    }
  },
}

local servers = { 'gopls', 'rust_analyzer', 'clangd', 'denols', 'ts_ls', 'erlangls', 'pylsp', 'lua_ls'}
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = function(client, bufnr)
	    require('keybindings').on_attach(client,bufnr)
	    navic.attach(client, bufnr)
    end,
    capabilities = capabilities,
    settings = lsp_settings[lsp] and lsp_settings[lsp].settings or nil -- Apply settings if available
  }
end

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- This is separate because we probably don't want to add the main keybindings
-- if all this is doing is linting, but maybe this should move elsewhere.
require'lspconfig'.eslint.setup{}
