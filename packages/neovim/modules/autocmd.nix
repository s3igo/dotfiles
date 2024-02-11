[
  {
    event = [
      "BufReadPost"
      "BufNewFile"
    ];
    callback.__raw = ''
      function()
        vim.opt_local.formatoptions:remove('r')
        vim.opt_local.formatoptions:remove('o')
      end
    '';
    desc = "Disable automatic comment insertion";
  }
  {
    event = "TermOpen";
    command = "startinsert";
    desc = "Enter insert mode when opening a terminal";
  }
  {
    event = "FileType";
    pattern = "nix";
    command = "setlocal shiftwidth=2";
  }
  {
    event = "FileType";
    pattern = "gitcommit";
    callback.__raw = ''
      function()
        vim.opt_local.colorcolumn = { 50, 72 }
        vim.keymap.set('n', '<leader>w', '<cmd>wq<cr>', { buffer = true })
        vim.keymap.set('i', '<C-]>', '<esc><cmd>wq<cr>', { buffer = true })
      end
    '';
  }
  {
    event = "FileType";
    pattern = "markdown";
    callback.__raw = ''
      function()
        vim.opt_local.formatoptions:append('r')
        vim.opt_local.comments = 'b:-,n:>'
      end
    '';
  }
]
