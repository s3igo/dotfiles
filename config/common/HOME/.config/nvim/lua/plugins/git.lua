return {
    { -- git client
        'NeogitOrg/neogit',
        cond = not vim.g.vscode,
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
    {
        'kaarmu/typst.vim',
        ft = 'typst',
    },
}
