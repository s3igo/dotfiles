{
  # autoCmd = [
  #   {
  #     event = "FileType";
  #     pattern = "markdown";
  #     callback.__raw = ''
  #       function()
  #         vim.opt_local.formatoptions:append('r')
  #         vim.opt_local.comments = 'b:-,n:>'
  #       end
  #     '';
  #   }
  # ];

  highlight = {
    "@markup.list.checked.markdown".link = "NightflyTurquoiseMode";
  };
}
