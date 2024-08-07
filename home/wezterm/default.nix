{
  pkgs,
  lib,
  user,
  ...
}:
{
  programs.wezterm = {
    enable = true;
    extraConfig =
      let
        chissoku = import ./chissoku.nix { inherit pkgs; };
      in
      ''
        ---@type { default: table, scheme: table }
        local colors = require('colors')

        require('events')(colors.default, '${chissoku}/bin/chissoku')
        return require('config')(
          colors.scheme,
          require('wezterm').font('UDEV Gothic NFLG'),
          require('mappings'),
          '/etc/profiles/per-user/${user}/bin/fish'
        )
      '';
  };

  xdg.configFile.wezterm = {
    source = ./lua;
    recursive = true;
  };

  home.activation.installWeztermProfile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -fnsT ${pkgs.wezterm.passthru.terminfo}/share/terminfo ~/.terminfo
  '';
}
