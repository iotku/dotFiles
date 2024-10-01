-- navic for context
local navic = require("nvim-navic")

-- Mason to download LSPs
require("mason").setup()
-- cmp completion
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = { 'gopls', 'rust_analyzer', 'clangd', 'denols', 'ts_ls', 'erlangls', 'pylsp'}
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = function(client, bufnr)
	    require('keybindings').on_attach(client,bufnr)
	    navic.attach(client, bufnr)
    end,
    capabilities = capabilities,
  }
end
-- TODO: Add lua_ls
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

require'lspconfig'.eslint.setup{}
