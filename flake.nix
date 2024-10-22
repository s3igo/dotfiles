{
  description = "Personal dotfiles for reproducible environment setup using Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
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
    inputs@{
      self,
      nixpkgs,
      flake-utils,
      nixvim,
      nix-darwin,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        apps = import ./tasks.nix {
          inherit pkgs;
          inherit (flake-utils.lib) mkApp;
          nix-darwin' = nix-darwin.packages.${system}.default;
        };

        inherit (nixvim.legacyPackages.${system}) makeNixvim;
        neovim-config = (import ./neovim-config/flake.nix).outputs { };

        packages = import ./packages { inherit pkgs makeNixvim neovim-config; };
        checks = import ./checks.nix {
          inherit makeNixvim neovim-config;
          inherit (nixvim.lib.${system}.check) mkTestDerivationFromNvim;
        };
      in
      {
        inherit apps packages checks;

        devShells.default = pkgs.mkShellNoCC {
          packages = [
            pkgs.statix
            (neovim-config.lib.customName {
              inherit pkgs;
              nvim = packages.neovim;
            })
          ];
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    )
    // {
      darwinConfigurations = {
        mbp2023 =
          let
            user = "s3igo";
            system = "aarch64-darwin";
          in
          nix-darwin.lib.darwinSystem {
            specialArgs = {
              inherit inputs user system;
            };
            modules = [ ./modules/darwin/default.nix ];
          };
      };
    };
}
