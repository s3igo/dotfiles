{
  pkgs,
  config,
  # osConfig,
  lib,
  ...
}:
{
  programs.fish = {
    enable = true;
    plugins =
      let
        plugin = name: {
          inherit name;
          inherit (pkgs.fishPlugins.${name}) src;
        };
      in
      [
        (plugin "autopair")
        (plugin "fishtape_3")
        (plugin "sponge")
      ];
    shellAbbrs =
      let
        global = text: {
          position = "anywhere";
          expansion = text;
        };
      in
      {
        _dotdot = {
          regex = "^\\.\\.+$";
          function = "__multicd";
        };
        ":c" = global "| pbcopy";
        ":d" = {
          position = "anywhere";
          function = "__date";
        };
        ":di" = global "(docker image ls | tail -n +2 | fzf | awk '{print $3}')";
        ":dp" = global "(docker ps | tail -n +2 | fzf | awk '{print $1}')";
        ":dpa" = global "(docker ps -a | tail -n +2 | fzf | awk '{print $1}')";
        ":f" = global "| fzf";
        ":g" = global "| rg";
        ":h" = global "--help";
        ":i" = global "install";
        ":icloud" = global "~/Library/Mobile\\ Documents/com~apple~CloudDocs";
        ":p" = global "| less";
        ":s" = global "search";
        ":v" = global "--version";
        arc = "open -a 'Arc.app'";
        b = "brew";
        ca = "cargo";
        cdg = "cd (cat ${config.xdg.stateHome}/ghq/lastdir | string escape)";
        cdl = "cd (cat ${config.xdg.dataHome}/lf/lastdir | string escape)";
        cl = "clear";
        cp = "cp -iv";
        d = "docker";
        e = "echo";
        g = "git";
        ga = "git add";
        gc = "git commit";
        gd = "git diff";
        gs = "git switch";
        h = "history";
        m = "mkdir";
        mv = "mv -iv";
        n = "nix";
        nf = "nix flake";
        p = "pbpaste |";
        ql = {
          setCursor = true;
          expansion = "qlmanage -p % &> /dev/null";
        };
        r = "rclone";
        run = {
          setCursor = true;
          expansion = "nix run nixpkgs#%";
        };
        rm = "rm -iv";
        st = "git status";
        t = {
          setCursor = true;
          expansion = "task_%";
        };
        ty = "typst";
        v = "nvim";
        w = "which";
      };
    functions = {
      # .. -> cd ../, ... -> cd ../../, and so on
      __multicd = "echo cd (string repeat --count (math (string length -- $argv[1]) - 1) ../)";
      __date = "echo (date '+%Y-%m-%d')";
      __ghq-fzf = ''
        set -l dest (ghq list --full-path \
          | fzf --preview "tree -C --gitignore -I 'node_modules|target|.git' {}" \
          | string escape)

        if test -z $dest
          return
        end

        cd $dest
        commandline -f execute

        mkdir -p ${config.xdg.stateHome}/ghq
        echo $dest > ${config.xdg.stateHome}/ghq/lastdir
      '';
    };
    shellInit = ''
      # disable greeting
      set fish_greeting

      # path
      if test -d /opt/homebrew
        /opt/homebrew/bin/brew shellenv | source
      end
      if test -d ${config.home.homeDirectory}/.orbstack
        fish_add_path ${config.home.homeDirectory}/.orbstack/bin
      end

      # keybindings
      ## disable exit with <C-d>
      bind \cd delete-char

      ## bigword
      bind \el forward-bigword
      bind \eh backward-bigword
      bind \ew backward-kill-bigword

      ## autosuggestions
      bind \cl accept-autosuggestion
      bind \cf forward-single-char

      ## history
      bind \ep history-token-search-backward
      bind \en history-token-search-forward
      ### <C-h> FIXME: `history-pager-delete` doesn't work
      bind \b history-pager-delete or backward-delete-char

      ## function
      bind \cg __ghq-fzf

    '';
    shellInitLast = ''
      # disable `fzf-file-widget` keybind
      bind --erase \ct 
    '';
  };

  # home.activation.updateFishCompletions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   ${pkgs.fish}/bin/fish -c 'fish_update_completions'
  # '';
}
