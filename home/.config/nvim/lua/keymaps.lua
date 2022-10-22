local map = vim.keymap

vim.g.mapleader = ' '

-- window
map.set('n', 's', '<nop>')

map.set('n', 'sh', '<C-w>h')
map.set('n', 'sj', '<C-w>j')
map.set('n', 'sk', '<C-w>k')
map.set('n', 'sl', '<C-w>l')

map.set('n', 'ss', '<C-w>s')
map.set('n', 'sv', '<C-w>v')

map.set('n', 'sn', '<cmd>bn<cr>')
map.set('n', 'sp', '<cmd>bp<cr>')
map.set('n', 'sd', '<cmd>bd<cr>')

-- telescope
--[[ map.set('n', '<leader>c', '<cmd>Telescope commands<cr>')
map.set('n', '<leader>g', '<cmd>Telescope live_grep hidden=true<cr>')
map.set('n', '<leader>b', '<cmd>Telescope buffers<cr>')
map.set('n', '<leader>fr', '<cmd>Telescope frecency<cr>')
map.set('n', '<leader>ch', '<cmd>Telescope command_history<cr>') ]]
