vim.api.nvim_create_autocmd('FileType', {
    desc = 'Set formatoptions',
    command = 'setlocal formatoptions-=ro',
})
