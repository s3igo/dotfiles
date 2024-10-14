{
  makeNixvim,
  mkTestDerivationFromNvim,
  neovim-config,
}:

let
  neovimPackages = import ./packages/neovim.nix { inherit makeNixvim neovim-config; };
  toTestDerivation = name: {
    name = "neovim-${name}";
    value = mkTestDerivationFromNvim {
      inherit name;
      nvim = neovimPackages.${name};
    };
  };
  packageNames = builtins.attrNames neovimPackages;
in

builtins.listToAttrs (map toTestDerivation packageNames)
