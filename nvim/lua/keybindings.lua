M = {}
-- Keybindings
vim.keymap.set('n', '<esc>', '<cmd>noh<cr><esc>')               -- Clear Highlighting
vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files<cr>')   -- Telescope
vim.keymap.set('n', '<C-p>', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<C-s>', '<cmd>Telescope lsp_document_symbols<cr>')
vim.keymap.set('n', '<leader>ss', '<cmd>set invspell<cr>')      -- Toggle Spell Check
vim.keymap.set('n', '<leader>l',  '<cmd>set invlist<cr>')       -- Toggle listchars
vim.keymap.set('n', '<leader>k', '<cmd>NvimTreeToggle<cr>')     -- Open File browser Sidebar
vim.keymap.set('n', '<leader>;', 'A;<esc>')                     -- add semicolon to end of line
vim.keymap.set('n', '<leader>,', 'A,<esc>')                     -- add comma to end of the line
vim.keymap.set('n', '<CR>', 'o<esc>cc')
---- Tab/shiftTab indent/unindent
vim.keymap.set('n', '<Tab>', '>>_')
vim.keymap.set('n', '<S-Tab>', '<<_')
vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')
---- Terminal
vim.keymap.set('n', '<leader>t', '<cmd>sp<CR><cmd>te<CR>a') -- Open terminal in horizontal split
vim.keymap.set('t', '<Esc>', '<C-Bslash><C-n>')             -- Go back to normal mode
-- DAP
vim.keymap.set('n', '<F5>', '<cmd>lua require"dap".continue()<CR>')
vim.keymap.set('n', '<F10>', '<cmd>lua require"dap".stop_over()<CR>')
vim.keymap.set('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>')
vim.keymap.set('n', '<F12>', '<cmd>lua require"dap".step_out()<CR>')
vim.keymap.set('n', '<leader>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>')

local opts = { noremap=true, silent=true }
function M.on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F6>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

return M
