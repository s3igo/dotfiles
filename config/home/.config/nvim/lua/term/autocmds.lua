vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'Enter terminal with insert mode',
    command = 'startinsert',
})

vim.api.nvim_create_autocmd('FocusLost', {
    desc = 'Save on focus lost',
    command = 'wa',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'typst',
    desc = 'Set typst filetype',
    command = 'setlocal shiftwidth=4',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lazy', 'mason', 'lspinfo' },
    command = 'setlocal winblend=30',
})
