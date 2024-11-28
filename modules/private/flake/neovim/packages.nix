{
  perSystem =
    {
      inputs',
      neovim-config,
      ...
    }:

    let
      inherit (inputs'.nixvim.legacyPackages) makeNixvim;
      inherit (neovim-config) nixosModules;
      inherit (builtins) attrNames attrValues removeAttrs;
      neovimPackages =
        let
          toPackage = name: {
            name = "neovim-${name}";
            value = makeNixvim {
              imports = [
                nixosModules.default
                nixosModules.${name}
              ];
            };
          };
          moduleNames = attrNames (removeAttrs nixosModules [ "default" ]);
        in
        builtins.listToAttrs (map toPackage moduleNames);
      neovimExtraPackages =
        let
          toPackageWithExtra = name: {
            name = "neovim-extra-${name}";
            value = makeNixvim {
              imports = [
                nixosModules.default
                nixosModules.extra
                nixosModules.${name}
              ];
            };
          };
          moduleNames = attrNames (
            removeAttrs nixosModules [
              "default"
              "extra"
            ]
          );
        in
        builtins.listToAttrs (map toPackageWithExtra moduleNames);
    in

    {
      packages =
        neovimPackages
        // neovimExtraPackages
        // {
          neovim-default = makeNixvim { imports = [ nixosModules.default ]; };
          neovim-full = makeNixvim {
            imports = attrValues (removeAttrs nixosModules [ "extra" ]);
          };
          neovim-extra-full = makeNixvim { imports = attrValues nixosModules; };
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
