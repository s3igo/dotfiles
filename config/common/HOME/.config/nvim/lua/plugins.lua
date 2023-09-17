return {{ -- colorscheme
    'bluz71/vim-nightfly-guicolors',
    lazy = false,
    priority = 1000,
    config = function()
        vim.api.nvim_create_autocmd('ColorScheme', {
            pattern = '*',
            callback = function()
                vim.cmd('highlight Normal ctermbg=NONE guibg=NONE')
                vim.cmd('highlight NonText ctermbg=NONE guibg=NONE')
                vim.cmd('highlight Folded ctermbg=NONE guibg=NONE')
                vim.cmd('highlight EndOfBuffer ctermbg=NONE guibg=NONE')
                vim.cmd('highlight SignColumn ctermbg=NONE guibg=NONE')
                vim.cmd('highlight LineNr ctermbg=NONE guibg=NONE')
            end
        })
        vim.cmd('colorscheme nightfly')
    end
}, -- --------------------------------- Coding --------------------------------- --
{ -- autopair
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
}, { -- surround selection
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true
}, { -- comment
    'numToStr/Comment.nvim',
    config = true,
    lazy = false
}, -- --------------------------------- Editor --------------------------------- --
{ -- filer
    'nvim-tree/nvim-tree.lua',
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.keymap.set('n', 'sb', ':NvimTreeToggle<CR>')
        vim.cmd('highlight NvimTreeNormal ctermbg=NONE guibg=NONE')
        require('nvim-tree').setup({
            -- view = {
            --     mappings = {
            --         list = {{
            --             key = 's',
            --             action = ''
            --         }, {
            --             key = 'so',
            --             action = 'system_open'
            --         }}
            --     }
            -- },
            filters = {
                custom = {'\\.git$', '.cache$'}
            }
        })
    end
}, { -- gutter indicators
    'lewis6991/gitsigns.nvim',
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
    config = function()
        require('scrollbar').setup()
        require('scrollbar.handlers.gitsigns').setup()
    end
}, { -- tab bar
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    opts = {
        options = {
            numbers = 'ordinal',
            buffer_close_icon = '',
            close_icon = '',
            diagnostics = 'nvim_lsp',
            separator_style = {'', ''}
            -- offsets = {
            --     {
            --         filetype = 'NvimTree',
            --         text = 'File Explorer',
            --         highlight = 'Directory',
            --         text_align = 'left',
            --     }
            -- }
        }
    }
}, {
    'hrsh7th/nvim-insx',
    config = function()
        require('insx.preset.standard').setup()
    end
}, { -- tree sitter
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = {"BufReadPost", "BufNewFile"},
    dependencies = {'windwp/nvim-ts-autotag', 'nvim-treesitter/nvim-treesitter-context',
                    "nvim-treesitter/nvim-treesitter-textobjects", 'RRethy/nvim-treesitter-textsubjects',
                    'RRethy/nvim-treesitter-endwise'},
    cmd = {"TSUpdateSync"},
    config = function()
        require('nvim-treesitter.configs').setup({
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            },
            ensure_installed = 'all',
            autotag = {
                enable = true
            },
            textsubjects = {
                enable = true,
                prev_selection = ',',
                keymaps = {
                    ['.'] = 'textsubjects-smart',
                    [';'] = 'textsubjects-container-outer',
                    ['i;'] = 'textsubjects-container-inner'
                }
            },
            endwise = {
                enable = true
            }
        })
        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        parser_config.tsx.filetype_to_parsername = {'javascript', 'typescript.tsx'}
    end
}}
