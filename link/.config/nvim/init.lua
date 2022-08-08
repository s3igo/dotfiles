require('plugins')

local o = vim.opt

-- config
o.clipboard:append({ unnamedeplus = true })
o.mouse = 'a'
o.visualbell = true
o.emoji = true

-- language
vim.env.LANG = 'en_US.UTF-8'
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.ambiwidth = 'double'

-- files
o.fileformats = "unix,dos,mac"

-- workbench
o.cmdheight = 1
o.showtabline = 2

-- editor
--- render
o.number = true
o.list = true
o.listchars = {
    space = '･',
    tab = '>-',
    eol = '¬',
    extends = '»',
    precedes = '«',
    nbsp = '+'
}
--- highlight
vim.cmd [[ highlight NonText ctermfg=59 ctermbg=None guifg=None guibg=NONE ]]
vim.cmd [[ highlight SpecialKey ctermfg=59 ctermbg=None guifg=None guibg=NONE ]]
o.showmatch = true
o.matchtime = 1
--- tab
o.expandtab = true
o.shiftwidth = 4
o.smarttab = true
o.softtabstop = 4
o.tabstop = 4

-- keybind
vim.g.mapleader = ' '

-- search
o.ignorecase = true
o.smartcase = true
o.wrapscan = true

-- autocmd
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = 'plugins.lua',
    command = 'PackerCompile',
})
