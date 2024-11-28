{
  inputs,
  lib,
  config,
  ...
}:

let
  cfg = config.configurations;

  inherit (lib) mkOption types;

  # Type: String -> { arch :: String; os :: String }
  parseSystem =
    system:
    assert system != null && system != "" || throw "System string cannot be null or empty";
    # ref: https://github.com/NixOS/nixpkgs/blob/master/lib/systems/flake-systems.nix
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

  # Type: Path -> Path
  resolveNixPath =
    path:
    assert builtins.isPath path || throw "Path must be a valid path";
    let
      defaultPath = path + "/default.nix";
      directPath = /. + ((toString path) + ".nix");
    in
    if builtins.pathExists defaultPath then
      defaultPath
    else if builtins.pathExists directPath then
      directPath
    else
      throw "Neither ${defaultPath} nor ${directPath} exists";

  darwinTargets = builtins.attrNames (
    lib.filterAttrs (_: v: (parseSystem v.system).os == "darwin") cfg.targets
  );
in

{
  options.configurations = {
    base = mkOption {
      type = types.attrsOf types.path;
      description = "Base configuration paths for different environments";
      example = {
        darwin = "/path/to/darwin/configs";
        home = "/path/to/home/configs";
      };
    };

    globalArgs = mkOption {
      type = types.attrs;
      description = "Global arguments to be passed to all configurations";
      example = {
        inputs = "flake inputs";
      };
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
          (resolveNixPath (lib.path.append cfg.base.darwin val.host))
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
              ];
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit user inputs;
                  inherit (inputs) self;
                };
                users.${user} = import (resolveNixPath (lib.path.append cfg.base.home val.user));
              };
            }
          )
        ];
      }
    );
  };
}
