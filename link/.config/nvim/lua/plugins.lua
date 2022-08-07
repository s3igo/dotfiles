vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use("wbthomason/packer.nvim")
    use("nvim-telescope/telescope.nvim")

    -- filer
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

end)
