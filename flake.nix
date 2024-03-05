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
    direnv = {
      url = "github:direnv/direnv";
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
      nix-darwin,
      home-manager,
      agenix,
      nixvim,
      direnv,
      secrets,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        tasks =
          with pkgs;
          let
            deploy = writeShellApplication {
              name = "task_deploy";
              runtimeInputs = [ nix-darwin.packages.${system}.default ];
              text = ''
                sudo -v && darwin-rebuild switch --flake ".#$(scutil --get LocalHostName)"
              '';
            };
            update = writeShellApplication {
              name = "task_update";
              runtimeInputs = [ deploy ];
              text = ''
                nix flake update --commit-lock-file && task_deploy
              '';
            };
            gc = writeShellScriptBin "task_gc" ''
              # sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
              nix store gc
            '';
            versions = writeShellApplication {
              name = "task_versions";
              runtimeInputs = [ gawk ];
              text = ''
                nix profile diff-closures --profile /nix/var/nix/profiles/system \
                  | awk 'BEGIN { RS="" } { par=$0 } END { print par }'
              '';
            };
          in
          [
            deploy
            update
            gc
            versions
          ];
        neovim =
          let
            pkgs' = pkgs;
          in
          {
            pkgs ? pkgs',
            modules ? [ ],
            grammars ? [ ],
          }:
          nixvim.legacyPackages.${system}.makeNixvimWithModule {
            inherit pkgs;
            extraSpecialArgs = {
              inherit grammars;
            };
            module.imports = [ ./packages/neovim ] ++ modules;
          };
      in
      {
        packages = {
          neovim = neovim {
            modules = with self.nixosModules; [
              im-select
              nix
              lua
            ];
            grammars = "all";
          };
          default = neovim {
            modules = with self.nixosModules; [ im-select ];
            grammars = "all";
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs =
            with pkgs;
            [
              act
              statix
            ]
            ++ tasks;
        };

        lib = {
          inherit neovim;
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
                      inherit user direnv;
                    };
                    users.${user} = import ./home;
                  };
                }
              ];
            };
        };

      nixosModules = {
        treesitterAll.imports = [ ./packages/neovim/modules/treesitter-all.nix ];
        im-select.imports = [ ./packages/neovim/modules/im-select.nix ];
        nix.imports = [ ./packages/neovim/modules/nix.nix ];
        lua.imports = [ ./packages/neovim/modules/lua.nix ];
        typescript.imports = [ ./packages/neovim/modules/typescript.nix ];
      };
    };
}
