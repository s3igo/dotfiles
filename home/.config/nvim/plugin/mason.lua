require('mason').setup()

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup()


local opt = {
    on_attach = function(client, bufnr)
        local map = vim.keymap

        map.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
        map.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
        map.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
        map.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
        map.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
        map.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
        map.set('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
        map.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
        map.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        map.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )
}

local lspconfig = require('lspconfig')
mason_lspconfig.setup_handlers({ function(server_name)
        lspconfig[server_name].setup(opt)
    end,
    ['sumneko_lua'] = function ()
       lspconfig.sumneko_lua.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })
    end
})
