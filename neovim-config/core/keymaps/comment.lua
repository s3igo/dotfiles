---@diagnostic disable-next-line: miss-name
function()
      local line = vim.api.nvim_get_current_line()
      local row = unpack(vim.api.nvim_win_get_cursor(0))

      -- fill to 80 columns
      local available_width = 80 - #line
      local comment = string.rep('-', available_width - 1)

      vim.api.nvim_buf_set_text(0, row - 1, #line, row - 1, #line, { ' ' .. comment })
end
