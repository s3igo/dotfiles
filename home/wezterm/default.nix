{
  pkgs,
  lib,
  user,
  ...
}:
{
  programs.wezterm.enable = true;
  xdg.configFile = {
    wezterm = {
      source = ./lua;
      recursive = true;
    };
    "wezterm/deps.lua".text =
      let
        chissoku = import ./chissoku.nix { inherit pkgs; };
      in
      ''
        return {
          chissoku = "${chissoku}/bin/chissoku",
          fish = "/etc/profiles/per-user/${user}/bin/fish",
        }
      '';
  };
  home.activation.installWeztermProfile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    declare TEMPFILE=$(mktemp)
    ${pkgs.curl}/bin/curl \
      --cacert /etc/ssl/certs/ca-certificates.crt \
      -o $TEMPFILE \
      -s https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo
    tic -x -o ~/.terminfo $TEMPFILE
    rm $TEMPFILE
  '';
}
