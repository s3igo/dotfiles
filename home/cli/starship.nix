{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$all"
        "$line_break"
        ''''${custom.arch}''
        ''''${custom.level}''
        "$character"
      ];
      character.success_symbol = "[❯](bold blue)";
      git_branch.symbol = "󰘬 ";
      git_metrics.disabled = false;
      nix_shell.symbol = " ";
      custom = {
        arch = {
          command = "uname -m";
          when = true;
          style = "bold blue";
        };
        level = {
          command = "echo $(($SHLVL - 1))";
          when = true;
          style = "bold green";
          format = "\\[[$output]($style)\\] ";
        };
      };
    };
  };
}
