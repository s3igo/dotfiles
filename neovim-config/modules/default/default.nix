{ lib, ... }:

let
  utils = {
    __functor = self: map (path: lib.modules.importApply path self);
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
  imports = utils [
    ./plugins
    ./keymaps
    ./autocmd.nix
    ./input-method.nix
    ./options.nix
  ];

  enableMan = false;
  highlight = {
    NormalFloat.bg = "none";
    StatusLine.bg = "none";
  };
}
