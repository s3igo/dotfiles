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

if not vim.g.vscode then
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

require('shared.keymaps')
require('shared.autocmds')

if vim.g.vscode then
    require('vscode.keymaps')
else
    require('term.keymaps')
    require('term.autocmds')
end

require('plugin')
