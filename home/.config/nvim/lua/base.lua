local o = vim.opt

-- language
vim.env.LANG = 'en_US.UTF-8'
vim.scriptencoding = 'utf-8'
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.ambiwidth = 'double'

-- files
o.fileformats = 'unix,dos,mac'
o.wildmenu = true

-- workbench
o.cmdheight = 0
o.showtabline = 2
o.showcmd = true

--- indent
o.expandtab = true
o.shiftwidth = 0
o.smarttab = true
o.autoindent = true
o.smartindent = true
o.softtabstop = -1
o.tabstop = 4
o.wrap = true
o.breakindent = true

-- config
o.clipboard = 'unnamedplus'
o.mouse = 'a'
o.visualbell = true
o.emoji = true
o.backup = false
o.shell = 'zsh'

-- search
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
