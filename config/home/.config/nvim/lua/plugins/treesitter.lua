return {
    { -- treesitter
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'JoosepAlviste/nvim-ts-context-commentstring',
            'RRethy/nvim-treesitter-endwise',
            { 'HiPhish/rainbow-delimiters.nvim', cond = not vim.g.vscode },
        },
        cmd = { 'TSUpdateSync' },
        opts = {
            highlight = { enable = not vim.g.vscode },
            indent = { enable = true },
            auto_install = true,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<cr>',
                    scope_incremental = '<cr>',
                    node_incremental = '<tab>',
                    node_decremental = '<S-tab>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['ak'] = { query = '@block.outer', desc = 'around block' },
                        ['ik'] = { query = '@block.inner', desc = 'inside block' },
                        ['ac'] = { query = '@class.outer', desc = 'around class' },
                        ['ic'] = { query = '@class.inner', desc = 'inside class' },
                        ['a?'] = { query = '@conditional.outer', desc = 'around conditional' },
                        ['i?'] = { query = '@conditional.inner', desc = 'inside conditional' },
                        ['af'] = { query = '@function.outer', desc = 'around function ' },
                        ['if'] = { query = '@function.inner', desc = 'inside function ' },
                        ['al'] = { query = '@loop.outer', desc = 'around loop' },
                        ['il'] = { query = '@loop.inner', desc = 'inside loop' },
                        ['aa'] = { query = '@parameter.outer', desc = 'around argument' },
                        ['ia'] = { query = '@parameter.inner', desc = 'inside argument' },
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        [']k'] = { query = '@block.outer', desc = 'Next block start' },
                        [']f'] = { query = '@function.outer', desc = 'Next function start' },
                        [']a'] = { query = '@parameter.inner', desc = 'Next argument start' },
                    },
                    goto_next_end = {
                        [']K'] = { query = '@block.outer', desc = 'Next block end' },
                        [']F'] = { query = '@function.outer', desc = 'Next function end' },
                        [']A'] = { query = '@parameter.inner', desc = 'Next argument end' },
                    },
                    goto_previous_start = {
                        ['[k'] = { query = '@block.outer', desc = 'Previous block start' },
                        ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
                        ['[a'] = { query = '@parameter.inner', desc = 'Previous argument start' },
                    },
                    goto_previous_end = {
                        ['[K'] = { query = '@block.outer', desc = 'Previous block end' },
                        ['[F'] = { query = '@function.outer', desc = 'Previous function end' },
                        ['[A'] = { query = '@parameter.inner', desc = 'Previous argument end' },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['>K'] = { query = '@block.outer', desc = 'Swap next block' },
                        ['>F'] = { query = '@function.outer', desc = 'Swap next function' },
                        ['>A'] = { query = '@parameter.inner', desc = 'Swap next argument' },
                    },
                    swap_previous = {
                        ['<K'] = { query = '@block.outer', desc = 'Swap previous block' },
                        ['<F'] = { query = '@function.outer', desc = 'Swap previous function' },
                        ['<A'] = { query = '@parameter.inner', desc = 'Swap previous argument' },
                    },
                },
            },
            -- context_commentstring = { enable = true },
            endwise = { enable = true },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
            local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
            parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
            if not vim.g.vscode then
                local rainbow_delimiters = require('rainbow-delimiters')
                vim.g.rainbow_delimiters = {
                    strategy = {
                        [''] = rainbow_delimiters.strategy['global'],
                        vim = rainbow_delimiters.strategy['local'],
                    },
                    query = { [''] = 'rainbow-delimiters', lua = 'rainbow-blocks' },
                    highlight = {
                        'RainbowDelimiterRed',
                        'RainbowDelimiterYellow',
                        'RainbowDelimiterBlue',
                        'RainbowDelimiterOrange',
                        'RainbowDelimiterGreen',
                        'RainbowDelimiterViolet',
                        'RainbowDelimiterCyan',
                    },
                }
            end
            vim.api.nvim_set_hl(0, '@text.todo', { link = 'NightflyBlueMode' })
            vim.api.nvim_set_hl(0, '@text.note', { link = 'NightflyPurpleMode' })
            vim.api.nvim_set_hl(0, '@text.warning', { link = 'NightflyTanMode' })
            vim.api.nvim_set_hl(0, '@text.danger', { link = 'NightflyWatermelonModeMode' })
        end,
    },
    { -- sticky scroll
        'nvim-treesitter/nvim-treesitter-context',
        cond = not vim.g.vscode,
        event = { 'BufReadPost', 'BufNewFile' },
    },
}
