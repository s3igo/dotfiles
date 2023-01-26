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