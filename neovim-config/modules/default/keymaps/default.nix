utils@{ mapMode, ... }:

{
  imports = utils [ ./emacs.nix ];

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
    ++ map (mapMode "n") [
      {
        key = "<c-[>";
        action = "<cmd>noh<cr>";
      }
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
      # files
      # {
      #   key = "<leader>s";
      #   action = "<cmd>w<cr>";
      #   options.desc = "Save";
      # }
      # {
      #   key = "<leader>q";
      #   action = "<cmd>qa<cr>";
      #   options.desc = "Quit all";
      # }
      # ]
      # ++
      #   map
      #     (mapMode [
      #       "n"
      #       "x"
      #     ])
      #     [
      #       # registers
      #       {
      #         key = "<leader>y";
      #         action = ''"+y'';
      #         options.desc = "Yank to system clipboard";
      #       }
      #       {
      #         key = "<leader>Y";
      #         action = ''"+Y'';
      #         options.desc = "Yank to system clipboard (until end of line)";
      #       }
      #       {
      #         key = "<leader>p";
      #         action = ''"+p'';
      #         options.desc = "Paste from system clipboard";
      #       }
      #       {
      #         key = "<leader>P";
      #         action = ''"+P'';
      #         options.desc = "Paste from system clipboard (before)";
      #       }
      #     ]
      # ++
      #   map
      #     (mapMode [
      #       "n"
      #       "x"
      #       "o"
      #     ])
      #     [
      #       # helix keybindings
      #       {
      #         key = "gl";
      #         action = "g_";
      #       }
      #       {
      #         key = "gh";
      #         action = "g^";
      #       }
      #     ]
      # ++ map (mapMode "i") [
      #   # indent
      #   {
      #     key = "<tab>";
      #     action = "<c-t>";
      #   }
      #   {
      #     key = "<s-tab>";
      #     action = "<c-d>";
      #   }
    ];
}
