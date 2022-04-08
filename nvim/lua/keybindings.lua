M = {}
local mapper = function(mode, key, result) -- Helpful keybinding function
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

local local_mapper = function(buffer, mode, key, result) -- Helpful keybinding function
    vim.api.nvim_buf_set_keymap(buffer, mode, key, result, {noremap = true, silent = true})
end
-- Keybindings
vim.g.mapleader = ' '                                   -- Leader
mapper('n', '<esc>', '<cmd>noh<cr><esc>')               -- Clear Highlighting
mapper('n', '<C-p>', '<cmd>Telescope find_files<cr>')   -- Telescope
mapper('n', '<leader>ss', '<cmd>set invspell<cr>')      -- Toggle Spell Check
mapper('n', '<leader>l',  '<cmd>set invlist<cr>')       -- Toggle listchars
mapper('n', '<leader>k', '<cmd>NvimTreeToggle<cr>')     -- Open File browser Sidebar
mapper('n', '<leader>?', '<cmd>TroubleToggle<cr>')      -- Open Trouble Toggle Panel
mapper('n', '<leader>;', 'A;<esc>')                     -- add semicolon to end of line
mapper('n', '<leader>,', 'A,<esc>')                     -- add comma to end of the line
mapper('n', '<CR>', 'o<esc>cc')
mapper('n', '<leader>c', '<cmd>TSContextToggle<cr>')    -- Toggle treesitter-context
---- Tab/shiftTab indent/unindent
mapper('n', '<Tab>', '>>_')
mapper('n', '<S-Tab>', '<<_')
mapper('v', '<Tab>', '>gv')
mapper('v', '<S-Tab>', '<gv')
---- Terminal
mapper('n', '<leader>t', '<cmd>sp<CR><cmd>te<CR>a') -- Open terminal in horizontal split
mapper('t', '<Esc>', '<C-Bslash><C-n>')             -- Go back to normal mode
-- DAP
mapper('n', '<F5>', '<cmd>lua require"dap".continue()<CR>')
mapper('n', '<F10>', '<cmd>lua require"dap".stop_over()<CR>')
mapper('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>')
mapper('n', '<F12>', '<cmd>lua require"dap".step_out()<CR>')
mapper('n', '<leader>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>')

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
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>TroubleToggle lsp_references<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

return M
