local map = vim.keymap.set
local function is_not_vscode() return vim.g.vscode == nil or false end
return {
    { -- colorscheme
        'bluz71/vim-nightfly-guicolors',
        cond = is_not_vscode,
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.nightflyNormalFloat = true
            vim.g.nightflyTransparent = true
            vim.g.nightflyVirtualTextColor = true
            vim.g.nightflyWinSeparator = 2
            vim.cmd('colorscheme nightfly')
        end,
    },
    -- ---------------------------------- Util ---------------------------------- --
    { -- benchmark
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        keys = { { '<leader>ib', '<cmd>StartupTime<cr>', desc = 'Benchmark' } },
        init = function() vim.g.startuptime_tries = 10 end,
    },
    { -- utility functions
        'nvim-lua/plenary.nvim',
    },
    -- --------------------------------- Coding --------------------------------- --
    { -- snippets
        'L3MON4D3/LuaSnip',
        cond = is_not_vscode,
        event = 'InsertEnter',
        version = '2.*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
        },
    },
    { -- copilot
        'zbirenbaum/copilot.lua',
        cond = is_not_vscode,
        event = 'InsertEnter',
        cmd = 'Copilot',
        build = ':Copilot auth',
        opts = {
            filetypes = { markdown = true, yaml = true },
            suggestion = {
                auto_trigger = true,
                keymap = { accept_word = '<C-y>', accept_line = '<C-l>' },
            },
        },
    },
    { -- completion
        'hrsh7th/nvim-cmp',
        cond = is_not_vscode,
        event = { 'InsertEnter', 'ModeChanged' },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-cmdline',
            { -- icons
                'onsails/lspkind.nvim',
                opts = { mode = 'symbol' },
                config = function(_, opts) require('lspkind').init(opts) end,
            },
        },
        opts = function()
            local cmp = require('cmp')
            return {
                formatting = {
                    format = require('lspkind').cmp_format({
                        mode = 'symbol',
                        maxwidth = 50,
                        elipsis_char = '...',
                    }),
                },
                window = {
                    completion = cmp.config.window.bordered({
                        border = 'single',
                        winhighlight = 'Normal:Pmenu',
                    }),
                    documentation = cmp.config.window.bordered({
                        border = 'single',
                        winhighlight = 'Normal:Pmenu',
                    }),
                },
                snippet = {
                    expand = function(args) require('luasnip').lsp_expand(args.body) end,
                },
                mapping = {
                    ['<C-j>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            cmp.complete()
                        end
                    end),
                    ['<C-k>'] = cmp.mapping(function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<tab>'] = cmp.mapping.confirm(),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                }),
            }
        end,
        config = function(_, opts)
            local cmp = require('cmp')
            cmp.setup(opts)
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp_document_symbol' },
                    { name = 'buffer' },
                }),
            })
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
            })
        end,
    },
    { -- autopair
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        opts = {},
    },
    { -- surround selection
        'kylechui/nvim-surround',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {},
    },
    { -- comment
        'numToStr/Comment.nvim',
        dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
        event = 'VeryLazy',
        opts = function()
            -- local is_available, ts_integration = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
            -- return is_available and { pre_hook = ts_integration.create_pre_hook() } or {}
            return { pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook() }
        end,
    },
    { -- subword motion
        'chrisgrieser/nvim-spider',
        event = 'VeryLazy',
        config = function()
            map({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<cr>", { desc = 'Spider w' })
            map({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<cr>", { desc = 'Spider e' })
            map({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<cr>", { desc = 'Spider b' })
            map({ 'n', 'o', 'x' }, 'ge', "<cmd>lua require('spider').motion('ge')<cr>", { desc = 'Spider ge' })
        end,
    },
    {
        'monaqa/dial.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        keys = {
            { '<C-a>', function() require('dial.map').manipulate('increment', 'normal') end, desc = 'Dial <C-a>' },
            { '<C-x>', function() require('dial.map').manipulate('decrement', 'normal') end, desc = 'Dial <C-x>' },
            { 'g<C-a>', function() require('dial.map').manipulate('increment', 'gnormal') end, desc = 'Dial g<C-a>' },
            { 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gnormal') end, desc = 'Dial g<C-x>' },
            {
                '<C-a>',
                function() require('dial.map').manipulate('increment', 'visual') end,
                mode = 'v',
                desc = 'Dial in VISUAL <C-a>',
            },
            {
                '<C-x>',
                function() require('dial.map').manipulate('decrement', 'visual') end,
                mode = 'v',
                desc = 'Dial in VISUAL <C-x>',
            },
            {
                'g<C-a>',
                function() require('dial.map').manipulate('increment', 'gvisual') end,
                mode = 'v',
                desc = 'Dial in VISUAL g<C-a>',
            },
            {
                'g<C-x>',
                function() require('dial.map').manipulate('decrement', 'gvisual') end,
                mode = 'v',
                desc = 'Dial in VISUAL g<C-x>',
            },
        },
        config = function()
            local augend = require('dial.augend')
            require('dial.config').augends:register_group({
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.decimal_int,
                    augend.integer.alias.binary,
                    augend.integer.alias.hex,
                    augend.date.alias['%Y/%m/%d'],
                    augend.date.alias['%Y-%m-%d'],
                    augend.date.alias['%m/%d'],
                    augend.date.alias['%H:%M'],
                    augend.constant.alias.ja_weekday,
                    augend.constant.alias.ja_weekday_full,
                    augend.constant.alias.bool,
                    augend.constant.alias.alpha,
                    augend.constant.alias.Alpha,
                    augend.semver.alias.semver,
                },
            })
        end,
    },
    -- --- TreeSitter --- --
    { -- treesitter
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'JoosepAlviste/nvim-ts-context-commentstring',
            'RRethy/nvim-treesitter-endwise',
            { 'HiPhish/rainbow-delimiters.nvim', cond = is_not_vscode },
        },
        cmd = { 'TSUpdateSync' },
        opts = {
            highlight = { enable = is_not_vscode() },
            indent = { enable = true },
            auto_install = true,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 'se',
                    node_incremental = 'se',
                    scope_incremental = 'ss',
                    node_decremental = 'sa',
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
            context_commentstring = { enable = true },
            endwise = { enable = true },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
            local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
            parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
            if is_not_vscode() then
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
        end,
    },
    { -- sticky scroll
        'nvim-treesitter/nvim-treesitter-context',
        cond = is_not_vscode,
        event = { 'BufReadPost', 'BufNewFile' },
    },
    -- --- LSP --- --
    { -- LSP
        'neovim/nvim-lspconfig',
        cond = is_not_vscode,
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            {
                'folke/neoconf.nvim',
                cmd = 'Neoconf',
                opts = {},
            },
            {
                'williamboman/mason-lspconfig.nvim',
                cmd = { 'LspInstall', 'LspUninstall' },
                opts = {},
            },
            {
                'williamboman/mason.nvim',
                cmd = { 'Mason' },
                build = ':MasonUpdate',
                opts = { ui = { border = 'single' } },
            },
            'creativenull/efmls-configs-nvim',
            'hrsh7th/cmp-nvim-lsp',
            'ray-x/lsp_signature.nvim',
        },
        config = function()
            require('mason').setup()
            local mason_lspconfig = require('mason-lspconfig')
            mason_lspconfig.setup({
                -- ensure_installed = {'rust_analyzer', 'tsserver'}
            })
            local lspconfig = require('lspconfig')
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            mason_lspconfig.setup_handlers({
                function(server)
                    lspconfig[server].setup({
                        capabilities = lsp_capabilities,
                        -- autoformat = true
                    })
                end,
            })
            local languages = {
                -- typescript = {eslint, prettier},
                lua = { require('efmls-configs.formatters.stylua') },
            }
            lspconfig.efm.setup({
                filetypes = vim.tbl_keys(languages),
                settings = { rootMarkers = { '.git/' }, languages = languages },
                init_options = { documentFormatting = true, documentRangeFormatting = true },
            })

            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim' } },
                    },
                },
            })

            lspconfig.rust_analyzer.setup({
                settings = {
                    ['rust-analyzer'] = { checkOnSave = { command = 'clippy' } },
                },
            })

            require('lsp_signature').setup({
                bind = true,
                handler_opts = { border = 'single' },
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP Actions',
                callback = function()
                    map('n', '<leader>li', '<cmd>LspInfo<cr>', { desc = 'Info' })
                    map({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, { desc = 'Code action' })
                    map(
                        'n',
                        '<leader>lA',
                        function()
                            vim.lsp.buf.code_action({
                                context = {
                                    only = {
                                        'source',
                                    },
                                    diagnostics = {},
                                },
                            })
                        end,
                        { desc = 'Source action' }
                    )
                    map('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'Line diagnostics' })
                    map('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename' }) -- FIXME: dressing error
                    map('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format' })
                    map('v', '<leader>lf', function()
                        local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, '<'))
                        local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, '>'))
                        vim.lsp.buf.format({
                            range = {
                                ['start'] = { start_row, 0 },
                                ['end'] = { end_row, 0 },
                            },
                            async = true,
                        })
                    end, { desc = 'Range format' })
                    map('n', '<leader>lF', function()
                        vim.lsp.buf.format()
                        vim.cmd.write()
                        vim.cmd.edit()
                    end, { desc = 'Format and save' })
                    -- TODO: ls, lS -> aerial
                    map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
                    map('n', 'gK', vim.lsp.buf.signature_help, { desc = 'Signature help' })
                    map(
                        'n',
                        'gr',
                        function() require('telescope.builtin').lsp_references() end,
                        { desc = 'References' }
                    )
                    map(
                        'n',
                        'gd',
                        function() require('telescope.builtin').lsp_definitions() end,
                        { desc = 'Goto definition' }
                    )
                    map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto declaration' })
                    map('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto implementation' })
                    map('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto type definition' })
                    map('n', 'gs', vim.lsp.buf.workspace_symbol, { desc = 'Workspace symbol' })
                    map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
                    map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
                    map(
                        'n',
                        ']e',
                        function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
                        { desc = 'Next error' }
                    )
                    map(
                        'n',
                        '[e',
                        function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
                        { desc = 'Previous error' }
                    )
                    map(
                        'n',
                        ']w',
                        function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end,
                        { desc = 'Next warning' }
                    )
                    map(
                        'n',
                        '[w',
                        function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end,
                        { desc = 'Previous warning' }
                    )
                end,
            })

            -- appearance
            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
            vim.diagnostic.config({ float = { border = 'single' } })
            require('lspconfig.ui.windows').default_options.border = 'single'
        end,
    },
    {
        'mickael-menu/zk-nvim',
        cond = is_not_vscode,
        event = 'VimEnter',
        keys = {
            {
                '<leader>zn',
                "<cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<cr>",
                desc = 'New note',
            },
            {
                '<leader>znt',
                ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<cr>",
                mode = 'v',
                desc = 'New note with selection as title',
            },
            {
                '<leader>znc',
                ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<cr>",
                mode = 'v',
                desc = 'New note with selection as content',
            },
            { '<leader>zb', '<cmd>ZkBacklinks<cr>', desc = 'Show backlinks' },
            { '<leader>zl', '<cmd>ZkLinks<cr>', desc = 'Show links' },
        },
        opts = {},
        config = function(_, opts) require('zk').setup(opts) end,
    },
    { -- progress indicator
        'j-hui/fidget.nvim',
        cond = is_not_vscode,
        tag = 'legacy',
        event = 'LspAttach',
        opts = { window = { blend = 0, relative = 'editor' } },
        config = function(_, opts)
            require('fidget').setup(opts)
            vim.api.nvim_set_hl(0, 'FidgetTitle', { link = 'NormalFloat' })
            vim.api.nvim_set_hl(0, 'FidgetTask', { link = 'NormalFloat' })
        end,
    },
    -- --------------------------------- Editor --------------------------------- --
    { -- explorer
        'nvim-tree/nvim-tree.lua',
        cond = is_not_vscode,
        version = '*',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = {
            { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle explorer' },
            { '<leader>r', '<cmd>NvimTreeRefresh<cr>', desc = 'Refresh explorer' },
            { '<leader>o', '<cmd>NvimTreeFindFile<cr>', desc = 'Focus current file in explorer' },
        },
        opts = { filters = { custom = { '.git' } } },
        config = function(_, opts)
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require('nvim-tree').setup(opts)
        end,
    },
    { -- fuzzy finder
        'nvim-telescope/telescope.nvim',
        cond = is_not_vscode,
        cmd = 'Telescope',
        keys = {
            { '<leader><space>', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
            { '<leader><tab>', '<cmd>Telescope buffers<cr>', desc = 'Switch buffer' },
            { '<leader>/', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
            { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command history' },
        },
        opts = {
            defaults = {
                file_ignore_patterns = { '.git', 'node_modules' },
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-k>'] = false,
                        ['<C-a>'] = { '<Home>', type = 'command' },
                        ['<C-e>'] = { '<End>', type = 'command' },
                    },
                },
            },
            pickers = { find_files = { hidden = true } },
        },
    },
    { -- gutter indicator
        'lewis6991/gitsigns.nvim',
        cond = is_not_vscode,
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            signs = {
                add = { text = '|' },
                change = { text = '|' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '|' },
            },
            current_line_blame = true,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local function map_local(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                map_local('n', ']g', gs.next_hunk, { desc = 'Next hunk' })
                map_local('n', '[g', gs.prev_hunk, { desc = 'Previous hunk' })
                map_local('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview hunk' })
                map_local('n', '<leader>gr', gs.reset_hunk, { desc = 'Reset hunk' })
                map_local('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset buffer' })
                map_local('n', '<leader>gs', gs.stage_hunk, { desc = 'Stage hunk' })
                map_local('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage buffer' })
                map_local('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
                -- map_local('n', '<leader>gd', gs.diffthis, { desc = 'View diff' })
                map_local('n', '<leader>gt', gs.toggle_deleted, { desc = 'Toggle deleted' })
                map_local({ 'o', 'x' }, 'ih', ':<C-u>Gitsigns select_hunk<cr>', { desc = 'inside hunk' })
            end,
        },
    },
    { -- search highlight
        'kevinhwang91/nvim-hlslens',
        cond = is_not_vscode,
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            map(
                'n',
                'n',
                "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require('hlslens').start()<cr>",
                { desc = 'hlslens n' }
            )
            map(
                'n',
                'N',
                "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require('hlslens').start()<cr>",
                { desc = 'hlslens N' }
            )
            map('n', '*', "*<cmd>lua require('hlslens').start()<cr>", { desc = 'hlslens *' })
            map('n', '#', "#<cmd>lua require('hlslens').start()<cr>", { desc = 'hlslens #' })
            map('n', 'g*', "g*<cmd>lua require('hlslens').start()<cr>", { desc = 'hlslens g*' })
            map('n', 'g#', "g#<cmd>lua require('hlslens').start()<cr>", { desc = 'hlslens g#' })
        end,
    },
    { -- scrollbar
        'petertriho/nvim-scrollbar',
        cond = is_not_vscode,
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'kevinhwang91/nvim-hlslens',
        },
        config = function()
            require('scrollbar').setup({
                handle = { color = '#1d3b53' },
                marks = { Search = { color = '#ecc48d' } },
            })
            require('scrollbar.handlers.gitsigns').setup()
            require('scrollbar.handlers.search').setup()
        end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        cond = is_not_vscode,
        event = 'BufEnter',
        config = function() require('colorizer').setup() end,
    },
    { -- buffer remove
        'echasnovski/mini.bufremove',
        cond = is_not_vscode,
        keys = {
            {
                '<leader>w',
                function() require('mini.bufremove').delete(0, false) end,
                desc = 'Delete buffer',
            },
            {
                '<leader>W',
                function() require('mini.bufremove').delete(0, true) end,
                desc = 'Force delete buffer',
            },
        },
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
    { -- override components
        'stevearc/dressing.nvim',
        enabled = false,
        cond = is_not_vscode,
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
        cond = is_not_vscode,
        keys = { { '<leader>fn', '<cmd>Telescope notify<cr>', desc = 'Telescope Notification' } },
        config = true,
    },
    { -- tab bar
        'akinsho/bufferline.nvim',
        cond = is_not_vscode,
        event = 'VimEnter',
        keys = {
            { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
            { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
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
        cond = is_not_vscode,
        event = 'VimEnter',
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
            }
        end,
    },
    { -- indent guides
        'lukas-reineke/indent-blankline.nvim',
        cond = is_not_vscode,
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            char = '|',
            show_trailing_blankline_indent = false,
            char_highlight_list = { 'Indent' },
        },
        config = function(_, opts)
            vim.api.nvim_set_hl(0, 'Indent', { fg = '#384B5A' })
            require('indent_blankline').setup(opts)
        end,
    },
    { -- keymaps helper
        'folke/which-key.nvim',
        cond = is_not_vscode,
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
        cond = is_not_vscode,
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
        cond = is_not_vscode,
        ft = 'markdown',
        build = function() vim.fn['mkdp#util#install']() end,
        keys = { { '<leader>v', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Markdown Preview' } },
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
    -- --- Git --- --
    { -- git client
        'NeogitOrg/neogit',
        cond = is_not_vscode,
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
}
