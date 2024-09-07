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
in

builtins.listToAttrs (map toPackage moduleNames)
