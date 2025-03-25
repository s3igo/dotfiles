{
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type directory --hidden --follow --exclude .git";
    changeDirWidgetOptions = [ "--preview 'ls -la --color=always {}'" ];
    defaultCommand = "fd --type file --hidden --follow --exclude .git";
    defaultOptions = [
      "--bind=${
        builtins.concatStringsSep "," [
          "ctrl-u:preview-half-page-up"
          "ctrl-d:preview-half-page-down"
          "ctrl-j:accept"
          "ctrl-k:kill-line"
        ]
      }"
    ];
    # Set empty string to disable default key binding of <C-t>
    fileWidgetCommand = "";
  };
}
