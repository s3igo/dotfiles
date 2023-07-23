local onlyVscode = function()
    return vim.g.vscode == nil
end

return {{ -- colorscheme
    'bluz71/vim-nightfly-guicolors',
    lazy = false,
    cond = onlyVscode,
    priority = 1000,
    config = function()
        vim.cmd('colorscheme nightfly')
    end
}, { -- filer
    'nvim-tree/nvim-tree.lua',
    cond = onlyVscode,
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.keymap.set('n', 'sb', ':NvimTreeToggle<CR>')
        vim.cmd('highlight NvimTreeNormal ctermbg=NONE guibg=NONE')
        require('nvim-tree').setup({
            view = {
                mappings = {
                    list = {{
                        key = 's',
                        action = ''
                    }, {
                        key = 'so',
                        action = 'system_open'
                    }}
                }
            },
            filters = {
                custom = {'\\.git$', '.cache$'}
            }
        })
    end
}, { -- gutter indicators
    'lewis6991/gitsigns.nvim',
    cond = onlyVscode,
    config = function()
        require('gitsigns').setup({
            signs = {
                add = {
                    hl = 'GitSignsAdd',
                    text = '|',
                    numhl = 'GitSignsAddNr',
                    linehl = 'GitSignsAddLn'
                },
                change = {
                    hl = 'GitSignsChange',
                    text = '|',
                    numhl = 'GitSignsChangeNr',
                    linehl = 'GitSignsChangeLn'
                },
                delete = {
                    hl = 'GitSignsDelete',
                    text = '_',
                    numhl = 'GitSignsDeleteNr',
                    linehl = 'GitSignsDeleteLn'
                },
                topdelete = {
                    hl = 'GitSignsDelete',
                    text = '‾',
                    numhl = 'GitSignsDeleteNr',
                    linehl = 'GitSignsDeleteLn'
                },
                changedelete = {
                    hl = 'GitSignsChange',
                    text = '~',
                    numhl = 'GitSignsChangeNr',
                    linehl = 'GitSignsChangeLn'
                }
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true
            },
            attach_to_untracked = true,
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            yadm = {
                enable = false
            }
        })
    end
}, { -- indent guides
    'lukas-reineke/indent-blankline.nvim',
    cond = onlyVscode,
    config = function()
        require('indent_blankline').setup({
            char = '|',
            show_end_of_line = true,
            show_trailing_blankline_indent = false
            -- TODO: tree-sitterが必要
            -- show_current_context = true,
            -- show_current_context_start = true,
        })
    end
}, { -- status bar
    'nvim-lualine/lualine.nvim',
    cond = onlyVscode,
    config = function()
        require('lualine').setup({
            options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = {
                    left = '',
                    right = ''
                },
                section_separators = {
                    left = '',
                    right = ''
                },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {}
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_z = {'encoding', {
                    'fileformat',
                    fmt = function(str)
                        local formats = {
                            unix = 'LF',
                            dos = 'CRLF',
                            mac = 'CR'
                        }
                        return formats[str]
                    end
                }, 'filetype'},
                lualine_y = {{
                    'bo:expandtab',
                    fmt = function(str)
                        if str == 'true' then
                            return 'spaces:'
                        else
                            return 'tab size:'
                        end
                    end
                }, 'bo:tabstop'},
                lualine_x = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        })
    end
}, { -- scrollbar
    'petertriho/nvim-scrollbar',
    cond = onlyVscode,
    config = function()
        require('scrollbar').setup()
        require('scrollbar.handlers.gitsigns').setup()
    end
}, { -- tab bar
    'akinsho/bufferline.nvim',
    cond = onlyVscode,
    config = function()
        require('bufferline').setup({
            options = {
                numbers = 'ordinal',
                buffer_close_icon = '',
                close_icon = '',
                diagnostics = 'nvim_lsp',
                separator_style = {'', ''}
            }
        })
    end
}, { -- auto pairs
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
}, { -- surround selection
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup()
    end
}}
-- }, {
--     "folke/flash.nvim",
--     event = "VeryLazy",
--     ---@type Flash.Config
--     opts = {},
--     -- stylua: ignore
--     keys = {{
--         "s",
--         mode = {"n", "x", "o"},
--         function()
--             require("flash").jump()
--         end,
--         desc = "Flash"
--     }, {
--         "S",
--         mode = {"n", "o", "x"},
--         function()
--             require("flash").treesitter()
--         end,
--         desc = "Flash Treesitter"
--     }, {
--         "r",
--         mode = "o",
--         function()
--             require("flash").remote()
--         end,
--         desc = "Remote Flash"
--     }, {
--         "R",
--         mode = {"o", "x"},
--         function()
--             require("flash").treesitter_search()
--         end,
--         desc = "Treesitter Search"
--     }, {
--         "<c-s>",
--         mode = {"c"},
--         function()
--             require("flash").toggle()
--         end,
--         desc = "Toggle Flash Search"
--     }}
-- }}
