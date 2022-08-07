require('plugins')

local o = vim.opt

-- config
vim.env.LANG = 'en_US.UTF-8'
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'

-- appearence
o.number = true
o.ambiwidth = 'double'
o.emoji = true
o.cmdheight = 1
o.fileformats = { unix, dos, mac }
o.list = true
o.listchars = { space = '･', tab = '>-', trail = '*', eol = '¬', extends = '»' }
o.visualbell = true

-- tab
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smarttab = true

-- keybind
vim.g.mapleader = " "

-- case
o.ignorecase = true
o.smartcase = true
o.wrapscan = true

vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
