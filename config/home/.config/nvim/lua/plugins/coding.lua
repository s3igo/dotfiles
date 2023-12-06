return {
    { -- snippets
        'L3MON4D3/LuaSnip',
        cond = not vim.g.vscode,
        event = 'InsertEnter',
        version = '2.*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
        },
        config = function()
            local vscode_dir = vim.fs.find('.vscode', {
                upward = true,
                type = 'directory',
                path = vim.fn.getcwd(),
                stop = vim.env.HOME,
            })[1]

            if vscode_dir then
                local snippets = vim.fs.find(function(name) return name:match('%.code%-snippets$') end, {
                    limit = 10,
                    type = 'file',
                    path = vscode_dir,
                })
                local loader = require('luasnip.loaders.from_vscode')
                for _, snippet in pairs(snippets) do
                    loader.load_standalone({ path = snippet })
                end
            end
        end,
    },
    { -- copilot
        'zbirenbaum/copilot.lua',
        cond = not vim.g.vscode,
        event = 'InsertEnter',
        cmd = 'Copilot',
        build = ':Copilot auth',
        opts = {
            filetypes = { yaml = true },
            suggestion = {
                auto_trigger = true,
                keymap = { accept_word = '<C-y>', accept_line = '<C-l>' },
            },
        },
    },
    { -- completion
        'hrsh7th/nvim-cmp',
        cond = not vim.g.vscode,
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
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                formatting = {
                    format = require('lspkind').cmp_format({
                        mode = 'symbol',
                        maxwidth = 50,
                        elipsis_char = '...',
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
                        -- if cmp.visible() and cmp.get_active_entry() then
                        if cmp.visible() then
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
            })
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
            vim.api.nvim_set_hl(0, 'PmenuSel', { link = 'NightflyTurquoiseMode' })
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
        enabled = false,
        event = 'VeryLazy',
        config = function()
            vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<cr>", { desc = 'Spider w' })
            vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<cr>", { desc = 'Spider e' })
            vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<cr>", { desc = 'Spider b' })
            vim.keymap.set(
                { 'n', 'o', 'x' },
                'ge',
                "<cmd>lua require('spider').motion('ge')<cr>",
                { desc = 'Spider ge' }
            )
        end,
    },
    { -- text objects
        'chrisgrieser/nvim-various-textobjs',
        event = 'VeryLazy',
        opts = {
            useDefaultKeymaps = true,
            disabledKeymaps = { 'gc' },
        },
    },
    { -- increment/decrement
        'monaqa/dial.nvim',
        enabled = false,
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
    { -- substitute operator
        'gbprod/substitute.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        keys = {
            { 's', function() require('substitute').operator() end, desc = 'Substitute operator' },
            { 'ss', function() require('substitute').line() end, desc = 'Substitute line' },
            { 'S', function() require('substitute').eol() end, desc = 'Substitute EOL' },
            {
                's',
                function() require('substitute').visual() end,
                mode = 'x',
                desc = 'Substitute operator',
            },
        },
        opts = {},
    },
    { -- empasized comments
        'fangjunzhou/comment-divider.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        keys = {
            {
                '<leader>cl',
                function() require('comment-divider').commentLine() end,
                desc = 'Comment divider line',
            },
            {
                '<leader>cb',
                function() require('comment-divider').commentBox() end,
                desc = 'Comment divider box',
            },
        },
    },
    { -- change case
        'johmsalas/text-case.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {},
    },
}
