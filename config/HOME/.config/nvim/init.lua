-- ---------------------------------- base ---------------------------------- --
-- language
vim.env.LANG = 'en_US.UTF-8'
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.ambiwidth = 'double'

-- files
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.wildmenu = true

-- workbench
vim.opt.cmdheight = 0
vim.opt.showtabline = 2
vim.opt.showcmd = true

--- indent
vim.opt.expandtab = true
vim.opt.shiftwidth = 0
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.softtabstop = -1
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.breakindent = true

-- config
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.visualbell = true
vim.opt.emoji = true
vim.opt.backup = false
vim.opt.shell = 'zsh'

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- insert
-- vim.opt.textwidth = 120

-- --------------------------------- keymaps -------------------------------- --
vim.g.mapleader = ' '

-- disable
vim.keymap.set('n', 's', '<nop>')
vim.keymap.set('n', 't', '<nop>')

-- buffer
vim.keymap.set('n', '<C-w>n', '<cmd>bn<cr>')
vim.keymap.set('n', '<C-w><C-n>', '<cmd>bn<cr>')
vim.keymap.set('n', '<C-w>p', '<cmd>bp<cr>')
vim.keymap.set('n', '<C-w><C-p>', '<cmd>bp<cr>')

--misc
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('n', 'sd', '"_d')
vim.keymap.set('i', '<C-s>', '<C-d>')

-- emacs like keybindings
vim.keymap.set({ 'c', 'i' }, '<C-a>', '<Home>')
vim.keymap.set({ 'c', 'i' }, '<C-e>', '<End>')
vim.keymap.set({ 'c', 'i' }, '<C-b>', '<Left>')
vim.keymap.set({ 'c', 'i' }, '<C-f>', '<Right>')
vim.keymap.set({ 'c', 'i' }, '<C-d>', '<Del>')
vim.keymap.set('i', '<C-p>', '<Up>')
vim.keymap.set('i', '<C-n>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Esc>lDa')
vim.keymap.set('c', '<C-h>', '<BS>')

-- --------------------------------- autocmd -------------------------------- --
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = 'init.lua',
    command = 'PackerCompile'
})
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- --------------------------------- plugins -------------------------------- --
-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

require('packer').startup(function(use)
    use({ 'wbthomason/packer.nvim' })
    use({ 'nvim-lua/plenary.nvim' })
    use({ 'kyazdani42/nvim-web-devicons' })
    use({ 'vim-jp/vimdoc-ja' })
    use({ 'github/copilot.vim' })
    use({ 'cappyzawa/trim.nvim' })
    use({
        'bluz71/vim-nightfly-guicolors' ,
        config = function() vim.cmd('colorscheme nightfly') end
    })
    use({ 'lewis6991/gitsigns.nvim' })
    use({ 'lukas-reineke/indent-blankline.nvim' })
    use({ 'nvim-lualine/lualine.nvim' })
    use({ 'b3nj5m1n/kommentary' })
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
            'windwp/nvim-ts-autotag',
            'nvim-treesitter/nvim-treesitter-context',
        },
    })
    use({
        'nvim-telescope/telescope-frecency.nvim',
        requires = 'kkharji/sqlite.lua',
    })
    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    })
    use({
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-telescope/telescope-ghq.nvim'
    })
    use({
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end
    })
    use({
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end
    })
    use({ 'akinsho/bufferline.nvim' })
    use({
        'kylechui/nvim-surround',
        config = function() require('nvim-surround').setup() end
    })
    use({ 'nvim-tree/nvim-tree.lua' })

    -- completion
    use({ 'kevinhwang91/nvim-hlslens' })
    use {
        "tversteeg/registers.nvim",
        config = function() require("registers").setup() end,
    }
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use({ 'mickael-menu/zk-nvim' })
end)

-- ------------------------------- appearance ------------------------------- --
vim.opt.termguicolors = true
vim.cmd('autocmd colorscheme * highlight Normal      ctermbg=NONE guibg=NONE')
vim.cmd('autocmd colorscheme * highlight NonText     ctermbg=NONE guibg=NONE')
vim.cmd('autocmd colorscheme * highlight Folded      ctermbg=NONE guibg=NONE')
vim.cmd('autocmd colorscheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE')

vim.opt.pumblend = 10

vim.opt.number = true
vim.opt.list = true
vim.opt.cursorline = true
vim.opt.listchars = {
    space = '･',
    tab = '>-',
    eol = '¬',
    extends = '»',
    precedes = '«',
    nbsp = '+'
}
vim.opt.laststatus = 2
vim.opt.scrolloff = 5
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80,100,120'

vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.relativenumber = true

vim.opt.title = true
