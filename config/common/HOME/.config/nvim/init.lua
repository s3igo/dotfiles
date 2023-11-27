-- ---------------------------------- base ---------------------------------- --
-- language
vim.env.LANG = 'en_US.UTF-8'
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
if not vim.g.vscode then
    vim.opt.ambiwidth = 'double'
end

vim.filetype.add({
    extension = {
        typ = 'typst',
    },
})

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
vim.keymap.set({ 'n', 'x' }, 'sy', '"+y', { remap = true })
vim.keymap.set({ 'n', 'x' }, 'sd', '"+d')
vim.keymap.set({ 'n', 'x' }, 'sp', '"+p')
vim.keymap.set({ 'n', 'x' }, 's0', '"0p')
vim.keymap.set({ 'n', 'x' }, 'x', '"_d')
vim.keymap.set({ 'n', 'x' }, 'X', '"_c')

-- files
if not vim.g.vscode then
    vim.keymap.set('n', '<leader>s', '<cmd>w<cr><esc>', { desc = 'Save file' })
    vim.keymap.set('n', '<leader>S', '<cmd>wa<cr><esc>', { desc = 'Save all files' })
    vim.keymap.set('n', '<leader>q', '<cmd>qa<cr>', { desc = 'Quit all' })
end

-- move
vim.keymap.set({ 'n', 'x', 'o' }, 'j', 'gj')
vim.keymap.set({ 'n', 'x', 'o' }, 'k', 'gk')
vim.keymap.set({ 'i', 'c' }, '<A-f>', '<S-Right>')
vim.keymap.set({ 'i', 'c' }, '<A-b>', '<S-Left>')

-- retain visual selection
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- add undo breakpoints
vim.keymap.set('i', ',', ',<C-g>u')
vim.keymap.set('i', '.', '.<C-g>u')
vim.keymap.set('i', ';', ';<C-g>u')

-- emacs style
if not vim.g.vscode then
    local function transpose_chars()
        local line = vim.api.nvim_get_current_line()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))

        -- is line start or line has only 1 char
        if col == 0 or #line == 1 then
            return
        end

        -- is line end
        if col == #line then
            col = col - 1
            vim.api.nvim_win_set_cursor(0, { row, col })
        end

        local lhs_char = line:sub(col, col)
        local rhs_char = line:sub(col + 1, col + 1)

        vim.api.nvim_buf_set_text(0, row - 1, col - 1, row - 1, col + 1, { rhs_char .. lhs_char })
        vim.api.nvim_win_set_cursor(0, { row, col + 1 })
    end

    vim.keymap.set('i', '<C-t>', transpose_chars)

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
    vim.keymap.set('n', '<leader>pl', '<cmd>Lazy<cr>', { desc = 'Lazy' })
    vim.keymap.set('n', '<leader>pm', '<cmd>Mason<cr>', { desc = 'Mason' })
    vim.keymap.set('n', '<leader>pt', '<cmd>Telescope<cr>', { desc = 'Telescope' })
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

-- -------------------------------- autocmds -------------------------------- --
vim.api.nvim_create_autocmd('FileType', {
    desc = 'Set formatoptions',
    command = 'setlocal formatoptions-=ro',
})

if not vim.g.vscode then
    vim.api.nvim_create_autocmd('TermOpen', {
        desc = 'Enter terminal with insert mode',
        command = 'startinsert',
    })

    vim.api.nvim_create_autocmd('FocusLost', {
        desc = 'Save on focus lost',
        command = 'wa',
    })

    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'typst',
        desc = 'Set typst filetype',
        command = 'setlocal shiftwidth=4',
    })
    -- ------------------------------- appearance ------------------------------- --
    vim.opt.termguicolors = true
    vim.opt.pumblend = 25
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
    -- ui = { border = 'single' },
})
