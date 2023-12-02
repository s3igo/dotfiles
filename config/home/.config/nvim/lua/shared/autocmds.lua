vim.api.nvim_create_autocmd('FileType', {
    desc = 'Disable automatic comment insertion',
    command = 'setlocal formatoptions-=ro',
})
