{
  pkgs,
  lib,
  user,
  ...
}:

let
  chissoku = pkgs.callPackage ../../packages/chissoku.nix { };
in

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local zellij = true

      if zellij then
        return require('config').zellij(
         '/etc/profiles/per-user/${user}/bin/fish',
         '${lib.getExe chissoku}'
        )
      else
        ---@type { default: table, scheme: table }
        local colors = require('colors')

        require('events')(colors.default, '${lib.getExe chissoku}')

        return require('config').default(
          colors.scheme,
          require('wezterm').font('UDEV Gothic NFLG'),
          require('mappings'),
          '/etc/profiles/per-user/${user}/bin/fish'
        )
      end
    '';
  };

  xdg.configFile.wezterm = {
    source = ./lua;
    recursive = true;
  };

  home.activation.installWeztermProfile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -fns ${pkgs.wezterm.passthru.terminfo}/share/terminfo ~/.terminfo
  '';
}
