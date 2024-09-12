{
  outputs =
    _:
    let
      names = [
        "deno-script"
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
    {
      nixosModules = (import ./modules { inherit names; }) // {
        default = ./core;
      };
    };
}
