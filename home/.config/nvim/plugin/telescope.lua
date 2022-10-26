local status, telescope = pcall(require, 'telescope')
if (not status) then return end

local builtin = require('telescope.builtin')

telescope.setup {
    defaults = {
        file_ignore_patterns = { '%.git', 'node_modules' },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}

local map = vim.keymap

map.set('n', '<C-p>', function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
    })
end)
map.set('n', '<leader>g', function()
    builtin.live_grep()
end)
map.set('n', '<leader>b', function()
    builtin.buffers()
end)
map.set('n', '<leader>h', function()
    builtin.help_tags()
end)
map.set('n', '<leader>ch', function()
    builtin.command_history()
end)

telescope.load_extension('frecency')
map.set('n', '<leader>fr', function()
    telescope.extensions.frecency.frecency()
end)
