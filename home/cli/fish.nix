{
  pkgs,
  config,
  # osConfig,
  # lib,
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
        global = {
          position = "anywhere";
        };
        cursor = {
          setCursor = true;
        };
        regex = pat: { regex = pat; };
        function = str: { function = str; };
        text = str: { expansion = str; };
      in
      {
        _dotdot =
          regex "^\\.\\.+$" # matches `..`, `...`, `....`, and so on
          // function "__multicd";
        ":c" = global // text "| pbcopy";
        ":d" = global // function "__date";
        ":di" = global // text "(docker image ls | tail -n +2 | fzf | awk '{print $3}')";
        ":dp" = global // text "(docker ps | tail -n +2 | fzf | awk '{print $1}')";
        ":dpa" = global // text "(docker ps -a | tail -n +2 | fzf | awk '{print $1}')";
        ":f" = global // text "| fzf";
        ":g" = global // text "| rg";
        ":h" = global // text "--help";
        ":i" = global // text "install";
        ":icloud" = global // text "~/Library/Mobile\\ Documents/com~apple~CloudDocs";
        ":p" = global // text "| less";
        ":s" = global // text "search";
        ":v" = global // text "--version";
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
        ql = cursor // text "qlmanage -p % &> /dev/null";
        r = "rclone";
        run = cursor // text "nix run nixpkgs#%";
        rm = "rm -iv";
        st = "git status";
        t = cursor // text "task_%";
        ty = "typst";
        v = "nvim";
        w = "which";
      };
    functions = {
      # $1 length is 2 -> `cd ../`, 3 -> `cd ../../`, and so on
      __multicd = "echo cd (string repeat --count (math (string length -- $argv[1]) - 1) ../)";
      # current date in ISO 8601 extended format
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
      ## disable exit with <c-d>
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
      ### <c-h> FIXME: `history-pager-delete` doesn't work
      bind \b history-pager-delete or backward-delete-char

      ## function
      bind \cg __ghq-fzf
    '';
    shellInitLast = ''
      # disable the `fzf-file-widget` keybind and use <c-t> to `transpose-chars`
      bind --erase \ct 
    '';
  };

  # home.activation.updateFishCompletions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   ${pkgs.fish}/bin/fish -c 'fish_update_completions'
  # '';
}
