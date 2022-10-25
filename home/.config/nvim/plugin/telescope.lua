local status, telescope = pcall(require, 'telescope')
if (not status) then return end

local builtin = require('telescope.builtin')
local map = vim.keymap

telescope.setup {
    defaults = {
        file_ignore_patterns = { '.git', 'node_modules' },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        file_browser = {
            hijack_netrw = true,
        },
    }
}

-- telescope.load_extension('file_browser')

map.set('n', '<leader>f', function()
    builtin.find_files({
        no_ignore = false,
        hidden = true,
    })
end)

--[[ map.set('n', 'sf', function()
    telescope.extensions.file_browser.file_browser({
        hidden = true,
    })
end) ]]
