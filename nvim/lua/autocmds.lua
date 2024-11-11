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

-- Run prettier on JS/JSX
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.jsx" },
  group = vim.api.nvim_create_augroup("Prettier", { clear = true }),
  callback = function()
    if vim.fn.executable("prettier") == 0 then
      vim.notify("Prettier is not installed. Please install it with Mason.", vim.log.levels.WARN)
      return
    end
    -- Save cursor position and screen view
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local view = vim.fn.winsaveview()
    local filepath = vim.fn.expand("%:p")
    vim.fn.jobstart({ "prettier", "--write", "--tab-width", tostring(vim.bo.tabstop), filepath }, {
      on_exit = function()
        vim.cmd("edit!")  -- Reload the file silently
        -- Restore cursor position and screen view
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        vim.fn.winrestview(view)
      end,
    })
  end,
})


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
