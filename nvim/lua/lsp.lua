local servers = { 'gopls', 'rust_analyzer', 'clangd', 'ts_ls', 'pylsp', 'lua_ls', 'jdtls', 'html'}

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
  -- add another server here...
}

-- cmp completion
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- navic for context
local navic = require("nvim-navic")

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    on_attach = function(client, bufnr)
	    require('keybindings').on_attach(client,bufnr)
	    navic.attach(client, bufnr)
    end,
    capabilities = capabilities,
    settings = lsp_settings[server] and lsp_settings[server].settings or nil -- Apply settings if available
  })
end

-- --> Actually enable the LSPs here <--
vim.lsp.enable(servers)

-- Go additional functionality
require('go').setup{}

-- Mason to download LSPs
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = servers,
}

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- This is separate because we probably don't want to add the main keybindings
-- if all this is doing is linting, but maybe this should move elsewhere.
-- require'lspconfig'.eslint.setup{} -- TODO: Update to new syntax
