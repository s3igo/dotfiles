return {{ -- colorscheme
    'bluz71/vim-nightfly-guicolors',
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd('colorscheme nightfly')
    end
}, { -- filer
    'nvim-tree/nvim-tree.lua',
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.keymap.set('n', 'sb', ':NvimTreeToggle<CR>')
        vim.cmd('highlight NvimTreeNormal ctermbg=NONE guibg=NONE')
        require('nvim-tree').setup({
            view = {
                mappings = {
                    list = {{
                        key = 's',
                        action = ''
                    }, {
                        key = 'so',
                        action = 'system_open'
                    }}
                }
            },
            filters = {
                custom = {'\\.git$', '.cache$'}
            }
        })
    end
}, {

}}
