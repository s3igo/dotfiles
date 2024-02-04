{
  pkgs,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
    ];
    shellAbbrs = let
      global = text: {
        position = "anywhere";
        expansion = text;
      };
    in {
      b = "brew";
      c = "clear";
      d = "docker";
      h = "history";
      n = "nix";
      nv = "nvim";
      r = "rclone";
      # git
      g = "git";
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      gs = "git switch";
      st = "git status";
      # -i: interactive, -v: verbose
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -iv";
      # one-liner
      arc = "open -a 'Arc.app'";
      cdf = "cd (fd --hidden --no-ignore --type directory --exclude .git | fzf --preview 'ls -la {} | string escape' )";
      cdg = "cd (cat ${config.xdg.stateHome}/ghq/lastdir | string escape)";
      cdl = "cd (cat ${config.xdg.dataHome}/lf/lastdir | string escape)";
      # global
      "@h" = global "--help";
      "@i" = global "install";
      "@s" = global "search";
      "@p" = global "| less";
      "@v" = global "--version";
      ## docker
      "@dp" = global "(docker ps | tail -n +2 | fzf | awk '{print $1}')";
      "@dpa" = global "(docker ps -a | tail -n +2 | fzf | awk '{print $1}')";
      "@di" = global "(docker image ls | tail -n +2 | fzf | awk '{print $3}')";
      ## mac
      "@cp" = global "| pbcopy";
      "@pst" = global "(pbpaste | string escape)";
      "@icloud" = global "~/Library/Mobile\\ Documents/com~apple~CloudDocs";
    };
    shellInit = ''
      # path
      /opt/homebrew/bin/brew shellenv | source
      fish_add_path ${config.home.homeDirectory}/.orbstack/bin

      # disable greeting
      set fish_greeting

      # variables
      set -x DOCKER_CONFIG ${config.xdg.configHome}/docker
      set -x LESSHISTFILE -
      set -x SSH_AUTH_SOCK $HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
      set -x _ZO_DATA_DIR ${config.xdg.dataHome}/zoxide

      # keybindings
      ## disable exit with <C-d>
      bind \cD delete-char

      ## autosuggestions
      ### <C-l>
      bind \f accept-autosuggestion
      ### <C-f>
      bind \cF forward-single-char

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
      bind \a __ghq-fzf

      # abbreviations
      abbr --add run --set-cursor "nix run nixpkgs#%"
      abbr --add ql --set-cursor "qlmanage -p % &> /dev/null"

      ## .. -> cd ../, ... -> cd ../../, and so on
      function __multicd
        echo cd (string repeat --count (math (string length -- $argv[1]) - 1) ../)
      end
      abbr --add dotdot --regex '^\.\.+$' --function __multicd
    '';
  };
}
