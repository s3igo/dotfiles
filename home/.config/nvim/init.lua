require('plugins')
require('keymaps')

local o = vim.opt

-- appearance
o.termguicolors = true
vim.cmd('colorscheme night-owl')
vim.cmd('highlight Normal ctermbg=NONE guibg=NONE')
vim.cmd('highlight NonText ctermbg=NONE guibg=NONE')
vim.cmd('highlight LineNr ctermbg=NONE guibg=NONE')
vim.cmd('highlight Folded ctermbg=NONE guibg=NONE')
vim.cmd('highlight EndOfBuffer ctermbg=NONE guibg=NONE')
o.background = 'dark'
o.pumblend = 10

-- config
o.clipboard:append({ unnamedeplus = true })
o.mouse = 'a'
o.visualbell = true
o.emoji = true
o.backup = false
o.shell = 'zsh'

-- language
vim.env.LANG = 'en_US.UTF-8'
vim.scriptencoding = 'utf-8'
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.ambiwidth = 'double'

-- files
o.fileformats = "unix,dos,mac"

-- workbench
o.cmdheight = 1
o.showtabline = 2
o.showcmd = true

-- editor
--- render
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

--- highlight
vim.highlight.create( 'NonText', {
    ctermfg = 8,
    ctermbg = None,
    guifg = None,
    guibg = NONE
})
vim.highlight.create( 'SpecialKey', {
    ctermfg = 8,
    ctermbg = None,
    guifg = None,
    guibg = NONE
})
o.showmatch = true
o.matchtime = 1

--- indent
o.expandtab = true
o.shiftwidth = 4
o.smarttab = true
o.autoindent = true
o.smartindent = true
o.softtabstop = 4
o.tabstop = 4
o.wrap = true
o.breakindent = true

--- others
o.relativenumber = true

-- keybind
vim.g.mapleader = ' '

-- search
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
-- o.wrapscan = true デフォでtrueになってるっぽい

-- autocmd
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = 'plugins.lua',
    command = 'PackerCompile'
})
