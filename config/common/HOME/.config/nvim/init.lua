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

require('shared.keymaps')

if vim.g.vscode then
    require('vscode.keymaps')
else
    require('term.keymaps')
end

require('plugin')
