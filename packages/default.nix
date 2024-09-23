{
  pkgs,
  makeNixvim,
  neovim-config,
}:

let
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
  inherit (pkgs) skk-dict yaskkserv2 yaskkserv2-dict;
  chissoku = pkgs.callPackage ./chissoku.nix { };
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
