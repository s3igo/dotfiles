_: {
  plugins = {
    bufferline = {
      enable = true;
      numbers = "ordinal";
      indicator.icon = "|";
      modifiedIcon = "[+]";
      showBufferIcons = false;
      showBufferCloseIcons = false;
      showCloseIcon = false;
      diagnostics = "nvim_lsp";
      separatorStyle.__raw = "{ '', '' }";
      alwaysShowBufferline = false;
      offsets = [
        {
          filetype = "NvimTree";
          text_align = "left";
          separator = true;
        }
      ];
    };
    indent-blankline = {
      enable = true;
      indent = {
        char = "|";
        highlight = "Indent";
      };
      whitespace.highlight = "Whitespace";
      scope.enabled = false;
    };
    which-key = {
      enable = true;
      window = {
        border = "single";
        winblend = 100;
      };
    };
  };

  keymaps = [
    {
      key = "[b";
      action = "<cmd>BufferLineCyclePrev<cr>";
      mode = "n";
      options.desc = "Previous buffer";
    }
    {
      key = "]b";
      action = "<cmd>BufferLineCycleNext<cr>";
      mode = "n";
      options.desc = "Next buffer";
    }
    {
      key = "<b";
      action = "<cmd>BufferLineMovePrev<cr>";
      mode = "n";
      options.desc = "Move buffer to previous position";
    }
    {
      key = ">b";
      action = "<cmd>BufferLineMoveNext<cr>";
      mode = "n";
      options.desc = "Move buffer to next position";
    }
  ];
}
