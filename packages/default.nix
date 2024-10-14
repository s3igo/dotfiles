{
  pkgs,
  makeNixvim,
  neovim-config,
}:

let
  neovimPackages = import ./neovim.nix { inherit makeNixvim neovim-config; };
in

neovimPackages
// {
  skk-dict = pkgs.callPackage ./skk-dict.nix { };
  chissoku = pkgs.callPackage ./chissoku.nix { };
}
