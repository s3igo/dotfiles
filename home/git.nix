{ pkgs, lib, ... }:

let
  email = "85787242+s3igo@users.noreply.github.com";
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINUyMJEMvBM/6QpZ365T7Gwf6KqYVuXKeTgDlKsFoU27";
  difftCommand = lib.getExe pkgs.difftastic;
in

{
  programs = {
    git = {
      enable = true;
      ignores = [
        ".DS_Store"
        ".env"
        ".direnv/" # nix-direnv
        "*.local.*"
        "*.local/"
      ];
      lfs.enable = true;
      signing = {
        key = "key::${key}";
        signByDefault = true;
      };
      settings = {
        user = {
          name = "s3igo";
          inherit email;
        };
        alias = rec {
          # https://difftastic.wilfred.me.uk/git.html#regular-usage
          dlog = "-c diff.external=${difftCommand} log --ext-diff";
          dshow = "-c diff.external=${difftCommand} show --ext-diff";
          ddiff = "-c diff.external=${difftCommand} diff";
          fzf-add = builtins.concatStringsSep " | " [
            fzf-status
            "xargs git add"
          ];
          fzf-log = "!f() { ${
            builtins.concatStringsSep " | " [
              ''git log --no-show-signature --no-abbrev --oneline --color=always "''${1:-HEAD}"''
              "fzf --raw --ansi --accept-nth 1 --preview 'git show --stat --patch --color=always {1}'"
            ]
          }; }; f";
          fzf-status = builtins.concatStringsSep " | " [
            "!git status --short"
            "fzf --multi --preview 'git diff --color=always {-1}' --accept-nth 2"
          ];
          fzf-type = builtins.concatStringsSep " | " [
            "!git log --no-show-signature --format=%s"
            "rg --only-matching '^[a-zA-Z]+(\\([^)]+\\))?(!)?'"
            "awk '!seen[$0]++ {order[++i]=$0} {count[$0]++} END {for (j=1; j<=i; j++) print order[j] \"\\t\" count[order[j]]}'"
            "fzf --accept-nth 1"
          ];
          ghq = builtins.concatStringsSep " | " [
            "!ghq list --full-path"
            "fzf --preview 'tree -C --gitignore {}' || pwd"
            ''while IFS= read -r l; do printf '%q\n' "$l"; done'' # Escape strings
          ];
          msg = "show --no-show-signature --no-patch --format=%B";
          new = ''!f() { gh repo new --private "$1" && gh api "/repos/s3igo/$1" --jq '.clone_url' | ghq get; }; f'';
          untracked = "ls-files -o --exclude-standard";
        };
        column.ui = "auto";
        branch.sort = "-committerdate";
        tag.sort = "-version:refname";
        diff = {
          algorithm = "histogram";
          colorMoved = true;
        };
        gpg = {
          format = "ssh";
          ssh = {
            program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
            allowedSignersFile = "~/.ssh/allowed_signers";
          };
        };
        ghq.root = "~/repos";
        core.ignorecase = "false";
        push = {
          autoSetupRemote = true;
          followTags = true;
        };
        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };
        help.autocorrect = "prompt";
        commit.verbose = true;
        rerere = {
          enabled = true;
          autoupdate = true;
        };
        rebase = {
          autoSquash = true;
          autoStash = true;
          updateRefs = true;
        };
        merge.conflictstyle = "zdiff3";
        pull.ff = "only";
        grep.patternType = "perl";
        log.showSignature = true;
      };
    };

    gh = {
      enable = true;
      settings.aliases = {
        md = "markdown-preview";
      };
      extensions = [
        pkgs.gh-markdown-preview
        pkgs.gh-poi
        (pkgs.callPackage ../packages/gh-license/package.nix { })
      ];
    };

    gh-dash.enable = true;
  };

  home.file.".ssh/allowed_signers".text = builtins.concatStringsSep " " [
    email
    ''namespaces="git"''
    key
  ];
}
