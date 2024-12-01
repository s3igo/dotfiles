{
  perSystem =
    {
      lib,
      inputs',
      neovim-config,
      ...
    }:

    let
      inherit (inputs'.nixvim.legacyPackages) makeNixvim;
      inherit (neovim-config) nixosModules;
      neovimPackages =
        let
          moduleToPackage = name: {
            name = "neovim-${name}";
            value = makeNixvim {
              imports = [
                nixosModules.default
                nixosModules.${name}
              ];
            };
          };
        in
        lib.mapAttrs' (name: _: moduleToPackage name) (builtins.removeAttrs nixosModules [ "default" ]);
      neovimExtraPackages =
        let
          moduleToPackageWithExtra = name: {
            name = "neovim-extra-${name}";
            value = makeNixvim {
              imports = [
                nixosModules.default
                nixosModules.extra
                nixosModules.${name}
              ];
            };
          };
        in
        lib.mapAttrs' (name: _: moduleToPackageWithExtra name) (
          builtins.removeAttrs nixosModules [
            "default"
            "extra"
          ]
        );
    in

    {
      packages =
        neovimPackages
        // neovimExtraPackages
        // {
          neovim-default = makeNixvim { imports = [ nixosModules.default ]; };
          neovim-full = makeNixvim {
            imports = builtins.attrValues (builtins.removeAttrs nixosModules [ "extra" ]);
          };
          neovim-extra-full = makeNixvim { imports = builtins.attrValues nixosModules; };
          neovim = makeNixvim {
            imports = with nixosModules; [
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
