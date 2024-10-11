-- Run gofmt/goimports on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
	    require('go.format').goimport()
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.c", "*.h", "*.java" },
    callback = function()
        vim.bo.expandtab = false
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.java",
    callback = function()
        require('jdtls').start_or_attach(require('lang').java_config)
    end,
})

-- vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
--     pattern = "*",
--     callback = function()
--         require('nvim-lightbulb').update_lightbulb()
--     end,
-- })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
