utils@{ mapMode, ... }:

{
  imports = utils [ ./emacs ];

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
        action.__raw = builtins.readFile ./comment.lua;
        options.desc = "Line comment";
      }
      {
        key = "<leader>;";
        action.__raw = builtins.readFile ./semicolon.lua;
        options.desc = "Toggle trailing semicolon";
      }
      {
        key = "<leader>,";
        action.__raw = builtins.readFile ./comma.lua;
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
