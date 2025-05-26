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
    plugins =
      map
        (name: {
          inherit name;
          inherit (pkgs.fishPlugins.${name}) src;
        })
        [
          "autopair"
          "hydro"
        ];
    functions =
      let
        handleFzfPrefix = abbr: expansion: ''
          switch $argv[1]
            case ${abbr}
              echo ${expansion}
            case fzf-${abbr}
              echo fzf-${expansion}
            case '*'
              echo unreachable >&2
              exit 1
          end
        '';
      in
      rec {
        # https://fishshell.com/docs/current/cmds/abbr.html#examples
        __last-history-item = "echo $history[1]";
        __last-token = ''
          set -l tokens (commandline --tokens-raw)
          if test (count $tokens) -gt 1
            echo $tokens[-2]
          end
        '';
        # Current date in ISO 8601 extended format
        __date-impl = "echo (date '+%Y-%m-%d')";
        # $1 length is 2 -> `../`, 3 -> `../../`, 4 -> `../../../`, and so on
        __dots-impl = ''
          set -l len (math (string length -- $argv[1]) - 1)
          echo (string repeat --count $len -- ../)
        '';
        __f-impl = ''
          if test $argv[1] = f
            echo fg
          else if test $argv[1] = ff
            echo 'fg %(jobs | fzf --header-lines 1 --accept-nth 1)'
          else if string match --quiet --regex 'f(?<n>\d)' $argv[1]
            echo "fg %$n"
          else
            echo "unreachable" >&2
            exit 1
          end
        '';
        __git-a-impl = handleFzfPrefix "a" "add";
        __git-l-impl = handleFzfPrefix "l" "log";
        __git-ll-impl = "echo log (${__git-om-impl})..";
        __git-m-impl = "git symbolic-ref refs/remotes/origin/HEAD | cut -d '/' -f4";
        __git-om-impl = "git symbolic-ref --short refs/remotes/origin/HEAD";
        __git-s-impl = handleFzfPrefix "s" "status";
        __snippet = "${lib.getExe pkgs.pet} search";
        # https://fishshell.com/docs/current/cmds/fish_should_add_to_history.html
        fish_should_add_to_history = ''
          # Skip adding commands that begin with whitespace to history
          string match --quiet --regex '^\s+' -- $argv[1]; and return 1

          set -l cmds cd mkdir touch trash 'history\s+delete\s+'
          for cmd in $cmds
            string match --quiet --regex "^$cmd" -- "$argv"; and return 1
          end

          set -l git_subs add branch checkout commit restore diff reset stash switch rebase revert merge
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
        __fzf-a = command "fzf" // regex "a" // text "--accept-nth";
        __fzf-h = command "fzf" // regex "h" // text "--header-lines";
        __git-a = command "git" // regex "(fzf-)?a" // function "__git-a-impl";
        __git-c = command "git" // regex "c" // text "commit";
        __git-d = command "git" // regex "d" // text "diff";
        __git-ds = command "git" // regex "ds" // text "diff --staged";
        __git-f = command "git" // regex "f" // cursor // text "fzf-%";
        __git-l = command "git" // regex "(fzf-)?l" // function "__git-l-impl";
        __git-ll = command "git" // regex "ll" // function "__git-ll-impl";
        __git-m = command "git" // regex "m" // function "__git-m-impl";
        __git-o = command "git" // regex "o" // text "origin";
        __git-om = command "git" // regex "om" // function "__git-om-impl";
        __git-s = command "git" // regex "(fzf-)?s" // function "__git-s-impl";
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
        # https://fishshell.com/docs/current/interactive.html#abbreviations
        # matches `..`, `...`, `....`, and so on
        __dots = global // regex "\\.{2,}" // function "__dots-impl";
        "!!" = global // function "__last-history-item";
        "!?" = global // function "__last-token";
        ",c" = global // text "| pbcopy";
        ",C" = global // text "&| pbcopy";
        ",cp" = global // text "| tee /dev/tty | tr -d '\\n' | pbcopy";
        ",date" = global // function "__date-impl";
        ",f" = global // text "| fzf";
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
        ",g" = global // text "| rg";
        ",s" = global // text "search";
        ",sn" = global // function "__snippet";
        ",t" = global // text "| tee /dev/tty";
        ",tr" = global // text "| tr -d '\\n'";
        ",v" = global // text "--version";
        ",x" = global // text "| xargs";
        ai = "aichat";
        c = "cd";
        cl = "clear";
        cmd = "commandline";
        cp = "cp -iv";
        di = "direnv";
        do = "docker";
        ef = "exec fish";
        f = regex "f(\\d?|f)" // function "__f-impl";
        g = "git";
        hi = "history";
        j = "just";
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
      set -g fish_greeting

      # LS_COLORS
      set --export LS_COLORS "$(${lib.getExe pkgs.vivid} generate iceberg-dark)"

      # Prompt
      # https://github.com/jorgebucaran/hydro?tab=readme-ov-file#configuration
      set -g hydro_symbol_start '\n'
      set -g hydro_symbol_git_dirty '*'

      set -g hydro_color_pwd green
      set -g hydro_color_git magenta
      set -g hydro_color_prompt cyan
      set -g hydro_color_duration yellow

      set -g hydro_multiline true

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

      ## Utilities that require command line rewriting
      ## Because abbr does not allow rewriting the entire command line
      ## https://github.com/fish-shell/fish-shell/issues/11324#issuecomment-2759099816
      bind ctrl-s,ctrl-g "commandline --replace 'cd (git ghq)'"
      bind ctrl-s,ctrl-d "commandline --replace 'rm -rfv .direnv; and direnv allow'"

      # Tab completion for `zellij delete-session`
      # https://github.com/zellij-org/zellij/issues/3055
      complete -c zellij -n "__fish_seen_subcommand_from delete-session" -f -a "(__fish_complete_sessions)" -d "Session"
      complete -c zellij -n "__fish_seen_subcommand_from d" -f -a "(__fish_complete_sessions)" -d "Session"
    '';
  };
}
