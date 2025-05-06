_:

{ pkgs, lib, ... }:

{
  extraPlugins = lib.optional pkgs.stdenv.isDarwin (
    pkgs.callPackage ../../../packages/im-select-nvim.nix { }
  );

  extraPackages = lib.optional pkgs.stdenv.isDarwin (
    pkgs.callPackage ../../../packages/im-select-swift.nix { }
  );

  extraConfigLua = lib.optionalString pkgs.stdenv.isDarwin ''
    -- im-select
    require('im_select').setup({
      default_im_select = "net.mtgto.inputmethod.macSKK.ascii",
      default_command = "im-select-swift"
    })
  '';
}
