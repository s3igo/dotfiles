{ pkgs, lib, ... }:

{
  programs = {
    git = {
      enable = true;
      aliases = {
        push-force = "push --force-with-lease --force-if-includes";
        sync = "pull --rebase --autostash";
        init-empty = "!git init && git commit --allow-empty -m 'initial commit'";
        init-exist = "!git init && git add . && git commit -m 'first commit'";
        create = ''!f() { ${lib.getExe pkgs.gh} repo create "$1" --private && ${lib.getExe pkgs.ghq} get -p "$1"; }; f'';
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
        "*.ignore.md"
      ];
      lfs.enable = true;
      userName = "s3igo";
      userEmail = "85787242+s3igo@users.noreply.github.com";
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINUyMJEMvBM/6QpZ365T7Gwf6KqYVuXKeTgDlKsFoU27";
        signByDefault = true;
      };
      attributes = [ "*.lockb binary diff=lockb" ];
      extraConfig = {
        diff.lockb = {
          textconv = "bun";
          binary = true;
        };
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
    gh = {
      enable = true;
      settings = {
        # workaround for https://github.com/nix-community/home-manager/issues/4744
        # see: https://github.com/cli/cli/issues/8462
        version = 1;
        git_protocol = "ssh";
      };
    };
  };
}
