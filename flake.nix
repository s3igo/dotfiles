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
      nixvim,
      nix-darwin,
      home-manager,
      agenix,
      secrets,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        neovim-config = (import ./neovim-config/flake.nix).outputs { };
        pkgs = import nixpkgs { inherit system; };
        tasks = import ./tasks.nix { inherit system pkgs nix-darwin; };
        inherit (nixvim.legacyPackages.${system}) makeNixvim;
        packages = import ./packages.nix { inherit makeNixvim neovim-config; };
      in
      {
        packages = packages // {
          default = makeNixvim neovim-config.nixosModules.default;
          neovim = makeNixvim {
            imports = with neovim-config.nixosModules; [
              default
              nix
              lua
              markdown
            ];
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
