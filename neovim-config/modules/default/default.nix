{ lib, ... }:

let
  utils = {
    __functor = lib.flip lib.modules.importApply;
    mapMode =
      mode:
      {
        key,
        action,
        options ? { },
      }:
      {
        inherit
          mode
          key
          action
          options
          ;
      };
  };
in

{
  imports = map utils [
    ./plugins
    ./keymaps
    ./autocmd.nix
    # ./input-method.nix
    ./options.nix
  ];

  enableMan = false;
  performance.byteCompileLua = {
    enable = true;
    plugins = true;
  };
  highlight = {
    NormalFloat.bg = "none";
    StatusLine.bg = "none";
  };
}
