{ mapMode, ... }:

{
  keymaps =
    map (mapMode "i") [
      # {
      #   key = "<c-t>";
      #   action.__raw = ''
      #     function()
      #         local line = vim.api.nvim_get_current_line()
      #         local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      #         -- If cursor is at the beginning of line or line has only 1 char
      #         if col == 0 or #line == 1 then
      #           return
      #         end
      #         -- If cursor is at the end of line
      #         if col == #line then
      #           col = col - 1
      #           vim.api.nvim_win_set_cursor(0, { row, col })
      #         end
      #         local lhs_char = line:sub(col, col)
      #         local rhs_char = line:sub(col + 1, col + 1)
      #         vim.api.nvim_buf_set_text(0, row - 1, col - 1, row - 1, col + 1, { rhs_char .. lhs_char })
      #         vim.api.nvim_win_set_cursor(0, { row, col + 1 })
      #     end
      #   '';
      #   options.desc = "transpose";
      # }
      {
        key = "<c-k>";
        action.__raw = ''
          function()
              local line = vim.api.nvim_get_current_line()
              local row, col = unpack(vim.api.nvim_win_get_cursor(0))
              -- If cursor is at the end of line
              if col == #line then
                  return
              end
              vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, #line, { "" })
          end
        '';
        options.desc = "kill line";
      }
      {
        key = "<c-f>";
        action = "<c-g>U<right>";
      }
      {
        key = "<c-b>";
        action = "<c-g>U<left>";
      }
      {
        key = "<c-p>";
        action = "<c-g>U<up>";
      }
      {
        key = "<c-n>";
        action = "<c-g>U<down>";
      }
      {
        key = "<c-a>";
        action = "<c-g>U<home>";
      }
      {
        key = "<c-e>";
        action = "<c-g>U<end>";
      }
      {
        key = "<a-f>";
        action = "<c-g>U<s-right>";
      }
      {
        key = "<a-b>";
        action = "<c-g>U<s-left>";
      }
      # {
      #   key = "<c-d>";
      #   action = "<del>";
      # }
    ]
    ++ map (mapMode "c") [
      {
        key = "<c-f>";
        action = "<right>";
      }
      {
        key = "<c-b>";
        action = "<left>";
      }
      {
        key = "<c-a>";
        action = "<home>";
      }
      {
        key = "<c-e>";
        action = "<end>";
      }
      {
        key = "<a-f>";
        action = "<s-right>";
      }
      {
        key = "<a-b>";
        action = "<s-left>";
      }
      {
        key = "<c-d>";
        action = "<del>";
      }
    ];
}
