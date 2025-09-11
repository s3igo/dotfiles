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
        genericFzfPatterns = prefix: ''

          set -l tokens (commandline --tokens-expanded --current-job)
          set -l cmdline (string replace --regex '${prefix}.*$' "" -- "$tokens" )

          switch "$argv[1]"
            case '${prefix}'
              complete -C "$cmdline" | fzf --tiebreak begin --nth 1 --accept-nth 1
            case '*'
              set -l query (string replace --regex '^${prefix}' "" "$argv[1]")
              complete -C "$cmdline" \
                | fzf --tiebreak begin --nth 1 --filter "$query" \
                | head -n1 \
                | cut -f1
          end
        '';
        mkFzfPatterns =
          {
            cmdline,
            shortcuts ? { },
          }:
          prefix:
          let
            indexAfterPrefix = offset: toString (builtins.stringLength prefix + offset + 1);
          in
          ''

            switch "$argv[1]"
            case '${prefix}'
              # do nothing

            ${lib.pipe shortcuts [
              (lib.mapAttrsToList (
                name: value: ''
                  case '${prefix}${name}'
                    ${value}
                ''
              ))
              (builtins.concatStringsSep "\n")
            ]}
            case '${prefix},'
              complete -C '${cmdline}' | fzf --tiebreak begin --nth 1 --accept-nth 1

            case "${prefix},*"
              set -l query (string sub --start ${indexAfterPrefix 1} -- "$argv[1]")
              complete -C '${cmdline}' \
                | fzf --tiebreak begin --nth 1 --accept-nth 1 --query "$query"

            case '*'
              set -l query (string sub --start ${indexAfterPrefix 0} -- "$argv[1]")
              complete -C '${cmdline}' \
                | fzf --tiebreak begin --nth 1 --filter "$query" \
                | head -n1 \
                | cut -f1
            end
          '';
        nixFzfPatterns = mkFzfPatterns {
          cmdline = "nix ";
          shortcuts = {
            d = "echo develop";
            df = "echo develop -c fish";
            r = "echo run";
          };
        };
        gitFzfPatterns = mkFzfPatterns {
          cmdline = "git ";
          shortcuts = {
            b = "echo branch";
            c = "echo commit";
            d = "echo diff";
            ds = "echo diff --staged";
            l = "echo log";
            ll = "echo log (git symbolic-ref --short refs/remotes/origin/HEAD)..";
            s = "echo status";
          };
        };
      in
      {
        # https://fishshell.com/docs/current/cmds/abbr.html#examples
        __last-history-item = "echo $history[1]";
        __last-token = ''
          set -l tokens (commandline --tokens-raw)
          if test (count $tokens) -gt 1
            echo "$tokens[-2]"
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
          if test "$argv[1]" = f
            echo fg
          else if test "$argv[1]" = ff
            echo 'fg %(jobs | fzf --accept-nth 1)'
          else if string match --quiet --regex 'f(?<n>\d)' $argv[1]
            echo "fg %$n"
          else
            echo unreachable >&2
            exit 1
          end
        '';
        __git-subcmd-impl = gitFzfPatterns ",";
        __comma-g-impl = "echo git (${gitFzfPatterns ",g"})";
        __nix-subcmd-impl = nixFzfPatterns ",";
        __comma-n-impl = "echo nix (${nixFzfPatterns ",n"})";
        __nix-system-impl = "nix eval --impure --raw --expr 'builtins.currentSystem'";
        __snippet = "${lib.getExe pkgs.pet} search";
        __forward-pipe = ''
          set -l pos (commandline --cursor)
          set -l offset (commandline \
            | string sub --start (math $pos + 2) \
            | string match --index --regex '\|' \
            | string split ' ')
          set offset $offset[1]

          if test -n "$offset"
            commandline --cursor (math $pos + $offset)
          end
        '';
        __backward-pipe = ''
          set -l pos (commandline --cursor)
          set -l pipe_positions (commandline | string match --all --index --regex '\|')

          set -l target_pipe ""
          for pipe_pos in $pipe_positions
            set pipe_pos (string split ' ' -- $pipe_pos)
            set pipe_pos $pipe_pos[1]
            if test $pipe_pos -le $pos
              set target_pipe (math $pipe_pos - 1)
            else
              break
            end
          end

          if test -n "$target_pipe"
            commandline --cursor $target_pipe
          end
        '';
        __delete-to-next-pipe = ''
          set -l cmdline (commandline)
          set -l pos (commandline --cursor)
          set -l offset (echo $cmdline \
            | string sub --start (math $pos + 2) \
            | string match --index --regex '\|' \
            | string split ' ')
          set offset $offset[1]

          if test -n "$offset"
            set -l before_deletion (string sub --end $pos -- $cmdline)
            set -l after_deletion (string sub --start (math $pos + $offset) -- $cmdline)
            commandline --replace "$before_deletion$after_deletion"
            commandline --cursor $pos
          end
        '';
        __delete-to-prev-pipe = ''
          set -l cmdline (commandline)
          set -l pos (commandline --cursor)
          set -l pipe_positions (commandline | string match --all --index --regex '\|')

          set -l last_pipe_pos ""
          for pipe_pos in $pipe_positions
            set pipe_pos (string split ' ' -- $pipe_pos)
            set pipe_pos $pipe_pos[1]
            if test $pipe_pos -le $pos
              set last_pipe_pos (math $pipe_pos - 1)
            else
              break
            end
          end

          if test -n "$last_pipe_pos"
            set -l target_pos (math $last_pipe_pos + 2)
            set -l before_deletion (string sub --end $target_pos -- $cmdline)
            set -l after_deletion (string sub --start (math $pos + 1) -- $cmdline)
            commandline --replace "$before_deletion$after_deletion"
            commandline --cursor $target_pos
          end
        '';
        # https://fishshell.com/docs/current/cmds/fish_should_add_to_history.html
        fish_should_add_to_history = ''
          # Skip adding commands that begin with whitespace to history
          string match --quiet --regex '^\s+' -- "$argv[1]"; and return 1

          # set -l cmds cd mkdir touch trash 'history\s+delete\s+'
          # for cmd in $cmds
          #   string match --quiet --regex "^$cmd" -- "$argv"; and return 1
          # end

          # set -l git_subs add branch checkout commit restore diff reset stash switch rebase revert merge
          # if test (count $argv) -gt 1; and test $argv[1] = git
          #   for git_sub in $git_subs
          #     test $argv[2] = $git_sub; and return 1
          #   end

          #   if test $argv[2] = log
          #     # Matches 12-character or 40-character commit hashes
          #     string match --quiet --regex '^([0-9a-f]{12}|[0-9a-f]{40})$' -- $argv; and return 1
          #     # Matches "^<commit>"
          #     string match --quiet --regex '^\^([0-9a-f]{12}|[0-9a-f]{40})$' -- $argv; and return 1
          #     # Matches "<commit1>..<commit2>"
          #     string match --quiet \
          #       --regex '^([0-9a-f]{12}|[0-9a-f]{40})?\.{2,3}([0-9a-f]{12}|[0-9a-f]{40})?$' \
          #       -- $argv; and return 1
          #   end
          # end

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
        __fzf-a = command "fzf" // regex "@a" // text "--accept-nth";
        __fzf-h = command "fzf" // regex "@h" // text "--header-lines";
        # https://fishshell.com/docs/current/interactive.html#abbreviations
        # matches `..`, `...`, `....`, and so on
        __dots = global // regex "\\.{2,}" // function "__dots-impl";
        "!!" = global // function "__last-history-item";
        "!?" = global // function "__last-token";
        ":c" = global // text "| pbcopy";
        ":cp" = global // text "| tee /dev/tty | tr -d '\\n' | pbcopy";
        ":date" = global // function "__date-impl";
        ":f" = global // text "| fzf";
        ":h" = global // text "--help";
        # http://www.rikai.com/library/kanjitables/kanji_codes.unicode.shtml
        # Hiragana: 0x3040 - 0x309f
        # Katakana: 0x30a0 - 0x30ff
        # CJK unified ideographs Extension A - Rare kanji: 0x3400 - 0x4dbf
        # CJK unified ideographs - Common and uncommon kanji: 0x4e00 - 0x9faf
        # Full-width roman characters and half-width katakana: 0xff00 - 0xffef
        # ",ja" =
        #   global // text "'[\\x{3040}-\\x{30ff}\\x{3400}-\\x{4dbf}\\x{4e00}-\\x{9faf}\\x{ff00}-\\x{ffef}]'";
        # ",icloud" = global // text "~/Library/Mobile\\ Documents/com~apple~CloudDocs";
        ":g" = global // text "| rg";
        ":sn" = global // function "__snippet";
        ":t" = global // text "| tee /dev/tty";
        ":tr" = global // text "| tr -d \\n";
        ":v" = global // text "--version";
        ":x" = global // text "| xargs";
        ai = "aichat";
        c = "cd";
        cl = "clear";
        cmd = "commandline";
        cp = "cp -iv";
        di = "direnv";
        do = "docker";
        ef = "exec fish";
        f = regex "f(\\d?|f)" // function "__f-impl";
        __comma-g = regex ",g.*" // function "__comma-g-impl";
        __git-subcmd = command "git" // regex ",.*" // function "__git-subcmd-impl";
        hi = "history";
        jo = "jobs";
        mk = "mkdir";
        mv = "mv -iv";
        __comma-n = regex ",n.*" // function "__comma-n-impl";
        __nix-subcmd = command "nix" // regex ",.*" // function "__nix-subcmd-impl";
        "@system" = global // function "__nix-system-impl";
        # __nix-system = command "nix" // regex "@system" // function "__nix-system-impl";
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
      # https://github.com/jorgebucaran/hydro#configuration
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

      bind ctrl-alt-f __forward-pipe
      bind ctrl-alt-b __backward-pipe
      bind ctrl-alt-d __delete-to-next-pipe
      bind ctrl-alt-w __delete-to-prev-pipe

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
      # bind ctrl-s,ctrl-d "commandline --replace 'rm -rfv .direnv; and direnv allow'"
      # bind ctrl-s,ctrl-f "commandline --replace fd --type f . \ | fzf --preview 'bat --style=numbers,changes --color=always {}'"
      # bind ctrl-s,ctrl-g "commandline --replace 'cd (git ghq)'"

      # Tab completion for `zellij delete-session`
      # https://github.com/zellij-org/zellij/issues/3055
      complete -c zellij -n "__fish_seen_subcommand_from delete-session" -f -a "(__fish_complete_sessions)" -d "Session"
      complete -c zellij -n "__fish_seen_subcommand_from d" -f -a "(__fish_complete_sessions)" -d "Session"
    '';
    # fzfのfish-integrationのctrl-tキーバインドを削除。
    # このシェル統合のインストール処理はnixpkgsのfzfのパッケージ定義のpostInstallにハードコードされているため、
    # 再ビルドをトリガーせずに「そもそもインストールしない」ことはできない。
    shellInitLast = ''
      status is-interactive; and begin
        bind --erase ctrl-t
        bind --erase ctrl-t --mode insert
      end
    '';
  };
}
