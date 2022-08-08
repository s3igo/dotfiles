require('plugins')

local o = vim.opt

-- config
o.clipboard:append({ unnamedeplus = true })
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.mouse = 'a'
vim.env.LANG = 'en_US.UTF-8'

-- appearence
o.ambiwidth = 'double'
o.cmdheight = 1
o.emoji = true
o.fileformats = "unix,dos,mac"
o.list = true
o.listchars = {
    space = '･',
    tab = '>-',
    eol = '¬',
    extends = '»',
    precedes = '«',
    nbsp = '+'
}
vim.cmd [[ highlight NonText ctermfg=59 ctermbg=None guifg=None guibg=NONE ]]
vim.cmd [[ highlight SpecialKey ctermfg=59 ctermbg=None guifg=None guibg=NONE ]]
o.number = true
o.showmatch = true
o.matchtime = 1
o.showtabline = 2
o.visualbell = true

-- tab
o.expandtab = true
o.shiftwidth = 4
o.smarttab = true
o.softtabstop = 4
o.tabstop = 4

-- keybind
vim.g.mapleader = ' '

-- case
o.ignorecase = true
o.smartcase = true
o.wrapscan = true

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = 'plugins.lua',
    command = 'PackerCompile',
})
