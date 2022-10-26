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
