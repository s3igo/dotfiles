local o = vim.opt

-- config
o.clipboard:append({ unnamedeplus = true })
o.mouse = 'a'
o.visualbell = true
o.emoji = true
o.backup = false
o.shell = 'zsh'

-- search
o.hlsearch = true
o.ignorecase = true
o.smartcase = true

-- autocmd
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

require('base')
require('appearance')
require('keymaps')
require('plugins')
vim.cmd('colorscheme nightfly')
