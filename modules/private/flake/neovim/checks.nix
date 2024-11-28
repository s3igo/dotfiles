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
      isValidName =
        name: lib.hasPrefix "neovim" name && !lib.hasPrefix "neovim-extra" name && name != "neovim";
      packageNames = builtins.filter isValidName (builtins.attrNames self'.packages);
      toTestDerivation = name: {
        name = "check-${name}";
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
