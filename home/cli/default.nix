{ ... }: {
  imports = [ ./starship.nix ];

  programs = {
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      defaultKeymap = "emacs";
      antidote = {
        enable = true;
        plugins = [
          "hlissner/zsh-autopair"
          "zpm-zsh/undollar"
        ];
      };
      dotDir = ".config/zsh";
      history = {
        ignoreAllDups = true;
        ignorePatterns = [ "cd *" ];
        path = "$XDG_STATE_HOME/zsh/history";
      };
      historySubstringSearch = {
        enable = true;
        # searchDownKey = [ "^N"];
        # searchUpKey = [ "^P" ];
      };
      shellAliases = {
        b = "brew";
        c = "cargo";
        g = "git";
        lzd = "lazydocker";
        lg = "lazygit";
        nv = "nvim";
        restart = "exec $SHELL -l";
        # -iv: interactive, verbose
        cp = "cp -iv";
        mv = "mv -iv";
        rm = "rm -iv";
        # cd
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "......" = "cd ../../../../..";
        "......." = "cd ../../../../../..";
        cdla = "cd $_";
        cdl = ''cd "$(cat $XDG_DATA_HOME/lf/lastdir)"'';
        cdf = ''cd "$(fd --hidden --no-ignore --type=directory --exclude=.git | fzf --preview "eza -la --icons --git {}")"'';
        cdg = ''cd "$(cat $XDG_STATE_HOME/ghq/lastdir)"'';
        # typos
        al = "la";
        mkdri = "mkdir";
        # mac
        ql = "qlmanage -p";
        trash = "trash -F";
      };
      shellGlobalAliases = {
        "@i" = "install";
        "@u" = "uninstall";
        "@s" = "search";
        "@d_ps" = ''"$(docker ps | tail -n +2 | fzf | awk '{print $1}')"'';
        "@d_ps-a" = ''"$(docker ps -a | tail -n +2 | fzf | awk '{print $1}')"'';
        "@d_image_ls" = ''"$(docker image ls | tail -n +2 | fzf | awk '{print $3}')"'';
        # mac
        "@cp" = "| pbcopy";
        "@pst" = ''"$(pbpaste)"'';
        "@icloud" = "cd ~/Library/Mobile\ Documents/com~apple~CloudDocs";
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = [ "main" "line" "brackets" "cursor" ];
        styles = {
          alias = "fg=cyan,bold";
          path = "fg=yellow,bold";
          root = "bg=red";
        };
      };
      sessionVariables = {
        LANG = "ja_JP.UTF-8";
        _ZO_DATA_DIR = "$XDG_DATA_HOME/zoxide";
        DOCKER_CONFIG = "$XDG_CONFIG_HOME/docker";
        LESSHISTFILE = "$XDG_CACHE_HOME/less/history";
        EDITOR = "nvim";
        SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      };
      initExtra = ''
        # initialize direnv, gh, zoxide
        type direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"
        type gh > /dev/null 2>&1 && eval "$(gh completion -s zsh)"
        type zoxide > /dev/null 2>&1 && eval "$(zoxide init zsh)"

        # prohibit overwriting existing files
        set -o noclobber
        # prohibit exiting with Ctrl-D
        set -o ignoreeof
        # auto correct
        setopt correct
        # disable beep
        unsetopt beep

        # completion
        zstyle ':completion:*' menu select interactive
        setopt menu_complete

        # node
        declare -x NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
        type fnm > /dev/null 2>&1 && eval "$(fnm env --use-on-cd)"

        # rust
        declare -x RUSTUP_HOME="$XDG_DATA_HOME/rustup"
        declare -x CARGO_HOME="$XDG_DATA_HOME/cargo"
        type rustup-init > /dev/null 2>&1 && source "$CARGO_HOME/env"

        # functions
        function ls {
            eza --icons --git "$@" 2> /dev/null || command ls "$@"
        }
        function lt {
            eza -T --icons "$@" 2> /dev/null || command tree "$@"
        }
        function la {
            eza -la --icons --git "$@" 2> /dev/null || command ls -la "$@"
        }

        function timestamp {
            [[ $# == 0 ]] && date '+%Y%m%d%H%M%S' && return 0
            [[ $# > 1 ]] && echo 'error: too many arguments' && return 1

            declare ext="''${1#*.}"
            declare now="$(date +%Y%m%d%H%M%S)"
            command mv "$1" "''${now}.''${ext}"
        }

        function rosetta {
            [[ $# == 0 ]] && arch -x86_64 zsh && return 0
            arch -x86_64 zsh -c "$*"
        }

        function hashmv {
            [[ $# == 0 ]] && echo 'error: missing argument' && return 1
            [[ $# > 1 ]] && echo 'error: too many arguments' && return 1

            declare EXT="''${1#*.}"
            declare HASH="''$(shasum -a 256 "$1" | cut -d ' ' -f 1)"
            declare NAME="''${HASH}.''${EXT}"

            mv "$1" "$NAME"
            echo "$NAME"
        }

        function arc {
            open -a 'Arc.app' "$@"
        }

        # keybind
        bindkey '^U' backward-kill-line

        function __ghq-fzf {
            declare ROOT="$(ghq root)"
            declare PREVIEW_CMD="eza --tree --git-ignore -I 'node_modules|.git' ''${ROOT}/{}"
            declare DEST="''${ROOT}/$(ghq list | fzf --preview ''${PREVIEW_CMD})"
            declare BUFFER="cd ''${DEST}"
            zle accept-line
            mkdir -p "''${XDG_STATE_HOME}/ghq"
            echo "$DEST" > "''${XDG_STATE_HOME}/ghq/lastdir"
        }
        zle -N __ghq-fzf
        bindkey '^G' __ghq-fzf
      '';
    };
  };
}
