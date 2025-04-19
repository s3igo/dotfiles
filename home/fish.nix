{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (config.home) homeDirectory;
in

{
  programs.fish = {
    enable = true;
    plugins = [
      rec {
        name = "autopair";
        inherit (pkgs.fishPlugins.${name}) src;
      }
    ];
    functions = {
      # https://fishshell.com/docs/current/cmds/abbr.html#examples
      __last-history-item = "echo $history[1]";
      __last-token = ''
        set --local tokens (commandline --tokens-raw)
        if test (count $tokens) -gt 1
          echo $tokens[-2]
        end
      '';
      # Current date in ISO 8601 extended format
      __date-impl = "echo (date '+%Y-%m-%d')";
      # $1 length is 2 -> `../`, 3 -> `../../`, 4 -> `../../../`, and so on
      __dots-impl = "echo (string repeat --count (math (string length -- $argv[1]) - 1) -- ../)";
      # $1 length is 1 -> `@`, 2 -> `@~`, 3 -> `@~~`, 4 -> `@~~~`, and so on
      __git-h-impl = ''
        set --local len (math (string length -- $argv[1]) - 1)
        if test $len -eq 0
          echo @
        else
          echo @(string repeat --count $len -- '~')
        end
      '';
      # https://fishshell.com/docs/current/cmds/fish_should_add_to_history.html
      fish_should_add_to_history = ''
        # Skip adding commands that begin with whitespace to history
        string match --quiet --regex '^\s+' -- $argv[1]; and return 1

        set --local cmds cd mkdir touch trash 'history\s+delete\s+'
        for cmd in $cmds
          string match --quiet --regex "^$cmd" -- "$argv"; and return 1
        end

        set --local git_subs add branch checkout commit restore diff reset stash switch rebase revert merge
        if test (count $argv) -gt 1; and test $argv[1] = git
          for git_sub in $git_subs
            test $argv[2] = $git_sub; and return 1
          end

          if test $argv[2] = log
            # Matches 12-character or 40-character commit hashes
            string match --quiet --regex '^([0-9a-f]{12}|[0-9a-f]{40})$' -- $argv; and return 1
            # Matches "^<commit>"
            string match --quiet --regex '^\^([0-9a-f]{12}|[0-9a-f]{40})$' -- $argv; and return 1
            # Matches "<commit1>..<commit2>"
            string match --quiet \
              --regex '^([0-9a-f]{12}|[0-9a-f]{40})?\.{2,3}([0-9a-f]{12}|[0-9a-f]{40})?$' \
              -- $argv; and return 1
          end
        end

        return 0
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
        command = command: { inherit command; };
        function = function: { inherit function; };
        regex = regex: { inherit regex; };
        text = expansion: { inherit expansion; };
      in
      {
        # https://fishshell.com/docs/current/cmds/abbr.html#add-subcommand
        # Using `--regex` to expand the same word differently for multiple
        # commands.
        # > Even with different COMMANDS, the NAME of the abbreviation needs to
        # > be unique. Consider using --regex if you want to expand the same
        # > word differently for multiple commands.
        __cd-g =
          command "cd"
          // regex "g"
          // text "(${
            builtins.concatStringsSep " | " [
              "ghq list --full-path"
              "fzf --preview 'tree -C --gitignore {}'"
              "string escape"
            ]
          })";
        __fzf-a = command "fzf" // regex "a" // text "--accept-nth";
        __fzf-h = command "fzf" // regex "h" // text "--header-lines";
        __git-a = command "git" // regex "a" // text "add";
        __git-b = command "git" // regex "b" // text "branch";
        __git-c = command "git" // regex "c" // text "commit";
        __git-d = command "git" // regex "d" // text "diff";
        __git-f =
          command "git"
          // regex "f"
          // cursor
          // text (
            builtins.concatStringsSep " | " [
              "log % --oneline --color=always"
              "fzf --ansi --reverse --accept-nth 1 --preview 'git show --stat --patch --color=always {1}'"
              "tee /dev/tty"
              "pbcopy"
            ]
          );
        __git-h = command "git" // regex "h+" // function "__git-h-impl";
        __git-l = command "git" // regex "l" // text "log";
        __git-m = command "git" // regex "m" // text "main";
        __git-o = command "git" // regex "o" // text "origin";
        __git-om = command "git" // regex "om" // cursor // text "origin/main%";
        __git-r = command "git" // regex "r" // text "restore";
        __git-s = command "git" // regex "s" // text "status";
        __nix-b = command "nix" // regex "b" // text "build";
        __nix-c = command "nix" // regex "c" // cursor // text ".#% --";
        __nix-d = command "nix" // regex "d" // cursor // text "~/.dotfiles#% --";
        __nix-dv = command "nix" // regex "dv" // cursor // text "~/.dotfiles#neovim% --";
        __nix-f = command "nix" // regex "f" // text "flake";
        __nix-g = command "nix" // regex "g" // cursor // text "github:%# --";
        __nix-gd = command "nix" // regex "gd" // cursor // text "github:s3igo/dotfiles#% --";
        __nix-gdv = command "nix" // regex "gdv" // cursor // text "github:s3igo/dotfiles#neovim% --";
        __nix-i = command "nix" // regex "i" // text "--inputs-from .";
        __nix-n = command "nix" // regex "n" // cursor // text "nixpkgs#% --";
        __nix-r = command "nix" // regex "r" // text "run";
        __rm-d = command "rm" // regex "d" // text "-rf .direnv; and direnv allow";
        # https://fishshell.com/docs/current/interactive.html#abbreviations
        __dots =
          global
          // regex "\\.{2,}" # matches `..`, `...`, `....`, and so on
          // function "__dots-impl";
        "!!" = global // function "__last-history-item";
        "!?" = global // function "__last-token";
        ",cp" = global // text "| pbcopy";
        ",date" = global // function "__date-impl";
        ",f" = global // text "| fzf";
        ",g" = global // text "| rg";
        ",h" = global // text "--help";
        ",i" = global // text "install";
        # http://www.rikai.com/library/kanjitables/kanji_codes.unicode.shtml
        # Hiragana: 0x3040 - 0x309f
        # Katakana: 0x30a0 - 0x30ff
        # CJK unified ideographs Extension A - Rare kanji: 0x3400 - 0x4dbf
        # CJK unified ideographs - Common and uncommon kanji: 0x4e00 - 0x9faf
        # Full-width roman characters and half-width katakana: 0xff00 - 0xffef
        ",ja" =
          global
          // text "'[\\x{3040}-\\x{30ff}\\x{3400}-\\x{4dbf}\\x{4e00}-\\x{9faf}\\x{ff00}-\\x{ffef}]'";
        ",icloud" = global // text "~/Library/Mobile\\ Documents/com~apple~CloudDocs";
        ",n" = global // text "/dev/null";
        ",o" = global // text "/dev/stdout";
        ",t" = global // text "| tee /dev/tty";
        ",s" = global // text "search";
        ",v" = global // text "--version";
        ai = "aichat";
        c = "cd";
        cl = "clear";
        cmd = "commandline";
        cp = "cp -iv";
        di = "direnv";
        do = "docker";
        ef = "exec fish";
        f = "fg";
        g = "git";
        hi = "history";
        mk = "mkdir";
        mv = "mv -iv";
        n = "nix";
        nv = "neovim";
        pst = "pbpaste";
        ql = cursor // text "qlmanage -p % &> /dev/null";
        rm = "rm -iv";
        v = "nvim";
        zj = "zellij";
      };
    loginShellInit = ''
      # PATH
      if test -d ${homeDirectory}/.orbstack
        fish_add_path ${homeDirectory}/.orbstack/bin
      end
    '';
    interactiveShellInit = ''
      # Disable greeting
      set --global fish_greeting

      # LS_COLORS
      set --export LS_COLORS "$(${lib.getExe pkgs.vivid} generate iceberg-dark)"

      # Keybindings
      ## Disable exit with ctrl-d
      bind ctrl-d delete-char

      ## Insert space without expanding abbreviation
      bind alt-space "commandline --insert ' '"

      ## Bigword
      bind alt-F forward-bigword
      bind alt-B backward-bigword
      bind ctrl-W backward-kill-bigword

      ## Autosuggestions
      bind ctrl-l accept-autosuggestion
      bind ctrl-f forward-single-char

      ## History
      bind alt-p history-token-search-backward
      bind alt-n history-token-search-forward
      bind alt-r history-pager
      bind ctrl-backspace history-pager-delete

      ## Pager
      bind ctrl-o __fish_paginate

      # Tab completion for `zellij delete-session`
      # https://github.com/zellij-org/zellij/issues/3055
      complete -c zellij -n "__fish_seen_subcommand_from delete-session" -f -a "(__fish_complete_sessions)" -d "Session"
      complete -c zellij -n "__fish_seen_subcommand_from d" -f -a "(__fish_complete_sessions)" -d "Session"
    '';
  };
}
