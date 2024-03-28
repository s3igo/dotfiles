{ nixvim }:

{
  pkgs,
  system,
  modules ? [ ],
  grammars ? [ ],
}:

nixvim.legacyPackages.${system}.makeNixvimWithModule {
  inherit pkgs;
  extraSpecialArgs = {
    grammars = if grammars == "all" then "all" else grammars ++ [ "vimdoc" ];
  };
  module.imports = [ ./config ] ++ modules;
}
