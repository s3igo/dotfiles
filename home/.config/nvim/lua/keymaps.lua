local map = vim.keymap

vim.g.mapleader = ' '

-- window
map.set('n', 's', '<nop>')
map.set('n', 't', '<nop>')

map.set('n', 'sh', '<C-w>h')
map.set('n', 'sj', '<C-w>j')
map.set('n', 'sk', '<C-w>k')
map.set('n', 'sl', '<C-w>l')

map.set('n', 'ss', '<C-w>s')
map.set('n', 'sv', '<C-w>v')

map.set('n', 'sn', '<cmd>bn<cr>')
map.set('n', 'sp', '<cmd>bp<cr>')
map.set('n', 'sw', '<cmd>bd<cr>')

--misc
-- map.set('i', '<C-t>', '<esc>"zx"zpa')
map.set('n', 'Y', 'y$')
map.set('n', 'sd', '"_d')
map.set('i', '<C-s>', '<C-d>')


-- emacs like keybindings
map.set({ 'c', 'i' }, '<C-a>', '<Home>')
map.set({ 'c', 'i' }, '<C-e>', '<End>')
map.set({ 'c', 'i' }, '<C-b>', '<Left>')
map.set({ 'c', 'i' }, '<C-f>', '<Right>')
map.set({ 'c', 'i' }, '<C-d>', '<Del>')
map.set('i', '<C-p>', '<Up>')
map.set('i', '<C-n>', '<Down>')
map.set('i', '<C-k>', '<Esc>lDa')
map.set('c', '<C-h>', '<BS>')
