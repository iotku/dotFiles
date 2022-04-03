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
