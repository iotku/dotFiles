-- cmp completion
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = { 'gopls', 'rust_analyzer', 'clangd' }
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = require('keybindings').on_attach,
    capabilities = capabilities,
  }
end
