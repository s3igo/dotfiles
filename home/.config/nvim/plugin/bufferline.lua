require('bufferline').setup({
    options =  {
        numbers = 'ordinal',
        buffer_close_icon = '',
        close_icon = '',
        diagnostics = 'nvim_lsp',
        separator_style = { '', '' }
    }
})

-- bufferline
vim.keymap.set('n', 's.', '<cmd>BufferLineMoveNext<cr>')
vim.keymap.set('n', 's,', '<cmd>BufferLineMovePrev<cr>')
