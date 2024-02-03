{pkgs, ...}: {
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
    ];
    shellInit = ''
      # brew
      /opt/homebrew/bin/brew shellenv | source

      # disable greeting
      set fish_greeting
    '';
  };
}
