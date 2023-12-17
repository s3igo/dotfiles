{ config, ... }: {
  programs.zsh = {
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
      path = "${config.xdg.stateHome}/zsh/history";
    };
    historySubstringSearch = {
      enable = true;
      searchDownKey = [ "^N"];
      searchUpKey = [ "^P" ];
    };
    shellAliases = {
      b = "brew";
      c = "cargo";
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
      cdf = ''cd "$(fd --hidden --no-ignore --type=directory --exclude=.git | fzf --preview "eza -la --icons --git {}")"'';
      cdg = ''cd "$(cat ${config.xdg.stateHome}/ghq/lastdir)"'';
      # typos
      al = "la";
      mkdri = "mkdir";
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
      "@icloud" = "cd ~/Library/Mobile\\ Documents/com~apple~CloudDocs";
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
      _ZO_DATA_DIR = "${config.xdg.dataHome}/zoxide";
      DOCKER_CONFIG = "${config.xdg.configHome}/docker";
      EDITOR = "nvim";
      SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };
    initExtraFirst = ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
    initExtra = ''
      source ${./options.zsh}
      source ${./functions.zsh}
      source ${./keybinds.zsh}
    '';
  };
}
