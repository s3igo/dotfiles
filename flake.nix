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
                      command = "yaskkserv2 --no-daemonize --midashi-utf8 --google-suggest -- ${pkgs.yaskkserv2-dict}/share/dictionary.yaskkserv2";
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
