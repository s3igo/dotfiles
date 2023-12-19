{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$all"
        "$line_break"
        "$custom"
        "$character"
      ];
      character.success_symbol = "[❯](bold blue)";
      git_branch.symbol = "󰘬 ";
      git_metrics.disabled = false;
      nix_shell.symbol = " ";
      custom.arch = {
        command = "uname -m";
        when = true;
        style = "bold blue";
      };
    };
  };
}
