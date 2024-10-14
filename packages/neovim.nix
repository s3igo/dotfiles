{
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
  derivedPackages = builtins.listToAttrs (map toPackage moduleNames);
in

derivedPackages
// {
  neovim = makeNixvim {
    imports = with neovim-config.nixosModules; [
      default
      nix
      lua
      markdown
    ];
  };
}
