{
  system,
  pkgs,
  nixvim,
}:

let
  pkgs' = pkgs;
in
{
  pkgs ? pkgs',
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
