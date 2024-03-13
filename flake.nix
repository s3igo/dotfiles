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
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix-darwin.follows = "nix-darwin";
        home-manager.follows = "home-manager";
      };
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
      nix-darwin,
      home-manager,
      agenix,
      nixvim,
      secrets,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        tasks = import ./tasks.nix { inherit system pkgs nix-darwin; };
        neovim = import ./neovim { inherit system pkgs nixvim; };
      in
      {
        inherit neovim;

        packages = {
          default = neovim { grammars = "all"; };
          neovim = neovim {
            modules = with self.nixosModules; [
              im-select
              nix
              lua
            ];
          };
          full = neovim {
            modules = [ self.nixosModules.full ];
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

      nixosModules = {
        full = ./neovim/modules/full.nix;
        im-select = ./neovim/modules/im-select.nix;
        lua = ./neovim/modules/lua.nix;
        nix = ./neovim/modules/nix.nix;
        rust = ./neovim/modules/rust.nix;
        typescript = ./neovim/modules/typescript.nix;
        json = ./neovim/modules/json.nix;
        markdown = ./neovim/modules/markdown.nix;
        prettier = ./neovim/modules/prettier.nix;
        yaml = ./neovim/modules/yaml.nix;
      };
    };
}
