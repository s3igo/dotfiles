-- files
vim.keymap.set('n', '<leader>s', '<cmd>w<cr><esc>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>S', '<cmd>wa<cr><esc>', { desc = 'Save all files' })
vim.keymap.set('n', '<leader>q', '<cmd>qa<cr>', { desc = 'Quit all' })

-- emacs style
local function transpose_chars()
    local line = vim.api.nvim_get_current_line()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    -- is line start or line has only 1 char
    if col == 0 or #line == 1 then
        return
    end

    -- is line end
    if col == #line then
        col = col - 1
        vim.api.nvim_win_set_cursor(0, { row, col })
    end

    local lhs_char = line:sub(col, col)
    local rhs_char = line:sub(col + 1, col + 1)

    vim.api.nvim_buf_set_text(0, row - 1, col - 1, row - 1, col + 1, { rhs_char .. lhs_char })
    vim.api.nvim_win_set_cursor(0, { row, col + 1 })
end

vim.keymap.set('i', '<C-t>', transpose_chars)

vim.keymap.set('i', '<C-f>', '<C-g>U<Right>')
vim.keymap.set('i', '<C-b>', '<C-g>U<Left>')
vim.keymap.set('i', '<C-p>', '<C-g>U<Up>')
vim.keymap.set('i', '<C-n>', '<C-g>U<Down>')
vim.keymap.set('i', '<C-a>', '<C-g>U<Home>')
vim.keymap.set('i', '<C-e>', '<C-g>U<End>')

vim.keymap.set({ 'c', 'i' }, '<C-d>', '<Del>')
vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')

vim.keymap.set('i', '<C-k>', '<esc>lDa')
vim.keymap.set('c', '<C-h>', '<bs>')

-- plugins
vim.keymap.set('n', '<leader>;l', '<cmd>Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>;m', '<cmd>Mason<cr>', { desc = 'Mason' })
vim.keymap.set('n', '<leader>;t', '<cmd>Telescope<cr>', { desc = 'Telescope' })

-- terminal
vim.keymap.set('t', '<C-]>', '<C-\\><C-n>', { desc = 'Escape terminal mode' })
