require('shared.options')
require('shared.autocmds')
require('shared.keymaps')

if vim.g.vscode then
    require('vscode')
else
    require('term.options')
    require('term.autocmds')
    require('term.keymaps')
end

require('plugin')
