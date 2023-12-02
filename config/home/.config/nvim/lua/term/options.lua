vim.opt.ambiwidth = 'double'
vim.opt.shell = 'zsh'

-- appearance
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
vim.opt.colorcolumn = { 80, 100, 120 }

vim.opt.showmatch = true
vim.opt.matchtime = 1

vim.opt.title = true
vim.opt.scrolloff = 5
vim.opt.relativenumber = true

vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
