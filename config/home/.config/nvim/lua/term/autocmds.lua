vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'Enter terminal with insert mode',
    command = 'startinsert',
})

-- vim.api.nvim_create_autocmd('FocusLost', {
--     desc = 'Save on focus lost',
--     command = 'wa',
-- })

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'typst',
    desc = 'shiftwidth = 4 for typst',
    callback = function() vim.opt_local.shiftwidth = 4 end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lazy', 'mason', 'lspinfo' },
    desc = 'Set window opacity',
    callback = function() vim.opt_local.winblend = 30 end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'gitcommit',
    desc = 'gitcommit specific settings',
    callback = function()
        vim.opt_local.colorcolumn = { 50, 72 }
        vim.keymap.set('n', '<leader>w', '<cmd>wq<cr><esc>', { buffer = true })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    desc = 'markdown specific settings',
    callback = function ()
        vim.opt_local.formatoptions:append('r')
        vim.opt_local.comments = 'b:*,b:-,b:+,n:>'
    end
})
