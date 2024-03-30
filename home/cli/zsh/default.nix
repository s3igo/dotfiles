{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history = {
      ignoreAllDups = true;
      ignorePatterns = [ "cd *" ];
      path = "${config.xdg.stateHome}/zsh/history";
    };
    shellAliases = {
      lzd = "lazydocker";
      lg = "lazygit";
      trash = "trash -F";
      cdl = ''cd "$(cat ${config.xdg.dataHome}/lf/lastdir)"'';
      cdf = pkgs.lib.concatStringsSep " " [
        ''cd "$(${pkgs.fd}/bin/fd --hidden --no-ignore --type=directory --exclude=.git''
        ''| ${pkgs.fzf}/bin/fzf --preview "${pkgs.eza}/bin/eza -la --icons --git {}")"''
      ];
      cdg = ''cd "$(cat ${config.xdg.stateHome}/ghq/lastdir)"'';
    };
    shellGlobalAliases = {
      "@d_ps" = ''"$(docker ps | tail -n +2 | ${pkgs.fzf}/bin/fzf | awk '{print $1}')"'';
      "@d_ps-a" = ''"$(docker ps -a | tail -n +2 | ${pkgs.fzf}/bin/fzf | awk '{print $1}')"'';
      "@d_image_ls" = ''"$(docker image ls | tail -n +2 | ${pkgs.fzf}/bin/fzf | awk '{print $3}')"'';
      # mac
      "@cp" = "| pbcopy";
      "@pst" = ''"$(pbpaste)"'';
      "@icloud" = "~/Library/Mobile\\ Documents/com~apple~CloudDocs";
    };
    sessionVariables = {
      DOCKER_CONFIG = "${config.xdg.configHome}/docker";
      LESSHISTFILE = "-";
      SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      _ZO_DATA_DIR = "${config.xdg.dataHome}/zoxide";
    };
    initExtraFirst = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"

      source ${./config.zsh}

      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh

      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      ZSH_HIGHLIGHT_HIGHLIGHTERS+=('main' 'line' 'brackets' 'cursor')
      ZSH_HIGHLIGHT_STYLES+=('alias' 'fg=cyan,bold')
      ZSH_HIGHLIGHT_STYLES+=('path' 'fg=yellow,bold')
      ZSH_HIGHLIGHT_STYLES+=('root' 'bg=red')

      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      bindkey "^P" history-substring-search-up
      bindkey "^N" history-substring-search-down
    '';
    initExtra = ''
      source ${./functions.zsh}

      export FPATH="$XDG_DATA_HOME/zsh/site-functions:$FPATH"

      # node
      export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

      # orbstack
      export PATH="$PATH":${config.home.homeDirectory}/.orbstack/bin

      # bindkey
      bindkey '^U' backward-kill-line

      function __ghq-fzf {
        declare ROOT="$(${pkgs.ghq}/bin/ghq root)"
        declare PREVIEW_CMD="${pkgs.eza}/bin/eza --tree --git-ignore -I 'node_modules|.git' $ROOT/{}"
        declare DEST="$ROOT/$(${pkgs.ghq}/bin/ghq list | ${pkgs.fzf}/bin/fzf --preview $PREVIEW_CMD)"
        declare BUFFER="cd $DEST"
        zle accept-line
        mkdir -p "${config.xdg.stateHome}/ghq"
        echo "$DEST" > "${config.xdg.stateHome}/ghq/lastdir"
      }
      zle -N __ghq-fzf
      bindkey '^G' __ghq-fzf
    '';
  };
}
