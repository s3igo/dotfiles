{ ... }: {
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        showIcons = true;
        language = "en";
      };
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };
    };
  };
}
