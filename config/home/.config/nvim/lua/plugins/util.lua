return {
    { -- colorscheme
        'bluz71/vim-nightfly-guicolors',
        -- enabled = false,
        cond = not vim.g.vscode,
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.nightflyTransparent = true
            vim.g.nightflyVirtualTextColor = true
            vim.g.nightflyWinSeparator = 2
            vim.cmd('colorscheme nightfly')
        end,
    },
    { -- IME switcher
        'keaising/im-select.nvim',
        event = 'InsertEnter',
        cond = not vim.g.vscode,
        config = function()
            require('im_select').setup({
                set_previous_events = {},
            })
        end,
    },
    { -- utility functions
        'nvim-lua/plenary.nvim',
    },
}
