{
  pkgs,
  makeNixvim,
  neovim-config,
}:

let
  neovim = import ./neovim.nix { inherit makeNixvim neovim-config; };
  skk-dict = pkgs.callPackage ./skk-dict.nix { };
  yaskkserv2 = pkgs.callPackage ./yaskkserv2.nix { };
  yaskkserv2-dict = pkgs.callPackage ./yaskkserv2-dict.nix { inherit skk-dict yaskkserv2; };
in

neovim
// {
  inherit skk-dict yaskkserv2 yaskkserv2-dict;
}
