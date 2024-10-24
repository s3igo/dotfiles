{
  description = "Personal dotfiles for reproducible environment setup using Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-root.url = "github:srid/flake-root";
    mission-control.url = "github:Platonic-Systems/mission-control?ref=pull/38/head";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew-core = {
      url = "github:Homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:Homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:Homebrew/homebrew-bundle";
      flake = false;
    };
    macos-fuse-t-cask = {
      url = "github:macos-fuse-t/homebrew-cask";
      flake = false;
    };
    secrets = {
      url = "github:s3igo/secrets";
      flake = false;
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }:
      {
        imports = map (path: ./modules/flake/${path}) (with builtins; attrNames (readDir ./modules/flake));

        systems = import inputs.systems;

        perSystem =
          {
            pkgs,
            lib,
            config,
            neovim-config,
            ...
          }:
          {
            _module.args.neovim-config = (import ./neovim-config/flake.nix).outputs { };
            packages = lib.filesystem.packagesFromDirectoryRecursive {
              inherit (pkgs) callPackage;
              directory = ./packages;
            };
            devShells.default = pkgs.mkShellNoCC {
              inputsFrom = [ config.mission-control.devShell ];
              packages = [
                pkgs.statix
                (neovim-config.lib.customName {
                  inherit pkgs;
                  nvim = config.packages.neovim;
                })
              ];
            };
            formatter = pkgs.nixfmt-rfc-style;
          };

        flake = {
          darwinConfigurations = {
            mbp2023 =
              let
                user = "s3igo";
                system = "aarch64-darwin";
              in
              withSystem system (
                _:
                inputs.nix-darwin.lib.darwinSystem {
                  specialArgs = {
                    inherit
                      inputs
                      user
                      system
                      ;
                  };
                  modules = [
                    (
                      { pkgs, ... }:
                      {
                        users.users.${user} = {
                          name = user;
                          home = "/Users/${user}";
                          # shell = pkgs.zsh;
                        };
                      }
                    )
                    ./modules/darwin/default.nix
                  ];
                }
              );
          };
        };
      }
    );
}
