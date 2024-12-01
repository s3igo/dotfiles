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
      # Exclude packages containing 'extra' in their names from testing as they
      # have machine-specific configurations
      isValidName =
        name: lib.hasPrefix "neovim" name && !lib.hasPrefix "neovim-extra" name && name != "neovim";
      toTestDerivation = name: {
        name = "${name}-check";
        value = inputs.nixvim.lib.${system}.check.mkTestDerivationFromNvim {
          inherit name;
          nvim = self'.packages.${name};
        };
      };
    in

    {
      checks = lib.mapAttrs' (name: _: toTestDerivation name) (
        lib.filterAttrs (name: _: isValidName name) self'.packages
      );
    };
}
