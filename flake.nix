{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nix-darwin, home-manager, ... }: {
    darwinConfigurations = {
      mbp2023 = nix-darwin.lib.darwinSystem {
        # system = "aarch64-darwin";
        modules = [
          ./modules/system.nix
          ./modules/apps.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.s3igo = import ./home;
          }
        ];
      };
    };

    # Expose the package set, including overlays, for convenience.
    # darwinPackages = self.darwinConfigurations."mbp2023".pkgs;

    # formatter
    # formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
  };
}

