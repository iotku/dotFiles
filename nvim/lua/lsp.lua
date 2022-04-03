-- cmp completion
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')


-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'gopls', 'rust_analyzer', 'clangd' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = require('keybindings').setLspBindings(),
    capabilities = capabilities,
  }
end
