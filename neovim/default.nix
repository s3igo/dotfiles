{ nixvim }:

{
  system,
  pkgs,
  modules ? [ ],
  grammars ? [ ],
}:

nixvim.legacyPackages.${system}.makeNixvimWithModule {
  inherit pkgs;
  extraSpecialArgs = {
    inherit grammars;
  };
  module.imports = [ ./config ] ++ modules;
}
