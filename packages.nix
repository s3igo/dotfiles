{
  system,
  pkgs,
  neovim,
}:

let
  toPackage = name: {
    inherit name;
    value = neovim.withModules {
      inherit system pkgs;
      modules = [ neovim.modules.${name} ];
      grammars = if name == "full" then "all" else [ ];
    };
  };
  moduleNames = builtins.attrNames neovim.modules;
in

builtins.listToAttrs (map toPackage moduleNames)
