{ inputs, ... }:

{
  perSystem =
    {
      lib,
      self',
      system,
      ...
    }:

    let
      packageNames = builtins.filter (lib.strings.hasPrefix "neovim") (builtins.attrNames self'.packages);
      toTestDerivation = name: {
        inherit name;
        value = inputs.nixvim.lib.${system}.check.mkTestDerivationFromNvim {
          inherit name;
          nvim = self'.packages.${name};
        };
      };
    in

    {
      checks = builtins.listToAttrs (map toTestDerivation packageNames);
    };
}
