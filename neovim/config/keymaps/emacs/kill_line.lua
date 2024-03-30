---@diagnostic disable-next-line: miss-name
function()
    local line = vim.api.nvim_get_current_line()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    -- is line end
    if col == #line then
    return
    end

    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, #line, { "" })
end
