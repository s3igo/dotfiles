_:
{
  programs.starship = {
    enable = true;
    settings = {
      right_format = ''
        level $shlvl
        at $shell
        on ''${custom.arch}
      '';
      shell = {
        disabled = false;
        fish_indicator = "fish";
        style = "bold blue";
      };
      shlvl = {
        disabled = false;
        symbol = "";
        threshold = 1;
      };
      git_branch.symbol = "󰘬 ";
      git_metrics.disabled = false;
      nix_shell.symbol = " ";
      custom.arch = {
        command = "uname -m";
        when = true;
      };
    };
  };
}
