vim.cmd[[packadd packer.nvim]]

require('packer').startup(function(use)
    use("wbthomason/packer.nvim")
    use("nvim-neo-tree/neo-tree.nvim")
    use("nvim-telescope/telescope.nvim")

end)
