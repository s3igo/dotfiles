_: {
  keymaps = [
    {
      key = "<c-t>";
      action.__raw = ''
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
      '';
      mode = "i";
    }
    {
      key = "<c-k>";
      action.__raw = ''
        function()
          local line = vim.api.nvim_get_current_line()
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))

          -- is line end
          if col == #line then
            return
          end

          vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, #line, { "" })
        end
      '';
      mode = "i";
    }
    {
      key = "<c-p>";
      action = "<c-g>U<up>";
      mode = "i";
    }
    {
      key = "<c-n>";
      action = "<c-g>U<down>";
      mode = "i";
    }
    {
      key = "<c-f>";
      action = "<c-g>U<right>";
      mode = "i";
    }
    {
      key = "<c-f>";
      action = "<right>";
      mode = "c";
    }
    {
      key = "<c-b>";
      action = "<c-g>U<left>";
      mode = "i";
    }
    {
      key = "<c-b>";
      action = "<left>";
      mode = "c";
    }
    {
      key = "<c-a>";
      action = "<c-g>U<home>";
      mode = "i";
    }
    {
      key = "<c-a>";
      action = "<home>";
      mode = "c";
    }
    {
      key = "<c-e>";
      action = "<c-g>U<end>";
      mode = "i";
    }
    {
      key = "<c-e>";
      action = "<end>";
      mode = "c";
    }
    {
      key = "<c-d>";
      action = "<del>";
      mode = [
        "i"
        "c"
      ];
    }
    {
      key = "<c-h>";
      action = "<bs>";
      mode = "c";
    }
    {
      key = "<c-h>";
      action = "<bs>";
      mode = "c";
    }
  ];
}
