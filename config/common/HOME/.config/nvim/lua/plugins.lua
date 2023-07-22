return {
    { -- colorscheme
        'bluz71/vim-nightfly-guicolors',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd('colorscheme nightfly')
        end,
    },
    {

    }
}
