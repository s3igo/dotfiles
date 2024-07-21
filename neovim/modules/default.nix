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
    "lua"
    "nix"
    "rust"
    "typescript"
    "json"
    "markdown"
    "prettier"
    "yaml"
    "ocaml"
  ];
in

builtins.listToAttrs (map toPathAttrs modules)
