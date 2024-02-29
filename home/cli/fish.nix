{
  pkgs,
  config,
  # osConfig,
  # lib,
  ...
}:
let
  inherit (config.xdg) dataHome stateHome;
  inherit (config.home) homeDirectory;
in
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
    functions = {
      # $1 length is 2 -> `cd ../`, 3 -> `cd ../../`, and so on
      __multicd = "echo cd (string repeat --count (math (string length -- $argv[1]) - 1) ../)";
      # current date in ISO 8601 extended format
      __date = "echo (date '+%Y-%m-%d')";
      __ghq-fzf = ''
        set -l dest (ghq list --full-path \
          | fzf --preview "tree -C --gitignore -I 'node_modules|target|.git' {}" \
          | string escape)

        # is not selected
        if test -z $dest
          return
        end

        cd $dest
        commandline -f execute

        mkdir -p ${stateHome}/ghq
        echo $dest > ${stateHome}/ghq/lastdir
      '';
    };
    shellAbbrs =
      let
        global = {
          position = "anywhere";
        };
        cursor = {
          setCursor = true;
        };
        regex = pat: { regex = pat; };
        function = name: { function = name; };
        text = str: { expansion = str; };
      in
      {
        _dotdot =
          regex "^\\.\\.+$" # matches `..`, `...`, `....`, and so on
          // function "__multicd";
        ":cp" = global // text "| pbcopy";
        ":d" = global // function "__date";
        ":di" = global // text "(docker image ls | tail -n +2 | fzf | awk '{print $3}')";
        ":dp" = global // text "(docker ps | tail -n +2 | fzf | awk '{print $1}')";
        ":dpa" = global // text "(docker ps -a | tail -n +2 | fzf | awk '{print $1}')";
        ":f" = global // text "| fzf";
        ":g" = global // text "| rg";
        ":h" = global // text "--help";
        ":i" = global // text "install";
        ":icloud" = global // text "~/Library/Mobile\\ Documents/com~apple~CloudDocs";
        ":l" = global // text "| less";
        ":s" = global // text "search";
        ":v" = global // text "--version";
        arc = "open -a 'Arc.app'";
        b = "brew";
        ca = "cargo";
        cdg = "cd (cat ${stateHome}/ghq/lastdir | string escape)";
        cdl = "cd (cat ${dataHome}/lf/lastdir | string escape)";
        cl = "clear";
        cp = "cp -iv";
        d = "docker";
        dp = "diff -Naur";
        e = "echo";
        ef = "exec fish";
        g = "git";
        ga = "git add";
        gc = "git commit";
        gd = "git diff";
        gs = "git switch";
        h = "history";
        mk = "mkdir";
        mv = "mv -iv";
        n = "nix";
        nf = "nix flake";
        nr = cursor // text "nix run .#% --";
        nrp = cursor // text "nix run nixpkgs#% --";
        nv = "nix run .#neovim --";
        nvp = "nix run nixpkgs#neovim --";
        nvd = "nix run $HOME/.dotfiles --";
        nvdr = "nix run github:s3igo/dotfiles --";
        pst = "pbpaste |";
        ql = cursor // text "qlmanage -p % &> /dev/null";
        r = "rclone";
        rm = "rm -iv";
        st = "git status";
        t = cursor // text "task_%";
        ty = "typst";
        v = "nvim";
        w = "which";
      };
    loginShellInit = ''
      # PATH
      if test -d /opt/homebrew
        /opt/homebrew/bin/brew shellenv | source
      end
      if test -d ${homeDirectory}/.orbstack
        fish_add_path ${homeDirectory}/.orbstack/bin
      end
    '';
    interactiveShellInit = ''
      # disable greeting
      set fish_greeting

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
      if status --is-interactive
        bind --erase \ct
      end
    '';
  };

  # home.activation.updateFishCompletions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   ${pkgs.fish}/bin/fish -c 'fish_update_completions'
  # '';
}
