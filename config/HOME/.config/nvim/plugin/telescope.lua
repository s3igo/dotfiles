local status, telescope = pcall(require, 'telescope')
if (not status) then return end

local builtin = require('telescope.builtin')

telescope.load_extension('fzf')
telescope.load_extension('frecency')
telescope.load_extension('ghq')

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

map.set('n', 'sp', function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
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
