{ nixvim }:

{
  system,
  pkgs,
  modules ? [ ],
}:

nixvim.legacyPackages.${system}.makeNixvimWithModule {
  inherit pkgs;
  module.imports = [ ./config ] ++ modules;
}
