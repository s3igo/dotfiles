{
  perSystem =
    {
      pkgs,
      lib,
      config,
      inputs',
      ...
    }:

    {
      mission-control.scripts = {
        deploy = {
          description = "Deploy system configuration";
          category = "System";
          exec = pkgs.writeShellApplication {
            name = "deploy";
            runtimeInputs = [ inputs'.nix-darwin.packages.default ];
            text = ''
              sudo darwin-rebuild switch --flake "$(${lib.getExe config.flake-root.package})#$(whoami)@$(hostname -s)"
            '';
          };
        };

        wipe-history = {
          description = "Clear profile history for system and home-manager";
          category = "System";
          exec = ''
            sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
            nix profile wipe-history --profile "$XDG_STATE_HOME/nix/profiles/home-manager"
          '';
        };

        versions = {
          description = "Show system profile version differences";
          category = "System";
          exec = pkgs.writeShellApplication {
            name = "versions";
            runtimeInputs = [ pkgs.gawk ];
            text = ''
              nix profile diff-closures --profile /nix/var/nix/profiles/system \
                | awk 'BEGIN { RS="" } { par=$0 } END { print par }'
            '';
          };
        };
      };
    };
}
