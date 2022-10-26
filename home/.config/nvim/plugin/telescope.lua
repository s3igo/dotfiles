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
map.set('n', '<C-n>', function()
    builtin.live_grep()
end)
map.set('n', '<tab>', function()
    builtin.buffers()
end)
map.set('n', '<C-h>', function()
    builtin.help_tags()
end)
map.set('n', '<CR>', function()
    builtin.command_history()
end)

telescope.load_extension('frecency')
map.set('n', '<C-s>', function()
    telescope.extensions.frecency.frecency()
end)
