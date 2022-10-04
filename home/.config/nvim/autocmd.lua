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
