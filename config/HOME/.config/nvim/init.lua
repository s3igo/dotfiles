-- require('base')

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

-- insert
-- o.textwidth = 120
-- vim.cmd('autocmd! bufwritepost $MYVIMRC source %')
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = (vim.env.HOME .. "/.config/nvim/**/*"),
    command = 'source $MYVIMRC'}
)


-- require('keymaps')

local map = vim.keymap

vim.g.mapleader = ' '

-- disable
map.set('n', 's', '<nop>')
map.set('n', 't', '<nop>')

-- buffer
map.set('n', '<C-w>n', '<cmd>bn<cr>')
map.set('n', '<C-w><C-n>', '<cmd>bn<cr>')
map.set('n', '<C-w>p', '<cmd>bp<cr>')
map.set('n', '<C-w><C-p>', '<cmd>bp<cr>')

--misc
map.set('n', 'Y', 'y$')
map.set('n', 'sd', '"_d')
map.set('i', '<C-s>', '<C-d>')

-- emacs like keybindings
map.set({ 'c', 'i' }, '<C-a>', '<Home>')
map.set({ 'c', 'i' }, '<C-e>', '<End>')
map.set({ 'c', 'i' }, '<C-b>', '<Left>')
map.set({ 'c', 'i' }, '<C-f>', '<Right>')
map.set({ 'c', 'i' }, '<C-d>', '<Del>')
map.set('i', '<C-p>', '<Up>')
map.set('i', '<C-n>', '<Down>')
map.set('i', '<C-k>', '<Esc>lDa')
map.set('c', '<C-h>', '<BS>')

-- require('autocmd')

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = 'plugins.lua',
    command = 'PackerCompile'
})
-- vim.api.nvim_create_autocmd({ 'BufWritePost' }), {
-- pattern = $MYVIMRC,
--    command = 'source %'
-- })
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- require('plugins')

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
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
            -- 'p00f/nvim-ts-rainbow',
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

    -- LSP
    use({ 'neovim/nvim-lspconfig' })
    use({ 'williamboman/mason.nvim' })
    use({ 'williamboman/mason-lspconfig.nvim' })

    -- completion
    use({ 'hrsh7th/nvim-cmp' })
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use({ 'hrsh7th/cmp-buffer' })
    use({ 'hrsh7th/cmp-path' })
    use({ 'hrsh7th/cmp-cmdline' })
    use({
        'hrsh7th/vim-vsnip',
        config = function () vim.g.vsnip_snippet_dir = '~/.dotfiles/vsnip' end
    })
    use({ 'hrsh7th/cmp-vsnip'})
    use({ 'onsails/lspkind-nvim' })
    use({
        'phaazon/hop.nvim',
        config = function() require('hop').setup() vim.keymap.set('n', 'ss', '<cmd>HopWord<cr>') end
    })
    use({
        'j-hui/fidget.nvim',
        config = function() require('fidget').setup() end
    })
    use({
        'folke/trouble.nvim',
        config = function()
            require('trouble').setup()
            vim.keymap.set('n', 'sm', '<cmd>TroubleToggle<cr>')
        end
    })
    use({ 'glepnir/lspsaga.nvim' })
    use({
        'akinsho/toggleterm.nvim',
        config = function() require('toggleterm').setup({
            -- size = 20,
        })
        vim.keymap.set('n', 'sj', '<cmd>ToggleTerm<cr>')
        end
    })
    -- use({ 'kevinhwang91/nvim-hlslens' })
    use {
        "tversteeg/registers.nvim",
        config = function() require("registers").setup() end,
    }
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use({ 'mickael-menu/zk-nvim' })
    -- use({ 'L3MON4D3/LuaSnip' })
    --[[ use({
        'ray-x/lsp_signature.nvim',
        config = function() require('lsp_signature').setup({
            toggle_key = '<M-j>'
        }) end
    }) ]]
end)

-- require('appearance')

local o = vim.opt

o.termguicolors = true
-- vim.cmd('highlight Normal ctermbg=NONE guibg=NONE')
-- vim.cmd('highlight NonText ctermbg=NONE guibg=NONE')
-- vim.cmd('highlight LineNr ctermbg=NONE guibg=NONE')
-- vim.cmd('highlight Folded ctermbg=NONE guibg=NONE')
-- vim.cmd('highlight EndOfBuffer ctermbg=NONE guibg=NONE')
vim.cmd('autocmd colorscheme * highlight Normal      ctermbg=NONE guibg=NONE')
vim.cmd('autocmd colorscheme * highlight NonText     ctermbg=NONE guibg=NONE')
vim.cmd('autocmd colorscheme * highlight Folded      ctermbg=NONE guibg=NONE')
vim.cmd('autocmd colorscheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE')

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

o.title = true

