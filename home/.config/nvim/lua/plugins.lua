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
    use({ 'vim-jp/vimdoc-ja' })
    use({ 'nekowasabi/nvimdoc-ja' })
    use({ 'kentarosasaki/vim-emacs-bindings' })
    use({ 'github/copilot.vim' })
    use({ 'cappyzawa/trim.nvim',
        config = function() require('trim').setup({
            disable = {"markdown"},
            patterns = {
              [[%s/\s\+$//e]],
            },
        }) end
    })
    use({
        'bluz71/vim-nightfly-guicolors',
        config = 'vim.cmd([[colorscheme nightfly]])'
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
            'p00f/nvim-ts-rainbow',
        },
    })
    use({
        'nvim-telescope/telescope-frecency.nvim',
        requires = 'kkharji/sqlite.lua',
        config = function() require('telescope').load_extension('frecency') end
    })
    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        config = function() require('telescope').load_extension('fzf') end
    })
    use({
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim'
    })
    use({ 'nvim-telescope/telescope-file-browser.nvim' })
    use({
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end
    })
    use({
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end
    })
    use({
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require('bufferline').setup() end
    })
    use({
        'kylechui/nvim-surround',
        config = function() require('nvim-surround').setup() end
    })
    use({
        'lukas-reineke/virt-column.nvim',
        config = function() require('virt-column').setup({
            -- char = '|',
        }) end
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
    use({ 'onsails/lspkind-nvim' })
end)
