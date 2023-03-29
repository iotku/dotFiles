-- cmp completion
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = { 'gopls', 'rust_analyzer', 'clangd', 'denols' }
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = require('keybindings').on_attach,
    capabilities = capabilities,
  }
  end
-- TODO: Add lua_ls
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}
