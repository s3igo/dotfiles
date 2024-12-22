{
  imports = [ ./module.nix ];

  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type directory --hidden --follow --exclude .git";
    changeDirWidgetOptions = [ "--preview 'ls -la --color=always {}'" ];
    fileWidgetCommand = ""; # To disable ctrl-t
    defaultCommand = "fd --type file --hidden --follow --exclude .git";
  };
}
