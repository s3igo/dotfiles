_: {
  autoCmd = [
    {
      event = "FileType";
      pattern = "gitcommit";
      callback.__raw = ''
        function()
          vim.opt_local.shiftwidth = 2
          vim.opt_local.colorcolumn = { 50, 70, 72 }
          vim.opt_local.formatoptions:remove('t')
          vim.opt_local.formatoptions:remove('c')
        end
      '';
    }
    {
      event = [
        "BufReadPost"
        "BufNewFile"
      ];
      command = "2match TrailingSpace /\\s\\+$/";
      desc = "Highlight trailing whitespace";
    }
    {
      event = "TermOpen";
      command = "2match none";
      desc = "Clear trailing whitespace highlight in terminal";
    }
  ];
}
