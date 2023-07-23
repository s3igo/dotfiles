-- ---------------------------------- base ---------------------------------- --
-- language
vim.env.LANG = 'en_US.UTF-8'
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.ambiwidth = 'double'

-- files
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.wildmenu = true

-- workbench
vim.opt.cmdheight = 0
vim.opt.showtabline = 2
vim.opt.showcmd = true

--- indent
vim.opt.expandtab = true
vim.opt.shiftwidth = 0
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.softtabstop = -1
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.breakindent = true

-- config
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.visualbell = true
vim.opt.emoji = true
vim.opt.backup = false
vim.opt.shell = 'zsh'

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- insert
-- vim.opt.textwidth = 120

-- --------------------------------- keymaps -------------------------------- --
vim.g.mapleader = ' '

-- disable
vim.keymap.set('n', 's', '<nop>')
vim.keymap.set('n', 't', '<nop>')

-- buffer
vim.keymap.set('n', '<C-w>n', '<cmd>bn<cr>')
vim.keymap.set('n', '<C-w><C-n>', '<cmd>bn<cr>')
vim.keymap.set('n', '<C-w>p', '<cmd>bp<cr>')
vim.keymap.set('n', '<C-w><C-p>', '<cmd>bp<cr>')

-- misc
vim.keymap.set('n', 'Y', 'y$')
-- vim.keymap.set('n', 'sd', '"_d')
vim.keymap.set('i', '<C-s>', '<C-d>')

-- emacs like keybindings

-- bufferline
-- vim.keymap.set('n', 's.', '<cmd>BufferLineMoveNext<cr>')
-- vim.keymap.set('n', 's,', '<cmd>BufferLineMovePrev<cr>')

-- cursor
-- vim.keymap.set('n', '<leader>k', '10k')
-- vim.keymap.set('n', '<leader>j', '10j')
--
vim.keymap.set({'c', 'i'}, '<C-d>', '<Del>')
if vim.g.vscode == nil then
    vim.keymap.set({'c', 'i'}, '<C-a>', '<Home>')
    vim.keymap.set({'c', 'i'}, '<C-e>', '<End>')
    vim.keymap.set({'c', 'i'}, '<C-b>', '<Left>')
    vim.keymap.set({'c', 'i'}, '<C-f>', '<Right>')
    vim.keymap.set('i', '<C-p>', '<Up>')
    vim.keymap.set('i', '<C-n>', '<Down>')
    vim.keymap.set('i', '<C-k>', '<Esc>lDa')
    vim.keymap.set('c', '<C-h>', '<BS>')
end


-- ------------------------------- appearance ------------------------------- --
if vim.g.vscode == nil then
    vim.opt.termguicolors = true
    vim.cmd('autocmd colorscheme * highlight Normal      ctermbg=NONE guibg=NONE')
    vim.cmd('autocmd colorscheme * highlight NonText     ctermbg=NONE guibg=NONE')
    vim.cmd('autocmd colorscheme * highlight Folded      ctermbg=NONE guibg=NONE')
    vim.cmd('autocmd colorscheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE')
end


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
    nbsp = '+'
}
vim.opt.laststatus = 2
vim.opt.scrolloff = 5
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80,100,120'

vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.relativenumber = true

vim.opt.title = true

-- --------------------------------- plugins -------------------------------- --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require('plugins'))
