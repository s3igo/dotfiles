{
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        \[''${custom.arch}$shell\] $shlvl$all
      '';
      shell = {
        disabled = false;
        fish_indicator = "fish";
        style = "bold blue";
        format = "[$indicator]($style)";
      };
      shlvl = {
        disabled = false;
        style = "bold green";
        symbol = " ";
      };
      git_branch.symbol = "󰘬 ";
      git_metrics.disabled = false;
      nix_shell.symbol = " ";
      custom.arch = {
        command = "uname -m";
        style = "bold yellow";
        when = true;
      };
    };
  };
}
