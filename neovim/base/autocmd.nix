_: {
  autoCmd = [
    # {
    #   event = "TermOpen";
    #   command = "startinsert";
    #   desc = "Enter insert mode when opening a terminal";
    # }
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
    {
      event = [
        "BufReadPost"
        "BufNewFile"
      ];
      callback.__raw = ''
        function()
          -- disable automatic comment insertion
          vim.opt_local.formatoptions:remove('r')
          vim.opt_local.formatoptions:remove('o')

          -- highlight trailing whitespace
          vim.cmd('2match TrailingSpace /\\s\\+$/')
        end
      '';
    }
    {
      event = "TermOpen";
      command = "2match none";
      desc = "Clear trailing whitespace highlight in terminal";
    }
  ];
}
