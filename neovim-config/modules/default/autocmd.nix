_: {
  autoCmd = [
    {
      event = "FileType";
      pattern = "gitcommit";
      callback.__raw = ''
        function() vim.opt_local.colorcolumn = { 50, 72 } end
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
