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
    use('wbthomason/packer.nvim')
    -- use('nvim-telescope/telescope.nvim')
    -- use('nvim-treesitter/nvim-treesitter')
    use {
        'haishanh/night-owl.vim',
        opt = true
    }

    -- filer
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    -- vim.g.neo_tree_remove_legacy_commands = 1

    -- use {
    --     "nvim-neo-tree/neo-tree.nvim",
    --     branch = "v2.x",
    --     requires = {
    --         "nvim-lua/plenary.nvim",
    --         "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
    --         "MunifTanjim/nui.nvim",
    --     }
    -- }

end)
