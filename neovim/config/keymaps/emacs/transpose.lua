---@diagnostic disable-next-line: miss-name
function()
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
