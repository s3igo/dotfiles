-- ---------------------------------- base ---------------------------------- --
-- language
vim.env.LANG = 'en_US.UTF-8'
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
if not vim.g.vscode then
    vim.opt.ambiwidth = 'double'
end

-- files
vim.opt.fileformats = 'unix,dos,mac'

-- workbench
vim.opt.cmdheight = 0
vim.opt.showtabline = 2

--- indent
local indent_size = 4
local tab_width = 4
vim.opt.shiftwidth = indent_size
vim.opt.softtabstop = indent_size
vim.opt.tabstop = tab_width
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- config
vim.opt.mouse = 'a'
vim.opt.visualbell = true
vim.opt.emoji = true
vim.opt.backup = false
if not vim.g.vscode then
    vim.opt.shell = 'zsh'
end

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- --------------------------------- keymaps -------------------------------- --
vim.g.mapleader = ' '

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
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { remap = true })
vim.keymap.set({ 'n', 'x' }, '<leader>d', '"+d')
vim.keymap.set({ 'n', 'x' }, '<leader>x', '"+x')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>0', '"0p')
vim.keymap.set({ 'n', 'x' }, 'sd', '"_d')
vim.keymap.set({ 'n', 'x' }, 'sx', '"_x')
vim.keymap.set({ 'n', 'x' }, 'sc', '"_c')

-- files
if not vim.g.vscode then
    vim.keymap.set({ 'n', 'x', 's' }, '<leader>w', '<cmd>w<cr><esc>', { desc = 'Save file' })
    vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })
    vim.keymap.set('n', '<leader>qw', '<cmd>wqa<cr>', { desc = 'Save and quit all' })
end

-- cursor
vim.keymap.set({ 'n', 'x' }, '<leader>k', '10k', { desc = 'Move 10 lines up' })
vim.keymap.set({ 'n', 'x' }, '<leader>j', '10j', { desc = 'Move 10 lines down' })

-- retain visual selection
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- add undo breakpoints
vim.keymap.set('i', ',', ',<C-g>u')
vim.keymap.set('i', '.', '.<C-g>u')
vim.keymap.set('i', ';', ';<C-g>u')

-- emacs style
if not vim.g.vscode then
    vim.keymap.set('i', '<C-f>', '<C-g>U<Right>')
    vim.keymap.set('i', '<C-b>', '<C-g>U<Left>')
    vim.keymap.set('i', '<C-p>', '<C-g>U<Up>')
    vim.keymap.set('i', '<C-n>', '<C-g>U<Down>')
    vim.keymap.set('i', '<C-a>', '<C-g>U<Home>')
    vim.keymap.set('i', '<C-e>', '<C-g>U<End>')

    vim.keymap.set({ 'c', 'i' }, '<C-d>', '<Del>')
    vim.keymap.set('c', '<C-f>', '<Right>')
    vim.keymap.set('c', '<C-b>', '<Left>')
    vim.keymap.set('c', '<C-a>', '<Home>')
    vim.keymap.set('c', '<C-e>', '<End>')

    vim.keymap.set('i', '<C-k>', '<esc>lDa')
    vim.keymap.set('c', '<C-h>', '<bs>')
end

-- helix style
vim.keymap.set({ 'n', 'x', 'o' }, 'gl', 'g_')
vim.keymap.set({ 'n', 'x', 'o' }, 'gh', '^')

-- plugins
if not vim.g.vscode then
    vim.keymap.set('n', '<leader>il', '<cmd>Lazy<cr>', { desc = 'Lazy' })
    vim.keymap.set('n', '<leader>im', '<cmd>Mason<cr>', { desc = 'Mason' })
    vim.keymap.set('n', '<leader>it', '<cmd>Telescope<cr>', { desc = 'Telescope' })
end

-- misc
vim.keymap.set('n', 'Y', 'y$', { desc = 'Yank to end of line' })
vim.keymap.set({ 'i', 'n' }, '<C-[>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

if not vim.g.vscode then
    vim.keymap.set('t', '<C-]>', '<C-\\><C-n>', { desc = 'Escape terminal mode' })
end

-- vscode
if vim.g.vscode then
    vim.keymap.set('n', '<leader>o', "<cmd>call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')<cr>")
    vim.keymap.set('n', '<leader>lf', "<cmd>call VSCodeNotify('editor.action.formatDocument')<cr>")
end

if not vim.g.vscode then
    -- -------------------------------- autocmds -------------------------------- --
    vim.api.nvim_create_autocmd('TermOpen', {
        desc = 'Enter terminal with insert mode',
        command = 'startinsert',
    })

    vim.api.nvim_create_autocmd('FocusLost', {
        desc = 'Save on focus lost',
        command = 'wa',
    })

    -- ------------------------------- appearance ------------------------------- --
    vim.opt.termguicolors = true
    vim.opt.pumblend = 10
    vim.opt.number = true
    vim.opt.list = true
    vim.opt.cursorline = true
    vim.opt.listchars = {
        space = '･',
        tab = '>-',
        eol = '¬',
        extends = '»',
        precedes = '«',
        nbsp = '+',
    }
    vim.opt.laststatus = 2
    vim.opt.signcolumn = 'yes'
    vim.opt.colorcolumn = '80,100,120'

    vim.opt.showmatch = true
    vim.opt.matchtime = 1

    vim.opt.title = true
    vim.opt.scrolloff = 5
    vim.opt.relativenumber = true
end

-- --------------------------------- plugins -------------------------------- --
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(require('plugins'), {
    defaults = { lazy = true },
    ui = { border = 'single' },
})
