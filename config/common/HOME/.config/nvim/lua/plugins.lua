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
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function()
        vim.g.startuptime_tries = 10
    end
}, { -- utility functions
    'nvim-lua/plenary.nvim',
    lazy = true
}, -- --------------------------------- Coding --------------------------------- --
{ -- LSP
    'neovim/nvim-lspconfig',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {{
        'folke/neodev.nvim',
        config = true
    }, {
        'folke/neoconf.nvim',
        cmd = 'Neoconf',
        config = true
    }, {
        'williamboman/mason-lspconfig.nvim',
        cmd = {'LspInstall', 'LspUninstall'},
        opts = {}
    }, {
        'williamboman/mason.nvim',
        cmd = {'Mason'},
        build = ':MasonUpdate',
        opts = {}
    }, 'hrsh7th/cmp-nvim-lsp'},
    config = function(_, _)
        require('mason').setup()
        local mason_lspconfig = require('mason-lspconfig')
        mason_lspconfig.setup({
            -- ensure_installed = {'rust_analyzer', 'tsserver'}
        })
        local lspconfig = require('lspconfig')
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        mason_lspconfig.setup_handlers({function(server)
            lspconfig[server].setup({
                capabilities = lsp_capabilities
            })
        end})
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP Actions',
            callback = function(_)
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
            end
        })
    end
}, { -- copilot
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    dependencies = {
        'zbirenbaum/copilot-cmp',
        config = true
    },
    cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
        filetypes = {
            markdown = true,
            help = true
        },
        suggestion = {
            enabled = false
        },
        panel = {
            enabled = false
        }
    }
}, { -- completion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path'},
    opts = function()
        local cmp = require('cmp')
        return {
            mapping = cmp.mapping.preset.insert({
                ['<C-n>'] = cmp.mapping.select_next_item({
                    behavior = cmp.SelectBehavior.Select
                }),
                ['<C-p>'] = cmp.mapping.select_prev_item({
                    behavior = cmp.SelectBehavior.Select
                }),
                ['<C-j>'] = cmp.mapping.complete(),
                ['<tab>'] = cmp.mapping.confirm()
            }),
            sources = cmp.config.sources({{
                name = 'copilot'
            }, {
                name = 'nvim_lsp'
            }, {
                name = 'buffer'
            }, {
                name = 'path'
            }})
        }
    end
}, { -- autopair
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true
}, { -- surround selection
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = true
}, { -- comment
    'numToStr/Comment.nvim',
    config = true,
    lazy = false
}, { -- subword motion
    'chrisgrieser/nvim-spider',
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
}, { -- fuzzy finder
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = {{
        '<leader><space>',
        '<cmd>Telescope find_files<cr>',
        desc = 'Find Files'
    }, {
        '<leader><tab>',
        '<cmd>Telescope buffers<cr>',
        desc = 'Switch Buffer'
    }, {
        '<leader>/',
        '<cmd>Telescope live_grep<cr>',
        desc = 'Live Grep'
    }, {
        '<leader>:',
        '<cmd>Telescope command_history<cr>',
        desc = 'Command History'
    }},
    opts = {
        defaults = {
            file_ignore_patterns = {'.git', 'node_modules'},
            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-k>'] = false,
                    ['<C-a>'] = {
                        '<Home>',
                        type = 'command'
                    },
                    ['<C-e>'] = {
                        '<End>',
                        type = 'command'
                    }
                }
            }
        },
        pickers = {
            find_files = {
                hidden = true
            }
        }
    }
}, { -- treesitter
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = {'BufReadPost', 'BufNewFile'},
    dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'},
    cmd = {'TSUpdateSync'},
    opts = {
        highlight = {
            enable = true
        },
        indent = {
            enable = true
        },
        auto_install = true,
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = 'se',
                node_incremental = 'se',
                scope_incremental = 'ss',
                node_decremental = 'sa'
            }
        }
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        parser_config.tsx.filetype_to_parsername = {'javascript', 'typescript.tsx'}
    end
}, { -- gutter indicator
    'lewis6991/gitsigns.nvim',
    event = {'BufReadPre', 'BufNewFile'},
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
    event = {'BufReadPre', 'BufNewFile'},
    config = function()
        require('scrollbar').setup()
        require('scrollbar.handlers.gitsigns').setup()
    end
}, { -- buffer remove
    'echasnovski/mini.bufremove',
    keys = {{
        '<leader>bd',
        function()
            require('mini.bufremove').delete(0, false)
        end,
        desc = 'Delete Buffer'
    }, {
        '<leader>bD',
        function()
            require('mini.bufremove').delete(0, true)
        end,
        desc = 'Force Delete Buffer'
    }}
}, -- { -- FIXME: Invalid sign text
--     'folke/todo-comments.nvim',
--     cmd = {'TodoTrouble', 'TodoTelescope'},
--     event = {'BufReadPost', 'BufNewFile'},
--     config = true,
--     keys = {{
--         ']t',
--         function()
--             require('todo-comments').jump_next()
--         end,
--         desc = 'Next todo comment'
--     }, {
--         '[t',
--         function()
--             require('todo-comments').jump_prev()
--         end,
--         desc = 'Previous todo comment'
--     }, {
--         '<leader>j',
--         '<cmd>TodoTrouble<cr>',
--         desc = 'Todo (Trouble)'
--     }, {
--         'st',
--         '<cmd>TodoTelescope<cr>',
--         desc = 'Todo'
--     }}
-- },
-- ----------------------------------- UI ----------------------------------- --
{ -- notification
    'rcarriga/nvim-notify',
    keys = {{
        '<leader>fn',
        '<cmd>Telescope notify<cr>',
        desc = 'Telescope Notification'
    }},
    config = true
}, { -- tab bar
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {{
        '[b',
        '<cmd>BufferLineCyclePrev<cr>',
        desc = 'Prev Buffer'
    }, {
        ']b',
        '<cmd>BufferLineCycleNext<cr>',
        desc = 'Next Buffer'
    }},
    opts = {
        options = {
            numbers = 'ordinal',
            buffer_close_icon = '',
            close_icon = '',
            diagnostics = 'nvim_lsp',
            separator_style = {'', ''},
            offsets = {{
                filetype = 'NvimTree',
                text = 'NvimTree',
                highlight = 'Directory',
                text_align = 'left'
            }}
        }
    }
}, { -- status bar
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
        options = {
            icons_enabled = false,
            globalstatus = true,
            component_separators = {
                left = '',
                right = ''
            },
            section_separators = {
                left = '',
                right = ''
            }
        },
        sections = {
            lualine_x = {'location'},
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
            }, 'filetype'}
        }
    }
}, { -- indent guides
    'lukas-reineke/indent-blankline.nvim',
    event = {'BufReadPost', 'BufNewFile'},
    opts = {
        char = '|',
        show_end_of_line = true,
        show_trailing_blankline_indent = false
    }
}, { -- keymaps helper
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {}
}}
