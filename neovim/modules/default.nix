{ nixvim }:

let
  inherit (nixvim.inputs.nixpkgs.lib.path) append;
  toPathAttrs = name: {
    inherit name;
    value = append ./. "./${name}.nix";
  };
  modules = [
    "deno-script"
    "full"
    "json"
    "lua"
    "markdown"
    "nix"
    "ocaml"
    "prettier"
    "rust"
    "toml"
    "typescript"
    "yaml"
  ];
in

builtins.listToAttrs (map toPathAttrs modules)
