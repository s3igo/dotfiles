{ names }:

let
  toPathAttrs = name: {
    inherit name;
    value = ./. + "/${name}.nix";
  };
in

builtins.listToAttrs (map toPathAttrs names)
