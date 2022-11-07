local o = vim.opt

o.termguicolors = true
vim.cmd('colorscheme nightfly')
vim.cmd('highlight Normal ctermbg=NONE guibg=NONE')
vim.cmd('highlight NonText ctermbg=NONE guibg=NONE')
vim.cmd('highlight LineNr ctermbg=NONE guibg=NONE')
vim.cmd('highlight Folded ctermbg=NONE guibg=NONE')
vim.cmd('highlight EndOfBuffer ctermbg=NONE guibg=NONE')
o.pumblend = 10

o.number = true
o.list = true
o.cursorline = true
o.listchars = {
    space = '･',
    tab = '>-',
    eol = '¬',
    extends = '»',
    precedes = '«',
    nbsp = '+'
}
o.laststatus = 2
o.scrolloff = 5
o.signcolumn = 'yes'
o.colorcolumn = '80,100,120'

o.showmatch = true
o.matchtime = 1
o.relativenumber = true
