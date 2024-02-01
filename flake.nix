{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    nix-darwin,
    home-manager,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        tasks = let
          deploy = pkgs.writeShellApplication {
            name = "deploy";
            runtimeInputs = [nix-darwin.packages.${system}.default];
            text = ''
              darwin-rebuild switch --flake ".#$(scutil --get LocalHostName)"
            '';
          };
          update = pkgs.writeShellApplication {
            name = "update";
            runtimeInputs = [deploy];
            text = ''
              nix flake update && deploy
            '';
          };
        in [deploy update];
      in {
        packages.default = import ./packages/zsh {inherit pkgs;};

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [act statix] ++ tasks;
        };

        formatter = pkgs.alejandra;
      }
    )
    // {
      darwinConfigurations = {
        mbp2023 = let
          user = "s3igo";
        in
          nix-darwin.lib.darwinSystem {
            modules = [
              ({pkgs, ...}: {
                users.users.${user}.home = "/Users/${user}";
              })
              ./modules/system.nix
              ./modules/apps.nix
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${user} = import ./home;
                };
              }
            ];
          };
      };
    };
}
