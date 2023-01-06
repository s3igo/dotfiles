local status, nvim_tree = pcall(require, 'nvim-tree')
if (not status) then return end

local map = vim.keymap
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup({
    view = {
        mappings = {
            list = {
                { key = 's', action = '' },
                { key = 'so', action = 'system_open' },
            }
        }
    },
    filters = {
        custom = {
            '\\.git$',
            '.cache$',
        }
    }
})

map.set('n', 'sb', ':NvimTreeToggle<CR>')
vim.cmd('highlight NvimTreeNormal ctermbg=NONE guibg=NONE')
