{
  pkgs,
  makeNixvim,
  neovim-config,
}:

let
  skk-dict = pkgs.callPackage ./skk-dict.nix { };
  yaskkserv2 = pkgs.callPackage ./yaskkserv2.nix { };
  yaskkserv2-dict = pkgs.callPackage ./yaskkserv2-dict.nix { inherit skk-dict yaskkserv2; };

  toPackage = name: {
    inherit name;
    value = makeNixvim {
      imports = with neovim-config; [
        nixosModules.default
        nixosModules.${name}
      ];
    };
  };
  moduleNames = builtins.attrNames neovim-config.nixosModules;
  neovimPackages = builtins.listToAttrs (map toPackage moduleNames);
in

{
  inherit skk-dict yaskkserv2 yaskkserv2-dict;
  neovim = makeNixvim {
    imports = with neovim-config.nixosModules; [
      default
      nix
      lua
      markdown
    ];
  };
}
// neovimPackages
