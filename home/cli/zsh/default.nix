{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    history = {
      ignoreAllDups = true;
      ignorePatterns = ["cd *"];
      path = "${config.xdg.stateHome}/zsh/history";
    };
    historySubstringSearch = {
      enable = true;
      searchUpKey = ["^P"];
      searchDownKey = ["^N"];
    };
    shellAliases = {
      g = "git";
      lzd = "lazydocker";
      lg = "lazygit";
      nv = "nvim";
      restart = "exec $SHELL -l";
      trash = "trash -F";
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
      cdl = ''cd "$(cat ${config.xdg.dataHome}/lf/lastdir)"'';
      cdf = pkgs.lib.concatStrings [
        ''cd "$(${pkgs.fd}/bin/fd --hidden --no-ignore --type=directory --exclude=.git''
        ''| ${pkgs.fzf}/bin/fzf --preview "${pkgs.eza}/bin/eza -la --icons --git {}")"''
      ];
      cdg = ''cd "$(cat ${config.xdg.stateHome}/ghq/lastdir)"'';
      # typos
      al = "la";
      mkdri = "mkdir";
    };
    shellGlobalAliases = {
      "@i" = "install";
      "@u" = "uninstall";
      "@s" = "search";
      "@d_ps" = ''"$(docker ps | tail -n +2 | ${pkgs.fzf}/bin/fzf | awk '{print $1}')"'';
      "@d_ps-a" = ''"$(docker ps -a | tail -n +2 | ${pkgs.fzf}/bin/fzf | awk '{print $1}')"'';
      "@d_image_ls" = ''"$(docker image ls | tail -n +2 | ${pkgs.fzf}/bin/fzf | awk '{print $3}')"'';
      # mac
      "@cp" = "| pbcopy";
      "@pst" = ''"$(pbpaste)"'';
      "@icloud" = "cd ~/Library/Mobile\\ Documents/com~apple~CloudDocs";
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "line" "brackets" "cursor"];
      styles = {
        alias = "fg=cyan,bold";
        path = "fg=yellow,bold";
        root = "bg=red";
      };
    };
    sessionVariables = {
      DOCKER_CONFIG = "${config.xdg.configHome}/docker";
      LESSHISTFILE = "-";
      SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      _ZO_DATA_DIR = "${config.xdg.dataHome}/zoxide";
    };
    initExtraFirst = ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
    initExtra = ''
      source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh
      source ${./options.zsh}
      source ${./functions.zsh}

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
