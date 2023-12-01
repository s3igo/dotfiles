-- language
vim.env.LANG = 'en_US.UTF-8'
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

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

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
