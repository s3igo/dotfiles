vim.api.nvim_create_autocmd('FileType', {
    desc = 'Disable automatic comment insertion',
    callback = function()
        vim.opt_local.formatoptions:remove('r')
        vim.opt_local.formatoptions:remove('o')
    end,
})
