{ pkgs, ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        showIcons = true;
        language = "en";
      };
      git.paging = {
        colorArg = "always";
        pager = "${pkgs.delta}/bin/delta --dark --paging=never";
      };
    };
  };
}
