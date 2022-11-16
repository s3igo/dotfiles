require('mason').setup()

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup()


local opt = {
    on_attach = function(client, bufnr)
        local map = vim.keymap
        -- client.offset_encoding = 'utf-8'

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
    end,
})

vim.opt.completeopt = 'menu,menuone,noselect'

local lspkind = require('lspkind')

local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-l>'] = cmp.mapping.complete(),
        -- ['<cr>'] = cmp.mapping.close(),
        ['<cr>'] = cmp.mapping.confirm({ select = true })
    }),
    sources = {
        -- { name = 'copilot', priority = 10 },
        { name = 'vsnip' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            elipsis_char = '...',
        })
    },
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer'}
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'path'}
    }
})

require('lspsaga').init_lsp_saga()

vim.keymap.set("n", "K",  "<cmd>Lspsaga hover_doc<CR>")
vim.keymap.set('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>')
vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>")
vim.keymap.set("n", "gn", "<cmd>Lspsaga rename<CR>")
vim.keymap.set("n", "ge", "<cmd>Lspsaga show_line_diagnostics<CR>")
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")

-- vim.keymap.set("n", "tj", "<cmd>Lspsaga open_floaterm<CR>")
-- vim.keymap.set("n", "tg", "<cmd>Lspsaga open_floaterm lazygit<CR>")
-- vim.keymap.set("t", "tj", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])
