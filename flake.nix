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

  outputs =
    {
      nixpkgs,
      flake-utils,
      nix-darwin,
      home-manager,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        tasks =
          let
            deploy = pkgs.writeShellApplication {
              name = "task_deploy";
              runtimeInputs = [ nix-darwin.packages.${system}.default ];
              text = ''
                sudo -v && darwin-rebuild switch --flake ".#$(scutil --get LocalHostName)"
              '';
            };
            update = pkgs.writeShellApplication {
              name = "task_update";
              runtimeInputs = [ deploy ];
              text = ''
                nix flake update && task_deploy
              '';
            };
          in
          [
            deploy
            update
          ];
      in
      {
        packages.default = import ./packages/zsh { inherit pkgs; };

        devShells.default = pkgs.mkShell {
          buildInputs =
            with pkgs;
            [
              act
              statix
            ]
            ++ tasks;
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    )
    // {
      darwinConfigurations = {
        mbp2023 =
          let
            user = "s3igo";
          in
          nix-darwin.lib.darwinSystem {
            modules = [
              (
                { pkgs, ... }:
                {
                  users.users.${user}.home = "/Users/${user}";
                }
              )
              ./modules/system.nix
              ./modules/apps.nix
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    inherit user;
                  };
                  users.${user} = import ./home;
                };
              }
            ];
          };
      };
    };
}
