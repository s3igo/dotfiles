utils:

{
  imports = map utils [ ./emacs.nix ];

  globals.mapleader = " ";

  keymaps =
    [
      # terminal
      {
        key = "<c-]>";
        action = "<c-\\><c-n>";
        mode = "t";
        options.desc = "Exit terminal mode";
      }
    ]
    ++ map (utils.mapMode "n") [
      # {
      #   key = "<c-[>";
      #   action = "<cmd>noh<cr>";
      # }
      {
        key = "<leader>c";
        action.__raw = ''
          function()
            local line = vim.api.nvim_get_current_line()
            local row = unpack(vim.api.nvim_win_get_cursor(0))
            -- Fill up to column 80
            local available_width = 80 - #line
            local comment = string.rep('-', available_width - 1)
            vim.api.nvim_buf_set_text(0, row - 1, #line, row - 1, #line, { ' ' .. comment })
          end
        '';
        options.desc = "Line comment";
      }
      {
        key = "<leader>;";
        action.__raw = ''
          function()
            local line = vim.api.nvim_get_current_line()
            local row = unpack(vim.api.nvim_win_get_cursor(0))
            -- If the line ends with a semicolon
            if line:sub(#line, #line) == ';' then
                vim.api.nvim_buf_set_text(0, row - 1, #line - 1, row - 1, #line, { "" })
            else
                vim.api.nvim_buf_set_text(0, row - 1, #line, row - 1, #line, { ';' })
            end
          end
        '';
        options.desc = "Toggle trailing semicolon";
      }
      {
        key = "<leader>,";
        action.__raw = ''
          function()
            local line = vim.api.nvim_get_current_line()
            local row = unpack(vim.api.nvim_win_get_cursor(0))
            -- If the line ends with a comma
            if line:sub(#line, #line) == ',' then
                vim.api.nvim_buf_set_text(0, row - 1, #line - 1, row - 1, #line, { "" })
            else
                vim.api.nvim_buf_set_text(0, row - 1, #line, row - 1, #line, { ',' })
            end
          end
        '';
        options.desc = "Toggle trailing comma";
      }
    ]
    ++ map (utils.mapMode "i") [
      # indent
      {
        key = "<c-x><c-t>";
        action = "<c-t>";
      }
      {
        key = "<c-x><c-d>";
        action = "<c-d>";
      }
    ];
}
