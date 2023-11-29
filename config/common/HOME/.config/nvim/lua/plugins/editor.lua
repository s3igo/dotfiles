return {
    { -- explorer
        'nvim-tree/nvim-tree.lua',
        cond = not vim.g.vscode,
        version = '*',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = {
            { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle explorer' },
            { '<leader>o', '<cmd>NvimTreeFindFile<cr>', desc = 'Focus current file in explorer' },
        },
        opts = {
            filters = {
                custom = { '^\\.git' },
                git_ignored = false,
            },
        },
        config = function(_, opts)
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require('nvim-tree').setup(opts)
        end,
    },
    { -- fuzzy finder
        'nvim-telescope/telescope.nvim',
        cond = not vim.g.vscode,
        cmd = 'Telescope',
        keys = {
            { '<leader><space>', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
            { '<leader><tab>', '<cmd>Telescope buffers<cr>', desc = 'Switch buffer' },
            { '<leader>/', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
            { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command history' },
            { '<leader>:', '<cmd>Telescope registers<cr>', desc = 'Registers' },
        },
        config = function()
            local config = require('telescope.config')
            local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

            table.insert(vimgrep_arguments, '--hidden')
            table.insert(vimgrep_arguments, '--glob')
            table.insert(vimgrep_arguments, '!.git/*')

            local action = require('telescope.actions')

            require('telescope').setup({
                defaults = {
                    vimgrep_arguments = vimgrep_arguments,
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-k>'] = false,
                            ['<C-a>'] = { '<Home>', type = 'command' },
                            ['<C-e>'] = { '<End>', type = 'command' },
                            ['<C-[>'] = action.close,
                        },
                    },
                    file_ignore_patterns = { '.git', 'node_modules' },
                },
                pickers = { find_files = { hidden = true } },
            })
        end,
    },
    { -- gutter indicator
        'lewis6991/gitsigns.nvim',
        cond = not vim.g.vscode,
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
        cond = not vim.g.vscode,
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            vim.keymap.set(
                'n',
                'n',
                "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require('hlslens').start()<cr>",
                { desc = 'hlslens n' }
            )
            vim.keymap.set(
                'n',
                'N',
                "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require('hlslens').start()<cr>",
                { desc = 'hlslens N' }
            )
            vim.keymap.set('n', '*', "*<cmd>lua require('hlslens').start()<cr>", { desc = 'hlslens *' })
            vim.keymap.set('n', '#', "#<cmd>lua require('hlslens').start()<cr>", { desc = 'hlslens #' })
            vim.keymap.set('n', 'g*', "g*<cmd>lua require('hlslens').start()<cr>", { desc = 'hlslens g*' })
            vim.keymap.set('n', 'g#', "g#<cmd>lua require('hlslens').start()<cr>", { desc = 'hlslens g#' })
        end,
    },
    { -- scrollbar
        'petertriho/nvim-scrollbar',
        cond = not vim.g.vscode,
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
        cond = not vim.g.vscode,
        event = 'BufEnter',
        config = function() require('colorizer').setup() end,
    },
    { -- buffer remove
        'echasnovski/mini.bufremove',
        cond = not vim.g.vscode,
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
}
