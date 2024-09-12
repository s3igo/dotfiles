{ names }:

let
  nameToPath = name: ./. + "/${name}.nix";
  toPathAttrs = name: {
    inherit name;
    value = nameToPath name;
  };
in

builtins.listToAttrs (map toPathAttrs names) // { full.imports = map nameToPath names; }
