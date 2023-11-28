vim.g.mapleader = ' '

vim.keymap.set('n', 'Y', 'y$', { desc = 'Yank to end of line' })
vim.keymap.set({ 'i', 'n' }, '<C-[>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- disable
vim.keymap.set('n', 's', '<nop>')

-- windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window', remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window', remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true })
vim.keymap.set('n', '<C-w>d', '<C-w>c', { desc = 'Close window', remap = true })

-- ratain cursor position
vim.keymap.set('v', 'y', 'ygv<esc>')

-- registers
vim.keymap.set({ 'n', 'x' }, 'sy', '"+y', { remap = true })
vim.keymap.set({ 'n', 'x' }, 'sd', '"+d')
vim.keymap.set({ 'n', 'x' }, 'sp', '"+p')
vim.keymap.set({ 'n', 'x' }, 's0', '"0p')
vim.keymap.set({ 'n', 'x' }, 'x', '"_d')
vim.keymap.set({ 'n', 'x' }, 'X', '"_c')

-- move
vim.keymap.set({ 'n', 'x', 'o' }, 'j', 'gj')
vim.keymap.set({ 'n', 'x', 'o' }, 'k', 'gk')
vim.keymap.set({ 'n', 'x', 'o' }, 'gj', 'j')
vim.keymap.set({ 'n', 'x', 'o' }, 'gk', 'k')
vim.keymap.set({ 'i', 'c' }, '<A-f>', '<C-g>U<S-Right>')
vim.keymap.set({ 'i', 'c' }, '<A-b>', '<C-g>U<S-Left>')

-- retain visual selection
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- add undo breakpoints
vim.keymap.set('i', ',', ',<C-g>u')
vim.keymap.set('i', '.', '.<C-g>u')
vim.keymap.set('i', ';', ';<C-g>u')

-- helix style
vim.keymap.set({ 'n', 'x', 'o' }, 'gl', 'g_')
vim.keymap.set({ 'n', 'x', 'o' }, 'gh', '^')
