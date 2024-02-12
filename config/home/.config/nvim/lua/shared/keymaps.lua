vim.g.mapleader = ' '

vim.keymap.set('n', 'Y', 'y$', { desc = 'Yank to end of line' })
vim.keymap.set({ 'i', 'n' }, '<C-[>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })
vim.keymap.set({ 'n', 'x', 'o' }, 'gm', '%', { desc = 'Go to matching bracket' })

-- disable
vim.keymap.set('n', 's', '<nop>')
vim.keymap.set('n', 'x', '<nop>')

-- windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window', remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window', remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true })
vim.keymap.set('n', '<C-w>d', '<C-w>c', { desc = 'Close window', remap = true })

-- ratain cursor position
-- vim.keymap.set('v', 'y', 'ygv<esc>')

-- registers
-- vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { remap = true })
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<leader>Y', '"+yg_')
vim.keymap.set({ 'n', 'x' }, '<leader>d', '"+d')
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'x' }, '<leader>0', '"0p')
vim.keymap.set({ 'n', 'x' }, 'x', '"_d')
vim.keymap.set({ 'n', 'x' }, 'X', '"_c')

-- move
vim.keymap.set({ 'n', 'x', 'o' }, 'j', 'gj')
vim.keymap.set({ 'n', 'x', 'o' }, 'k', 'gk')
vim.keymap.set({ 'n', 'x', 'o' }, 'gj', 'j')
vim.keymap.set({ 'n', 'x', 'o' }, 'gk', 'k')
vim.keymap.set({ 'i', 'c' }, '<A-f>', '<C-g>U<S-Right>')
vim.keymap.set({ 'i', 'c' }, '<A-b>', '<C-g>U<S-Left>')

-- indent
vim.keymap.set('i', '<tab>', '<C-t>')
vim.keymap.set('i', '<s-tab>', '<C-d>')

-- retain visual selection
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- add undo breakpoints
vim.keymap.set('i', ',', ',<C-g>u')
vim.keymap.set('i', '.', '.<C-g>u')
vim.keymap.set('i', ';', ';<C-g>u')

-- helix style
vim.keymap.set({ 'n', 'x', 'o' }, 'gl', 'g_')
vim.keymap.set({ 'n', 'x', 'o' }, 'gh', 'g^')

-- macros
vim.fn.setreg('c', 'gccyypgcc')
vim.fn.setreg('v', 'ypgvgc')
vim.fn.setreg('n', '*Ncgn')
