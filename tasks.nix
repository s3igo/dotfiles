{
  pkgs,
  mkApp,
  nix-darwin',
}:

let
  deploy = pkgs.writeShellApplication {
    name = "deploy";
    runtimeInputs = [ nix-darwin' ];
    text = ''
      darwin-rebuild switch --flake ".#$(scutil --get LocalHostName)"
    '';
  };
  wipe-history = pkgs.writeShellApplication {
    name = "wipe-history";
    text = ''
      sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
      nix profile wipe-history --profile "$XDG_STATE_HOME/nix/profiles/home-manager"
    '';
  };
  versions = pkgs.writeShellApplication {
    name = "versions";
    runtimeInputs = [ pkgs.gawk ];
    text = ''
      nix profile diff-closures --profile /nix/var/nix/profiles/system \
        | awk 'BEGIN { RS="" } { par=$0 } END { print par }'
    '';
  };
in

{
  deploy = mkApp { drv = deploy; };
  wipe-history = mkApp { drv = wipe-history; };
  versions = mkApp { drv = versions; };
}
