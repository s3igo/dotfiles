return {
    { -- LSP
        'neovim/nvim-lspconfig',
        cond = not vim.g.vscode,
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
            },
            {
                'folke/neodev.nvim',
                event = 'LspAttach',
            },
            'creativenull/efmls-configs-nvim',
            'hrsh7th/cmp-nvim-lsp',
            'ray-x/lsp_signature.nvim',
        },
        config = function()
            require('neodev').setup({
                override = function(root_dir, library)
                    if root_dir:match('.dotfiles') then
                        library.enable = true
                        library.plugins = true
                    end
                end,
            })
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

            -- local function disable_formatting(client)
            --     client.resolved_capabilities.document_formatting = false
            --     client.resolved_capabilities.document_range_formatting = false
            -- end

            lspconfig.efm.setup({
                filetypes = vim.tbl_keys(languages),
                settings = { rootMarkers = { '.git/' }, languages = languages },
                init_options = { documentFormatting = true, documentRangeFormatting = true },
            })

            lspconfig.lua_ls.setup({
                -- settings = {
                --     Lua = {
                --         runtime = { version = 'LuaJIT' },
                --     },
                -- },
                -- on_attach = disable_formatting,
                on_init = function(client) client.server_capabilities.documentFormattingProvider = false end,
            })

            lspconfig.clangd.setup({
                -- capabilities = lsp_capabilities,
                cmd = { 'clangd', '--offset-encoding=utf-8' },
            })

            lspconfig.rust_analyzer.setup({
                settings = {
                    ['rust-analyzer'] = {
                        checkOnSave = { command = 'clippy' },
                        files = { excludeDirs = { '.direnv' } },
                    },
                },
                capabilities = (function()
                    local capabilities = lsp_capabilities
                    capabilities.textDocument.completion.completionItem.resolveSupport = {
                        properties = { 'documentation', 'detail', 'additionalTextEdits' },
                    }
                    return capabilities
                end)(),
            })

            -- require('lsp_signature').setup({
            --     bind = true,
            --     handler_opts = { border = 'single' },
            -- })

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP Actions',
                callback = function()
                    vim.keymap.set('n', '<leader>i', '<cmd>LspInfo<cr>', { desc = 'Lsp Info' })
                    vim.keymap.set(
                        'n',
                        '<leader>A',
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
                    vim.keymap.set('n', '<leader>.', vim.diagnostic.open_float, { desc = 'Line diagnostics' })
                    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = 'Rename' }) -- FIXME: dressing error
                    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format' })
                    vim.keymap.set('v', '<leader>f', function()
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
                    vim.keymap.set('n', '<leader>F', function()
                        vim.lsp.buf.format()
                        vim.cmd.write()
                        vim.cmd.edit()
                    end, { desc = 'Format and save' })
                    -- TODO: ls, lS -> aerial
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
                    vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, { desc = 'Signature help' })
                    vim.keymap.set(
                        'n',
                        'gr',
                        function() require('telescope.builtin').lsp_references() end,
                        { desc = 'References' }
                    )
                    vim.keymap.set(
                        'n',
                        'gd',
                        function() require('telescope.builtin').lsp_definitions() end,
                        { desc = 'Goto definition' }
                    )
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto declaration' })
                    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto implementation' })
                    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto type definition' })
                    vim.keymap.set('n', 'gs', vim.lsp.buf.workspace_symbol, { desc = 'Workspace symbol' })
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
                    vim.keymap.set(
                        'n',
                        ']e',
                        function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
                        { desc = 'Next error' }
                    )
                    vim.keymap.set(
                        'n',
                        '[e',
                        function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
                        { desc = 'Previous error' }
                    )
                    vim.keymap.set(
                        'n',
                        ']w',
                        function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end,
                        { desc = 'Next warning' }
                    )
                    vim.keymap.set(
                        'n',
                        '[w',
                        function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end,
                        { desc = 'Previous warning' }
                    )
                end,
            })

            -- appearance
            -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
            vim.lsp.handlers['textDocument/hover'] = function(...)
                local _, winnr = vim.lsp.handlers.hover(...)
                if winnr then
                    vim.api.nvim_win_set_option(winnr, 'winblend', 25)
                end
            end
            -- vim.diagnostic.config({ float = { border = 'single' } })
            -- require('lspconfig.ui.windows').default_options.border = 'single'
        end,
    },
    {
        'mickael-menu/zk-nvim',
        cond = not vim.g.vscode,
        event = 'VimEnter',
        keys = {
            { '<leader>zi', '<cmd>ZkInsertLink<cr>', desc = 'Insert Link' },
            {
                '<leader>zi',
                ":'<,'>ZkInsertLinkAtSelection { matchSelected = true }<cr>",
                mode = 'v',
                desc = 'Insert link with selection as query',
            },
            { '<leader>zo', '<cmd>ZkNotes<cr>', desc = 'Open note picker' },
            {
                '<leader>zm',
                ":'<,'>ZkMatch<cr>",
                mode = 'v',
                desc = 'Open note picker with selection as query',
            },
            {
                '<leader>zn',
                -- "<cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<cr>", -- not working
                function()
                    require('zk.commands').get('ZkNew')({
                        dir = vim.fn.expand('%:p:h'),
                        title = vim.fn.input('Title: '),
                    })
                end,
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
        opts = { picker = 'telescope' },
        config = function(_, opts) require('zk').setup(opts) end,
    },
    { -- progress indicator
        'j-hui/fidget.nvim',
        cond = not vim.g.vscode,
        event = 'LspAttach',
        opts = {
            notification = {
                window = { winblend = 0 },
            },
        },
    },
    {
        'folke/trouble.nvim',
        cond = not vim.g.vscode,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'LspAttach',
        keys = {
            { '<leader>xx', function() require('trouble').toggle() end, desc = 'Trouble' },
        },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
}
