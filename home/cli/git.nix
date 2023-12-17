{ ... }: {
  programs.git = {
    enable = true;
    aliases = {
      co = "commit";
      st = "status";
      edit = "commit --amend";
      append = "commit --amend --no-edit";
      push-force = "push --force-with-lease --force-if-includes";
      sync = "pull --rebase --autostash";
      init-empty = "!git init && git commit --allow-empty -m 'initial commit'";
      init-exist = "!git init && git add . && git commit -m 'first commit'";
      create = ''!f() { gh repo create "$1" --private && ghq get -p "$1"; }; f'';
      pr = ''!f() { git fetch origin "pull/$1/head:PR-$1"; }; f'';
    };
    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
      };
    };
    ignores = [
      ".DS_Store"
      ".env"
      ".direnv/"
      "node_modules/"
    ];
    lfs.enable = true;
    userName = "s3igo";
    userEmail = "85787242+s3igo@users.noreply.github.com";
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINUyMJEMvBM/6QpZ365T7Gwf6KqYVuXKeTgDlKsFoU27";
      signByDefault = true;
    };
    extraConfig = {
      gpg = {
        format = "ssh";
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
      ghq.root = "~/git";
      core.ignorecase = "false";
      push.default = "current";
      pull.ff = "only";
    };
  };
}
