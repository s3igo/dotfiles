{
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
      home-manager,
      nix-homebrew,
      ...
    }:
    let
      overlays = import ./overlays.nix;
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system overlays; };
        apps = import ./tasks.nix {
          inherit pkgs;
          inherit (flake-utils.lib) mkApp;
          nix-darwin' = nix-darwin.packages.${system}.default;
        };
        packages = import ./packages {
          inherit pkgs;
          inherit (nixvim.legacyPackages.${system}) makeNixvim;
          neovim-config = (import ./neovim-config/flake.nix).outputs { };
        };
      in
      {
        inherit apps packages;

        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.statix
            self.packages.${system}.neovim
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
            specialArgs = inputs // {
              inherit user;
            };
          in
          nix-darwin.lib.darwinSystem {
            inherit specialArgs;
            modules = [
              home-manager.darwinModules.home-manager
              nix-homebrew.darwinModules.nix-homebrew
              ./modules/darwin/default.nix
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    inherit user;
                    neovim = self.packages.aarch64-darwin.default;
                  };
                  users.${user} = import ./home;
                };
              }
            ];
          };
      };
    };
}
