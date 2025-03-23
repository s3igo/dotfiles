{
  imports = [ ./module.nix ];

  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type directory --hidden --follow --exclude .git";
    changeDirWidgetOptions = [ "--preview 'ls -la --color=always {}'" ];
    defaultCommand = "fd --type file --hidden --follow --exclude .git";
    # Set empty string to disable default key binding of <C-t>
    fileWidgetCommand = "";
  };
}
