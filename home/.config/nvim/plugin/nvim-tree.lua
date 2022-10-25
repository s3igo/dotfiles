local status, nvim_tree = pcall(require, 'nvim-tree')
if (not status) then return end

local map = vim.keymap
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup({
    -- hijack_netrw = true,
})

map.set('n', '<leader>b', ':NvimTreeToggle<CR>')
