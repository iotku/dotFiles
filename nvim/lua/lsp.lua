-- cmp completion
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

local local_mapper = function(mode, key, result) -- Helpful keybinding function
    vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

local setLspBindings = function(client)
    local_mapper('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    local_mapper('n', '<F6>', '<cmd>lua vim.lsp.buf.rename()<CR>')
    local_mapper('n', 'gr', '<cmd>TroubleToggle lsp_references<cr>')
    local_mapper('n', '<c-K>', '<cmd>lua vim.lsp.buf.hover()<CR>')
    local_mapper('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'gopls', 'rust_analyzer', 'jdtls', 'clangd', 'bashls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = setLspBindings,
    capabilities = capabilities,
  }
end

