{
  inputs,
  lib,
  config,
  ...
}:

let
  inherit (lib) mkOption types;
  cfg = config.configurations;

  # Parse system string to get architecture and OS
  # Type: String -> { arch :: String; os :: String }
  parseSystem =
    system:
    assert system != null && system != "" || throw "System string cannot be null or empty";
    # Ref: https://github.com/NixOS/nixpkgs/blob/master/lib/systems/flake-systems.nix
    assert
      (builtins.match "^(x86_64|aarch64|armv[67]l|i686|powerpc64le|riscv64)-(linux|darwin|freebsd)$" system)
      != null
      || throw "Invalid system format. Expected 'arch-os' (e.g., 'x86_64-linux')";
    let
      parts = builtins.elemAt (lib.splitString "-" system);
    in
    {
      arch = parts 0;
      os = parts 1;
    };

  darwinTargets = builtins.attrNames (
    lib.filterAttrs (_: v: (parseSystem v.system).os == "darwin") cfg.targets
  );
in

{
  options.configurations = {
    profiles = mkOption {
      type = types.attrsOf (types.attrsOf types.anything);
      description = "Configuration profiles for different environments";
      example = {
        darwin.mbp2023.networking.hostName = "mbp2023";
        home.s3igo.programs.fish.enable = true;
      };
    };

    globalArgs = mkOption {
      type = types.attrs;
      description = "Global arguments to be passed to all configurations";
      example.inputs = "flake inputs";
    };

    targets = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            system = mkOption {
              type = types.str;
              description = "Target system architecture";
              example = "aarch64-darwin";
            };
            host = mkOption {
              type = types.str;
              description = "Hostname of the target system";
              example = "mbp2023";
            };
            user = mkOption {
              type = types.str;
              description = "Username for the target system";
              example = "s3igo";
            };
          };
        }
      );
      description = "Target configurations for different systems";
    };
  };

  config.flake = {
    darwinConfigurations = lib.genAttrs darwinTargets (
      target:
      let
        val = cfg.targets.${target};
      in
      inputs.nix-darwin.lib.darwinSystem {
        specialArgs = cfg.globalArgs // {
          inherit (val) system host user;
        };
        modules = [
          (
            { user, ... }:
            {
              users.users.${user} = {
                name = user;
                home = "/Users/${user}";
                # shell = pkgs.zsh;
              };
            }
          )
          cfg.profiles.darwin.${val.host}
          inputs.home-manager.darwinModules.home-manager
          (
            {
              user,
              inputs,
              ...
            }:
            {
              nixpkgs.overlays = [
                config.flake.overlays.joshuto
                config.flake.overlays.tdf
                config.flake.overlays.ov
                config.flake.overlays.gh-copilot
              ];
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit user inputs;
                  inherit (inputs) self;
                };
                users.${user} = cfg.profiles.home.${val.user};
              };
            }
          )
        ];
      }
    );
  };
}
