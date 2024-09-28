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

neovimPackages
// {
  skk-dict = pkgs.callPackage ./skk-dict.nix { };
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
