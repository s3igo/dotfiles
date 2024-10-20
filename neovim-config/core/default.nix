{ lib, ... }:

let
  withUtils = attrs: map (path: lib.modules.importApply path attrs);
  utils = {
    inherit withUtils;
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
  imports = withUtils utils [
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
