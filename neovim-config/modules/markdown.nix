{
  autoCmd = [
    {
      event = "FileType";
      pattern = "markdown";
      callback.__raw = ''
        function()
          vim.opt_local.formatoptions:append('r')
          vim.opt_local.comments = 'b:-,n:>'
          vim.opt_local.shiftwidth = 2
        end
      '';
    }
  ];

  highlight = {
    "@markup.list.checked.markdown".link = "NightflyTurquoiseMode";
  };
}
