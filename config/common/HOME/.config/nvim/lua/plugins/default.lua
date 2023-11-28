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
    -- {
    --     'projekt0n/github-nvim-theme',
    --     enabled = false,
    --     cond = not vim.g.vscode,
    --     lazy = false,
    --     priority = 1000,
    --     opts = {
    --         options = { transparent = true },
    --     },
    --     config = function(_, opts)
    --         require('github-theme').setup(opts)
    --         vim.cmd('colorscheme github_dark')
    --     end,
    -- },
    -- {
    --     'RRethy/nvim-base16',
    --     enabled = false,
    --     cond = not vim.g.vscode,
    --     lazy = false,
    --     priority = 1000,
    --     opts = {
    --         base00 = '#16161D',
    --         base01 = '#2c313c',
    --         base02 = '#3e4451',
    --         base03 = '#6c7891',
    --         base04 = '#565c64',
    --         base05 = '#abb2bf',
    --         base06 = '#9a9bb3',
    --         base07 = '#c5c8e6',
    --         base08 = '#e06c75',
    --         base09 = '#d19a66',
    --         base0A = '#e5c07b',
    --         base0B = '#98c379',
    --         base0C = '#56b6c2',
    --         base0D = '#0184bc',
    --         base0E = '#c678dd',
    --         base0F = '#a06949',
    --     },
    --     config = function(_, opts)
    --         require('colorscheme').setup(opts)
    --         vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
    --         -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
    --     end,
    -- },
    -- -------------------------- Util -------------------------- --
    -- { -- benchmark
    --     'dstein64/vim-startuptime',
    --     cmd = 'StartupTime',
    --     keys = { { '<leader>ib', '<cmd>StartupTime<cr>', desc = 'Benchmark' } },
    --     init = function() vim.g.startuptime_tries = 10 end,
    -- },
    { -- utility functions
        'nvim-lua/plenary.nvim',
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
}
