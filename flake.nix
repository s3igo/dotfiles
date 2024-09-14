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
    {
      self,
      nixpkgs,
      flake-utils,
      nixvim,
      nix-darwin,
      home-manager,
      nix-homebrew,
      agenix,
      homebrew-core,
      homebrew-cask,
      homebrew-bundle,
      macos-fuse-t-cask,
      secrets,
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
                { users.users.${user}.home = "/Users/${user}"; }
                ./modules/secrets.nix
                ./modules/system.nix
                ./modules/apps.nix
                (
                  { pkgs, ... }:
                  {
                    nixpkgs.overlays = overlays;
                    launchd.user.agents.yaskkserv2 = {
                      path = [ pkgs.yaskkserv2 ];
                      command = "yaskkserv2 --no-daemonize --midashi-utf8 -- ${pkgs.yaskkserv2-dict}/share/dictionary.yaskkserv2";
                      serviceConfig = {
                        KeepAlive = true;
                        RunAtLoad = true;
                        StandardOutPath = "/Users/${user}/.local/state/yaskkserv2/out.log";
                        StandardErrorPath = "/Users/${user}/.local/state/yaskkserv2/err.log";
                      };
                    };
                  }
                )
                home-manager.darwinModules.home-manager
                nix-homebrew.darwinModules.nix-homebrew
                {
                  nix-homebrew = {
                    enable = true;
                    enableRosetta = true;
                    inherit user;
                    taps = {
                      "homebrew/homebrew-core" = homebrew-core;
                      "homebrew/homebrew-cask" = homebrew-cask;
                      "homebrew/homebrew-bundle" = homebrew-bundle;
                      "macos-fuse-t/homebrew-cask" = macos-fuse-t-cask;
                    };
                    mutableTaps = false;
                  };
                }
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
