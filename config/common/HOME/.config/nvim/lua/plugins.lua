return {{ -- colorscheme
    'bluz71/vim-nightfly-guicolors',
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.nightflyTransparent = true
        vim.cmd('colorscheme nightfly')
    end
}, -- ---------------------------------- Util ---------------------------------- --
{ -- benchmark
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
        vim.g.startuptime_tries = 10
    end
}, { -- utility functions
    'nvim-lua/plenary.nvim',
    lazy = true
}, -- --------------------------------- Coding --------------------------------- --
{ -- autopair
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
}, { -- surround selection
    'kylechui/nvim-surround',
    event = "VeryLazy",
    config = true
}, { -- comment
    'numToStr/Comment.nvim',
    config = true,
    lazy = false
}, { -- subword motion
    "chrisgrieser/nvim-spider",
    lazy = true,
    config = function()
        vim.keymap.set({'n', 'o', 'x'}, 'sw', "<cmd>lua require('spider').motion('w')<cr>", {
            desc = 'Spider-w'
        })
        vim.keymap.set({'n', 'o', 'x'}, 'se', "<cmd>lua require('spider').motion('e')<cr>", {
            desc = 'Spider-e'
        })
        vim.keymap.set({'n', 'o', 'x'}, 'sb', "<cmd>lua require('spider').motion('b')<cr>", {
            desc = 'Spider-b'
        })
        vim.keymap.set({'n', 'o', 'x'}, 'sge', "<cmd>lua require('spider').motion('ge')<cr>", {
            desc = 'Spider-ge'
        })
    end
}, -- ------------------------------- Completion ------------------------------- --
{ -- copilot
    'zbirenbaum/copilot.lua',
    event = "InsertEnter",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
        filetypes = {
            markdown = true,
            help = true
        }
    }
}, -- --------------------------------- Editor --------------------------------- --
{ -- filer
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {'nvim-tree/nvim-web-devicons'},
    opts = {
        filters = {
            custom = {'.git'}
        }
    },
    config = function(_, opts)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
        require('nvim-tree').setup(opts)
    end
}, {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = {{
        '<leader>f',
        '<cmd>Telescope find_files<cr>',
        desc = 'Find Files'
    }},
    opts = {
        defaults = {
            file_ignore_patterns = {'.git', 'node_modules'}
        },
        pickers = {
            find_files = {
                hidden = true
            }
        }
    }
}, { -- gutter indicators
    'lewis6991/gitsigns.nvim',
    event = {"BufReadPre", "BufNewFile"},
    opts = {
        signs = {
            add = {
                text = '|'
            },
            change = {
                text = '|'
            },
            delete = {
                text = '_'
            },
            topdelete = {
                text = '‾'
            },
            changedelete = {
                text = '~'
            },
            untracked = {
                text = '|'
            }
        }
    }
}, { -- scrollbar
    'petertriho/nvim-scrollbar',
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        require("scrollbar").setup()
        require("scrollbar.handlers.gitsigns").setup()
    end
}, { -- buffer remove
    "echasnovski/mini.bufremove",
    keys = {{
        "<leader>bd",
        function()
            require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer"
    }, {
        "<leader>bD",
        function()
            require("mini.bufremove").delete(0, true)
        end,
        desc = "Force Delete Buffer"
    }}
}, -- { -- FIXME: Invalid sign text
--     'folke/todo-comments.nvim',
--     cmd = {'TodoTrouble', 'TodoTelescope'},
--     event = {"BufReadPost", "BufNewFile"},
--     config = true,
--     keys = {{
--         "]t",
--         function()
--             require("todo-comments").jump_next()
--         end,
--         desc = "Next todo comment"
--     }, {
--         "[t",
--         function()
--             require("todo-comments").jump_prev()
--         end,
--         desc = "Previous todo comment"
--     }, {
--         "<leader>j",
--         "<cmd>TodoTrouble<cr>",
--         desc = "Todo (Trouble)"
--     }, {
--         "st",
--         "<cmd>TodoTelescope<cr>",
--         desc = "Todo"
--     }}
-- },
-- -------------------------------------------------------------------------- --
{ -- indent guides
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
