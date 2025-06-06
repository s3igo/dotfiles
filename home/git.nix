{ pkgs, ... }:

let
  userEmail = "85787242+s3igo@users.noreply.github.com";
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINUyMJEMvBM/6QpZ365T7Gwf6KqYVuXKeTgDlKsFoU27";
in

{
  programs = {
    git = {
      enable = true;
      aliases = rec {
        fzf-add = builtins.concatStringsSep " | " [
          fzf-status
          "xargs git add"
        ];
        fzf-log = "!f() { ${
          builtins.concatStringsSep " | " [
            ''git log "''${1:-HEAD}" --oneline --color=always''
            "fzf --ansi --reverse --accept-nth 1 --preview 'git show --stat --patch --color=always {1}'"
          ]
        }; }; f";
        fzf-status = builtins.concatStringsSep " | " [
          "!git status --short"
          "fzf --multi --preview 'git diff --color=always {-1}' --accept-nth 2"
        ];
        ghq = builtins.concatStringsSep " | " [
          "!ghq list --full-path"
          "fzf --preview 'tree -C --gitignore {}'"
          ''while IFS= read -r l; do printf '%q\n' "$l"; done'' # Escape strings
        ];
      };
      ignores = [
        ".DS_Store"
        ".env"
        ".direnv/" # nix-direnv
        "*.local.*"
        "*.local/"
      ];
      lfs.enable = true;
      userName = "s3igo";
      inherit userEmail;
      signing = {
        inherit key;
        signByDefault = true;
      };
      extraConfig = {
        column.ui = "auto";
        branch.sort = "-committerdate";
        tag.sort = "-version:refname";
        diff = {
          algorithm = "histogram";
          colorMoved = true;
          mnemonicPrefix = true;
        };
        gpg = {
          format = "ssh";
          ssh = {
            program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
            allowedSignersFile = "~/.ssh/allowed_signers";
          };
        };
        ghq.root = "~/git";
        core = {
          abbrev = 12;
          ignorecase = "false";
        };
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
      };
    };

    gh = {
      enable = true;
      settings.git_protocol = "ssh";
      extensions = with pkgs; [
        gh-copilot
        gh-markdown-preview
      ];
    };

    gh-dash.enable = true;
  };

  home.file.".ssh/allowed_signers".text = builtins.concatStringsSep " " [
    userEmail
    ''namespaces="git"''
    key
  ];
}
