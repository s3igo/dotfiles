{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    get-flake.url = "github:ursi/get-flake";
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
      get-flake,
      nix-darwin,
      home-manager,
      agenix,
      secrets,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        tasks = import ./tasks.nix { inherit system pkgs nix-darwin; };
        neovim = get-flake (toString ./. + "/neovim");
      in
      {
        packages = with neovim; {
          default = withModules {
            inherit system pkgs;
            grammars = "all";
          };
          neovim = withModules {
            inherit pkgs system;
            modules = with modules; [
              im-select
              nix
              lua
              markdown
            ];
          };
          full = withModules {
            inherit system pkgs;
            modules = [ modules.full ];
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
