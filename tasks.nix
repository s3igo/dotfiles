{
  system,
  pkgs,
  nix-darwin,
}:

with pkgs;
let
  deploy = writeShellApplication {
    name = "task_deploy";
    runtimeInputs = [ nix-darwin.packages.${system}.default ];
    text = ''
      sudo -v && darwin-rebuild switch --flake ".#$(scutil --get LocalHostName)"
    '';
  };
  update = writeShellApplication {
    name = "task_update";
    runtimeInputs = [ deploy ];
    text = ''
      nix flake update --commit-lock-file && task_deploy
    '';
  };
  gc = writeShellApplication {
    name = "task_gc";
    text = ''
      sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
      nix profile wipe-history --profile "$XDG_STATE_HOME/nix/profiles/home-manager"
      nix store gc
      nix store optimise
    '';
  };
  versions = writeShellApplication {
    name = "task_versions";
    runtimeInputs = [ gawk ];
    text = ''
      nix profile diff-closures --profile /nix/var/nix/profiles/system \
        | awk 'BEGIN { RS="" } { par=$0 } END { print par }'
    '';
  };
in
[
  deploy
  update
  gc
  versions
]
