{
  description = "Personal dotfiles for reproducible environment setup using Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
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
        systems = import inputs.systems;

        perSystem =
          {
            pkgs,
            inputs',
            self',
            ...
          }:
          let
            inherit (inputs'.nixvim.legacyPackages) makeNixvim;
            neovim-config = (import ./neovim-config/flake.nix).outputs { };
          in
          {
            apps = import ./tasks.nix {
              inherit pkgs;
              nix-darwin' = inputs'.nix-darwin.packages.default;
            };
            packages = import ./packages { inherit pkgs makeNixvim neovim-config; };
            checks = import ./checks.nix {
              inherit makeNixvim neovim-config;
              inherit (inputs'.nixvim.lib.check) mkTestDerivationFromNvim;
            };
            devShells.default = pkgs.mkShellNoCC {
              packages = [
                pkgs.statix
                (neovim-config.lib.customName {
                  inherit pkgs;
                  nvim = self'.packages.neovim;
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
