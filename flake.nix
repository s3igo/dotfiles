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
    agenix = {
      url = "github:yaxitech/ragenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
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
      nixpkgs,
      flake-utils,
      nix-darwin,
      home-manager,
      agenix,
      direnv,
      secrets,
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
                nix flake update --commit-lock-file && task_deploy
              '';
            };
            gc = pkgs.writeShellScriptBin "task_gc" ''
              nix store gc --max 5G
            '';
          in
          [
            deploy
            update
            gc
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
    };
}
