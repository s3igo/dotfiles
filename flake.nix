{
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
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim.url = "./neovim";
    secrets = {
      url = "github:s3igo/secrets";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      nix-darwin,
      home-manager,
      agenix,
      neovim,
      secrets,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        tasks = import ./tasks.nix { inherit system pkgs nix-darwin; };
        neovim' = neovim.withModules.${system};
      in
      {
        packages = {
          default = neovim' {
            inherit pkgs;
            grammars = "all";
          };
          neovim = neovim' {
            inherit pkgs;
            modules = with neovim.nixosModules; [
              im-select
              nix
              lua
            ];
          };
          full = neovim' {
            inherit pkgs;
            modules = [ neovim.nixosModules.full ];
            grammars = "all";
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.statix
            self.packages.${system}.neovim
          ] ++ tasks;
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    )
    // {
      darwinConfigurations =
        let
          configPath = username: "/Users/${username}/.config";
        in
        {
          mbp2023 =
            let
              user = "s3igo";
            in
            nix-darwin.lib.darwinSystem {
              specialArgs = {
                inherit agenix secrets user;
                configHome = configPath user;
              };
              modules = [
                (
                  { pkgs, ... }:
                  {
                    users.users.${user}.home = "/Users/${user}";
                  }
                )
                ./modules/secrets.nix
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
