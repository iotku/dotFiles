local mapper = function(mode, key, result) -- Helpful keybinding function
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end
-- Keybindings
vim.g.mapleader = ' '                                   -- Leader
mapper('n', '<esc>', '<cmd>noh<cr><esc>')               -- Clear Highlighting
mapper('n', '<C-p>', '<cmd>Telescope find_files<cr>')   -- Telescope
mapper('n', '<leader>ss', '<cmd>lua toggleSpell()<cr>') -- Toggle Spell Check
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
