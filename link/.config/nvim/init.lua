require('plugins')

local o = vim.opt
local l = vim.opt_local
local g = vim.opt_global

-- config
vim.env.LANG = 'en_US.UTF-8'
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'

-- appearence
o.number = true
o.ambiwidth = 'double'
o.emoji = true
o.cmdheight = 1
o.ruler = true
o.fileformats = { unix, dos, mac }
o.list = true
o.listchars = { space = '･', tab = '>-', trail = '*', eol = '¬', extends = '»' }

-- tab
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true
o.smarttab = true

-- keybind
vim.g.mapleader = " "

-- case
o.ignorecase = true

vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
