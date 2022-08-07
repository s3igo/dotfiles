require('plugins')

local o = vim.opt
local l = vim.opt_local
local g = vim.opt_global

-- config
-- o.langmenu = 'en_US'

-- appearence
o.number = true
o.ambiwidth = 'single'
-- o.list = true

-- tab
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true
o.smarttab = true


vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
