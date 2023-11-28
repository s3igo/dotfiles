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
    -- --------------------------- UI --------------------------- --
    { -- override components
        'stevearc/dressing.nvim',
        enabled = false,
        cond = not vim.g.vscode,
        opts = {
            input = { border = 'single' },
            select = { backend = { 'telescope', 'builtin' } },
            builtin = { border = 'single' },
        },
        init = function()
            vim.ui.select = function(...)
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                return vim.ui.input(...)
            end
        end,
    },
    { -- notification
        'rcarriga/nvim-notify',
        enabled = false,
        cond = not vim.g.vscode,
        keys = { { '<leader>fn', '<cmd>Telescope notify<cr>', desc = 'Telescope Notification' } },
        config = true,
    },
    { -- tab bar
        'akinsho/bufferline.nvim',
        cond = not vim.g.vscode,
        event = 'VimEnter',
        keys = {
            { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
            { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
            { '>b', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer left' },
            { '<b', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer right' },
        },
        opts = {
            options = {
                numbers = 'ordinal',
                indicator = { icon = '|' },
                modified_icon = '[+]',
                show_buffer_icons = false,
                show_buffer_close_icons = false,
                show_close_icon = false,
                diagnostics = 'nvim_lsp',
                separator_style = { '', '' },
                always_show_bufferline = false,
                offsets = {
                    {
                        filetype = 'NvimTree',
                        text_align = 'left',
                        separator = true,
                    },
                },
            },
        },
    },
    { -- status bar
        'nvim-lualine/lualine.nvim',
        cond = not vim.g.vscode,
        event = 'VimEnter',
        -- keys =  {
        --     { '[b', '<cmd>bprev<cr>', desc = 'Prev buffer' },
        --     { ']b', '<cmd>bnext<cr>', desc = 'Next buffer' },
        -- },
        opts = function()
            local colors = {
                darkgray = '#16161d',
                gray = '#727169',
                innerbg = nil,
                outerbg = '#16161D',
                normal = '#7e9cd8',
                insert = '#98bb6c',
                visual = '#ffa066',
                replace = '#e46876',
                command = '#e6c384',
            }
            return {
                options = {
                    theme = {
                        inactive = {
                            a = { fg = colors.gray, bg = colors.outerbg, gui = 'bold' },
                            b = { fg = colors.gray, bg = colors.outerbg },
                            c = { fg = colors.gray, bg = colors.innerbg },
                        },
                        visual = {
                            a = { fg = colors.darkgray, bg = colors.visual, gui = 'bold' },
                            b = { fg = colors.gray, bg = colors.outerbg },
                            c = { fg = colors.gray, bg = colors.innerbg },
                        },
                        replace = {
                            a = { fg = colors.darkgray, bg = colors.replace, gui = 'bold' },
                            b = { fg = colors.gray, bg = colors.outerbg },
                            c = { fg = colors.gray, bg = colors.innerbg },
                        },
                        normal = {
                            a = { fg = colors.darkgray, bg = colors.normal, gui = 'bold' },
                            b = { fg = colors.gray, bg = colors.outerbg },
                            c = { fg = colors.gray, bg = colors.innerbg },
                        },
                        insert = {
                            a = { fg = colors.darkgray, bg = colors.insert, gui = 'bold' },
                            b = { fg = colors.gray, bg = colors.outerbg },
                            c = { fg = colors.gray, bg = colors.innerbg },
                        },
                        command = {
                            a = { fg = colors.darkgray, bg = colors.command, gui = 'bold' },
                            b = { fg = colors.gray, bg = colors.outerbg },
                            c = { fg = colors.gray, bg = colors.innerbg },
                        },
                    },
                    icons_enabled = false,
                    globalstatus = true,
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_c = {
                        { 'filename', file_status = false },
                        {
                            function()
                                local symbols = {
                                    modified = '[+]',
                                    readonly = '[-]',
                                }
                                if vim.bo.modified then
                                    return symbols.modified
                                elseif not vim.bo.modifiable or vim.bo.readonly then
                                    return symbols.readonly
                                elseif vim.bo.buftype == 'nofile' then
                                    return symbols.unnamed
                                elseif vim.bo.newfile then
                                    return symbols.newfile
                                else
                                    return ''
                                end
                            end,
                            color = function() return { fg = vim.bo.modified and '#ecc48d' or '#82aaff' } end,
                        },
                    },
                    lualine_x = { 'location' },
                    lualine_y = {
                        {
                            'bo:expandtab',
                            fmt = function(str)
                                if str == 'true' then
                                    return 'spaces: ' .. vim.bo.shiftwidth
                                else
                                    return 'tab size: ' .. vim.bo.tabstop
                                end
                            end,
                        },
                    },
                    lualine_z = {
                        'encoding',
                        {
                            'fileformat',
                            icons_enabled = true,
                            symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' },
                        },
                        'filetype',
                    },
                },
                -- tabline = {
                --     lualine_a = {
                --         {
                --             'buffers',
                --             show_filename_only = false,
                --             mode = 2,
                --             symbols = { modified = '[+]' },
                --         },
                --     },
                -- },
            }
        end,
    },
    { -- indent guides
        'lukas-reineke/indent-blankline.nvim',
        cond = not vim.g.vscode,
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            indent = { char = '|', highlight = 'Indent' },
            whitespace = { highlight = 'Whitespace' },
            scope = { enabled = false },
        },
        config = function(_, opts)
            local char_color = 'NightflyPickleBlue'
            vim.api.nvim_set_hl(0, 'NonText', { link = char_color })
            vim.api.nvim_set_hl(0, 'Whitespace', { link = char_color })
            vim.api.nvim_set_hl(0, 'SpecialKey', { link = char_color })
            vim.api.nvim_set_hl(0, 'Indent', { link = 'NightflyGreyBlue' })
            require('ibl').setup(opts)
        end,
    },
    { -- keymaps helper
        'folke/which-key.nvim',
        cond = not vim.g.vscode,
        event = 'VimEnter',
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            window = { border = 'single' },
        },
        config = function(_, opts)
            local wk = require('which-key')
            wk.setup(opts)
            wk.register({
                ['<leader>'] = {
                    b = { name = 'Buffer' },
                    g = { name = 'Git' },
                    i = { name = 'Plugins' },
                    l = { name = 'LSP' },
                    q = { name = 'Quit' },
                },
            })
        end,
    },
    { -- terminal
        'folke/edgy.nvim',
        cond = not vim.g.vscode,
        event = 'VimEnter',
        dependencies = { 'akinsho/toggleterm.nvim', config = true },
        keys = {
            { '<leader>u', function() require('edgy').toggle() end, desc = 'Edgy Toggle' },
            { '<leader>U', function() require('edgy').select() end, desc = 'Edgy Select Window' },
            { '<leader>t', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
        },
        opts = {
            bottom = {
                {
                    ft = 'toggleterm',
                    size = { height = 0.4 },
                    filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == '' end,
                },
            },
        },
    },
    { -- markdwon preview
        'iamcco/markdown-preview.nvim',
        cond = not vim.g.vscode,
        ft = 'markdown',
        build = function() vim.fn['mkdp#util#install']() end,
        keys = { { '<leader>v', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Markdown Preview' } },
    },
    {
        'gaoDean/autolist.nvim',
        ft = {
            'markdown',
            'text',
            'tex',
            'plaintex',
            'norg',
        },
        config = function()
            require('autolist').setup()

            vim.keymap.set('i', '<tab>', '<cmd>AutolistTab<cr>')
            vim.keymap.set('i', '<s-tab>', '<cmd>AutolistShiftTab<cr>')
            vim.keymap.set('i', '<cr>', '<cr><cmd>AutolistNewBullet<cr>')
            vim.keymap.set('n', 'o', 'o<cmd>AutolistNewBullet<cr>')
            vim.keymap.set('n', 'O', 'O<cmd>AutolistNewBulletBefore<cr>')
            vim.keymap.set('n', '<cr>', '<cmd>AutolistToggleCheckbox<cr><cr>')
            vim.keymap.set('n', '<C-r>', '<cmd>AutolistRecalculate<cr>')

            -- cycle list types with dot-repeat
            vim.keymap.set('n', '<leader>cn', require('autolist').cycle_next_dr, { expr = true })
            vim.keymap.set('n', '<leader>cp', require('autolist').cycle_prev_dr, { expr = true })

            -- functions to recalculate list on edit
            vim.keymap.set('n', '>>', '>><cmd>AutolistRecalculate<cr>')
            vim.keymap.set('n', '<<', '<<<cmd>AutolistRecalculate<cr>')
            vim.keymap.set('n', 'dd', 'dd<cmd>AutolistRecalculate<cr>')
            vim.keymap.set('v', 'd', 'd<cmd>AutolistRecalculate<cr>')
        end,
    },
    -- { -- markdown preview
    --     'toppair/peek.nvim',
    --     event = { 'BufRead', 'BufNewFile' },
    --     build = 'deno task --quiet build:fast',
    --     config = true,
    -- },
    -- { -- terminal
    --     'akinsho/toggleterm.nvim',
    --     keys = { { '<leader>t', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' } },
    --     config = true,
    -- },
    -- -------------------------- Git  -------------------------- --
    { -- git client
        'NeogitOrg/neogit',
        cond = not vim.g.vscode,
        cmd = 'Neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            { 'sindrets/diffview.nvim', cmd = 'DiffviewOpen' },
        },
        keys = {
            { '<leader>ig', '<cmd>Neogit<cr>', desc = 'Neogit' },
            { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview' },
        },
        config = true,
    },
    {
        'kaarmu/typst.vim',
        ft = 'typst',
    },
}
