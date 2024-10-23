{
  makeNixvim,
  neovim-config,
}:

let
  toPackage = name: {
    name = "neovim-${name}";
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
  neovim-full = makeNixvim { imports = builtins.attrValues neovim-config.nixosModules; };
  neovim = makeNixvim {
    imports = with neovim-config.nixosModules; [
      default
      nix
      lua
      markdown
    ];
  };
}
