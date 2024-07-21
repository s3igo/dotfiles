{ nixvim }:

let
  inherit (nixvim.inputs.nixpkgs.lib.path) append;
  toPathAttrs = name: {
    inherit name;
    value = append ./. "./${name}.nix";
  };
  modules = [
    "full"
    "im-select"
    "json"
    "lua"
    "markdown"
    "nix"
    "ocaml"
    "prettier"
    "rust"
    "typescript"
    "yaml"
  ];
in

builtins.listToAttrs (map toPathAttrs modules)
