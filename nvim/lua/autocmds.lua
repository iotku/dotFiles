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
    pattern = { "*.java" },
    callback = function()
        require('jdtls').start_or_attach(require('lang').java_config)
    end,
})
