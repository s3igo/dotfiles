return {
    { -- code action preview
        'aznhe21/actions-preview.nvim',
        cond = not vim.g.vscode,
        event = 'LspAttach',
        keys = {
            { '<leader>a', "<cmd>lua require('actions-preview').code_actions()<cr>", desc = 'Code Action Preview' },
        },
    },
    { -- notification
        'rcarriga/nvim-notify',
        cond = not vim.g.vscode,
        keys = {
            { '<leader>n', '<cmd>Telescope notify<cr>', desc = 'Telescope Notification' },
            {
                '<leader>u',
                function() require('notify').dismiss({ silent = true, pending = true }) end,
                desc = 'Dismiss all Notifications',
            },
        },
        opts = { background_colour = 'NormalFloat' },
        init = function() vim.notify = require('notify') end,
    },
    { -- tab bar
        'akinsho/bufferline.nvim',
        cond = not vim.g.vscode,
        -- event = 'VimEnter',
        event = 'UIEnter',
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
    { -- status / tab line
        'rebelot/heirline.nvim',
        enabled = false,
        event = 'UIEnter',
        config = function()
            local conditions = require('heirline.conditions')
            local utils = require('heirline.utils')
            local bg = utils.get_highlight('NormalFloat').bg
            require('heirline').setup({
                statusline = {
                    hl = { bg = 'NONE' },
                    { provider = 'hoge' },
                    { provider = function() return '%=' end },
                },
            })
        end,
    },
    { -- status bar
        'nvim-lualine/lualine.nvim',
        -- enabled = false,
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
            vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = 'NONE' })
        end,
    },
    { -- terminal
        'folke/edgy.nvim',
        cond = not vim.g.vscode,
        enabled = false,
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
}
