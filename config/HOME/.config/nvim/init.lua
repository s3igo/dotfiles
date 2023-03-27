-- ---------------------------------- base ---------------------------------- --
-- language
vim.env.LANG = 'en_US.UTF-8'
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.ambiwidth = 'double'

-- files
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.wildmenu = true

-- workbench
vim.opt.cmdheight = 0
vim.opt.showtabline = 2
vim.opt.showcmd = true

--- indent
vim.opt.expandtab = true
vim.opt.shiftwidth = 0
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.softtabstop = -1
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.breakindent = true

-- config
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.visualbell = true
vim.opt.emoji = true
vim.opt.backup = false
vim.opt.shell = 'zsh'

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- insert
-- vim.opt.textwidth = 120

-- --------------------------------- keymaps -------------------------------- --
vim.g.mapleader = ' '

-- disable
vim.keymap.set('n', 's', '<nop>')
vim.keymap.set('n', 't', '<nop>')

-- buffer
vim.keymap.set('n', '<C-w>n', '<cmd>bn<cr>')
vim.keymap.set('n', '<C-w><C-n>', '<cmd>bn<cr>')
vim.keymap.set('n', '<C-w>p', '<cmd>bp<cr>')
vim.keymap.set('n', '<C-w><C-p>', '<cmd>bp<cr>')

-- misc
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('n', 'sd', '"_d')
vim.keymap.set('i', '<C-s>', '<C-d>')

-- emacs like keybindings
vim.keymap.set({'c', 'i'}, '<C-a>', '<Home>')
vim.keymap.set({'c', 'i'}, '<C-e>', '<End>')
vim.keymap.set({'c', 'i'}, '<C-b>', '<Left>')
vim.keymap.set({'c', 'i'}, '<C-f>', '<Right>')
vim.keymap.set({'c', 'i'}, '<C-d>', '<Del>')
vim.keymap.set('i', '<C-p>', '<Up>')
vim.keymap.set('i', '<C-n>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Esc>lDa')
vim.keymap.set('c', '<C-h>', '<BS>')

-- bufferline
vim.keymap.set('n', 's.', '<cmd>BufferLineMoveNext<cr>')
vim.keymap.set('n', 's,', '<cmd>BufferLineMovePrev<cr>')

-- --------------------------------- autocmd -------------------------------- --
vim.api.nvim_create_autocmd({'BufWritePost'}, {
    pattern = 'init.lua',
    command = 'PackerCompile'
})
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- --------------------------------- plugins -------------------------------- --
-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
                                      install_path})
    print("Installing packer")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

require('packer').startup(function(use)
    use({'wbthomason/packer.nvim'})
    use({'nvim-lua/plenary.nvim'})
    use({'kyazdani42/nvim-web-devicons'})
    use({'vim-jp/vimdoc-ja'})
    use({'github/copilot.vim'})
    use({
        'cappyzawa/trim.nvim',
        config = function()
            require('trim').setup({
                disable = {"markdown"},
                patterns = {[[%s/\s\+$//e]]}
            })
        end
    })
    use({
        'bluz71/vim-nightfly-guicolors',
        config = function()
            vim.cmd('colorscheme nightfly')
        end
    })
    use({
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
    })
    use({
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup({
                char = '|',
                show_end_of_line = true,
                show_trailing_blankline_indent = false
                -- tree-sitterが必要
                -- show_current_context = true,
                -- show_current_context_start = true,
            })
        end
    })
    use({
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
    })
    use({
        'b3nj5m1n/kommentary',
        config = function()
            require('kommentary.config').configure_language("default", {
                prefer_single_line_comments = true
            })
        end
    })
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {'windwp/nvim-ts-autotag', 'nvim-treesitter/nvim-treesitter-context'},
        config = function()
            require('nvim-treesitter.configs').setup({
                highlight = {
                    enable = true,
                    disable = {}
                },
                indent = {
                    enable = true,
                    disable = {}
                },
                -- ensure_installed = 'all',
                auto_install = true,
                autotag = {
                    enable = true
                },
                rainbow = {
                    enable = true,
                    extended_mode = false,
                    max_file_lines = 1000
                },
                endwise = {
                    enable = true
                }
            })

            local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
            parser_config.tsx.filetype_to_parsername = {'javascript', 'typescript.tsx'}
        end
    })
    use({
        'nvim-telescope/telescope-frecency.nvim',
        requires = 'kkharji/sqlite.lua'
    })
    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    })
    use({
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-telescope/telescope-ghq.nvim',
        config = function()
            local status, telescope = pcall(require, 'telescope')
            if (not status) then
                return
            end

            local builtin = require('telescope.builtin')

            telescope.load_extension('fzf')
            telescope.load_extension('frecency')
            telescope.load_extension('ghq')

            telescope.setup {
                defaults = {
                    file_ignore_patterns = {'%.git', 'node_modules'}
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case"
                    }
                }
            }

            local map = vim.keymap

            map.set('n', 'sp', function()
                builtin.find_files({
                    hidden = true,
                    no_ignore = true
                })
            end)
            map.set('n', 'sn', function()
                builtin.live_grep()
            end)
            map.set('n', '<tab>', function()
                builtin.buffers()
            end)
            map.set('n', 'sh', function()
                builtin.help_tags()
            end)
            map.set('n', 'sc', function()
                builtin.command_history()
            end)

            map.set('n', '<C-s>', function()
                telescope.extensions.frecency.frecency()
            end)
            map.set('n', '<C-g>', '<cmd>Telescope ghq list<cr>')

        end
    })
    use({
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    })
    use({
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end
    })
    use({
        'akinsho/bufferline.nvim',
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
    })
    use({
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup()
        end
    })
    use({
        'nvim-tree/nvim-tree.lua',
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
    })

    -- completion
    -- use({'kevinhwang91/nvim-hlslens'})
    use {
        "tversteeg/registers.nvim",
        config = function()
            require("registers").setup()
        end
    }
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end
    })
    use({'mickael-menu/zk-nvim'})
end)

-- ------------------------------- appearance ------------------------------- --
vim.opt.termguicolors = true
vim.cmd('autocmd colorscheme * highlight Normal      ctermbg=NONE guibg=NONE')
vim.cmd('autocmd colorscheme * highlight NonText     ctermbg=NONE guibg=NONE')
vim.cmd('autocmd colorscheme * highlight Folded      ctermbg=NONE guibg=NONE')
vim.cmd('autocmd colorscheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE')

vim.opt.pumblend = 10

vim.opt.number = true
vim.opt.list = true
vim.opt.cursorline = true
vim.opt.listchars = {
    space = '･',
    tab = '>-',
    eol = '¬',
    extends = '»',
    precedes = '«',
    nbsp = '+'
}
vim.opt.laststatus = 2
vim.opt.scrolloff = 5
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80,100,120'

vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.relativenumber = true

vim.opt.title = true
