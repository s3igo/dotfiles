{ pkgs, config, lib, ... }:
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
        ":c" = global "| pbcopy";
        # :d -> current date
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
        c = "clear";
        ca = "cargo";
        cdg = "cd (cat ${config.xdg.stateHome}/ghq/lastdir | string escape)";
        cdl = "cd (cat ${config.xdg.dataHome}/lf/lastdir | string escape)";
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
        # ql -> quick look
        r = "rclone";
        # run -> run nixpkgs
        rm = "rm -iv";
        st = "git status";
        # t -> task
        ty = "typst";
        v = "nvim";
        w = "which";
      };
    shellInit = ''
      # path
      /opt/homebrew/bin/brew shellenv | source
      fish_add_path ${config.home.homeDirectory}/.orbstack/bin

      # disable greeting
      set fish_greeting

      # variables
      set -x SSH_AUTH_SOCK $HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
      set -x DOCKER_CONFIG ${config.xdg.configHome}/docker
      set -x _ZO_DATA_DIR ${config.xdg.dataHome}/zoxide
      ## for `echo $0` compatibility with posix shell
      set -x 0 fish
      ## avoid creating `.lesshst`
      set -x LESSHISTFILE -

      # keybindings
      ## disable exit with <C-d>
      bind \cd delete-char

      ## autosuggestions
      ### <C-l>
      bind \f accept-autosuggestion
      ### <C-f>
      bind \cf forward-single-char

      ## history
      ### <C-h> FIXME: `history-pager-delete` doesn't work
      bind \b history-pager-delete or backward-delete-char
      ### <A-p>, <A-n>
      bind \ep history-token-search-backward
      bind \en history-token-search-forward

      ## ghq
      function __ghq-fzf
        set -l dest (ghq list --full-path | fzf --preview "tree -C --gitignore -I 'node_modules|target|.git' {}" | string escape)

        if test -z $dest
          return
        end

        cd $dest
        commandline -f execute

        mkdir -p ${config.xdg.stateHome}/ghq
        echo $dest > ${config.xdg.stateHome}/ghq/lastdir
      end
      ### <C-g>
      bind \cg __ghq-fzf

      # abbreviations
      ## cursor
      abbr --add t --set-cursor 'task_%'
      abbr --add run --set-cursor 'nix run nixpkgs#%'
      abbr --add ql --set-cursor 'qlmanage -p % &> /dev/null'

      ## .. -> cd ../, ... -> cd ../../, and so on
      function __multicd
        echo cd (string repeat --count (math (string length -- $argv[1]) - 1) ../)
      end
      abbr --add dotdot --regex '^\.\.+$' --function __multicd

      ## date
      function __date
        echo (date '+%Y-%m-%d')
      end
      abbr --add :d --position anywhere --function __date
    '';
  };
  home.activation.updateFishCompletions = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.fish}/bin/fish -c 'fish_update_completions'
  '';
}
