{
  system,
  nixvim,
}:

{
  pkgs,
  modules ? [ ],
  grammars ? [ ],
}:

nixvim.legacyPackages.${system}.makeNixvimWithModule {
  inherit pkgs;
  extraSpecialArgs = {
    inherit grammars;
  };
  module.imports = [ ./base ] ++ modules;
}
