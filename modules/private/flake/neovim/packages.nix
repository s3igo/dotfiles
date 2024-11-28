{
  perSystem =
    {
      inputs',
      neovim-config,
      ...
    }:

    let
      inherit (inputs'.nixvim.legacyPackages) makeNixvim;
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

    {
      packages = derivedPackages // {
        neovim-full = makeNixvim { imports = builtins.attrValues neovim-config.nixosModules; };
        neovim = makeNixvim {
          imports = with neovim-config.nixosModules; [
            default
            extra
            nix
            lua
            markdown
          ];
        };
      };
    };
}
