---@diagnostic disable-next-line: miss-name
function()
    local line = vim.api.nvim_get_current_line()
    local row = unpack(vim.api.nvim_win_get_cursor(0))

    -- line end is semicolon
    if line:sub(#line, #line) == ';' then
        vim.api.nvim_buf_set_text(0, row - 1, #line - 1, row - 1, #line, { '' })
    else
        vim.api.nvim_buf_set_text(0, row - 1, #line, row - 1, #line, { ';' })
    end
end
