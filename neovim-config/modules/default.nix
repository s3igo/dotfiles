let
  files = with builtins; filter (name: name != "default.nix") (attrNames (readDir ./.));
  toPathAttrs = file: {
    name = builtins.replaceStrings [ ".nix" ] [ "" ] file;
    value = ./${file};
  };
in

builtins.listToAttrs (map toPathAttrs files) // { full.imports = map (file: ./${file}) files; }
