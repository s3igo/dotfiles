{
  imports = [ ./emacs ];

  globals.mapleader = " ";

  keymaps = [
    {
      key = "<c-[>";
      action = "<cmd>noh<cr>";
      mode = "n";
    }
    # {
    #   key = "gm";
    #   action = "%";
    #   mode = [
    #     "n"
    #     "x"
    #     "o"
    #   ];
    #   options.desc = "Go to matching bracket";
    # }
    {
      key = "<leader>c";
      action.__raw = builtins.readFile ./comment.lua;
      mode = "n";
      options.desc = "Line comment";
    }
    {
      key = "<leader>;";
      action.__raw = builtins.readFile ./semicolon.lua;
      mode = "n";
      options.desc = "Toggle trailing semicolon";
    }
    {
      key = "<leader>,";
      action.__raw = builtins.readFile ./comma.lua;
      mode = "n";
      options.desc = "Toggle trailing comma";
    }
    # buffers
    {
      key = "[b";
      action = "<cmd>bp<cr>";
      mode = "n";
      options.desc = "Previous buffer";
    }
    {
      key = "]b";
      action = "<cmd>bn<cr>";
      mode = "n";
      options.desc = "Next buffer";
    }
    # registers
    {
      key = "<leader>y";
      action = ''"+y'';
      mode = [
        "n"
        "x"
      ];
      options.desc = "Clipboard register";
    }
    {
      key = "<leader>p";
      action = ''"+p'';
      mode = [
        "n"
        "x"
      ];
      options.desc = "Blackhole register";
    }
    # helix keybindings
    {
      key = "gl";
      action = "g_";
      mode = [
        "n"
        "x"
        "o"
      ];
    }
    {
      key = "gh";
      action = "g^";
      mode = [
        "n"
        "x"
        "o"
      ];
    }
    # indent
    {
      key = "<tab>";
      action = "<c-t>";
      mode = "i";
    }
    {
      key = "<s-tab>";
      action = "<c-d>";
      mode = "i";
    }
    # retain visual selection
    # {
    #   key = ">";
    #   action = ">gv";
    #   mode = "v";
    # }
    # {
    #   key = "<";
    #   action = "<gv";
    #   mode = "v";
    # }
    # add undo breakpoints
    # {
    #   key = ",";
    #   action = ",<c-g>u";
    #   mode = "i";
    # }
    # {
    #   key = ".";
    #   action = ".<c-g>u";
    #   mode = "i";
    # }
    # {
    #   key = ";";
    #   action = ";<c-g>u";
    #   mode = "i";
    # }
    # files
    {
      key = "<leader>s";
      action = "<cmd>w<cr>";
      mode = "n";
      options.desc = "Save";
    }
    {
      key = "<leader>q";
      action = "<cmd>qa<cr>";
      mode = "n";
      options.desc = "Quit all";
    }
    # terminal
    {
      key = "<c-]>";
      action = "<c-\\><c-n>";
      mode = "t";
      options.desc = "Exit terminal mode";
    }
  ];
}
