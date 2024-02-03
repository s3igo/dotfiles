{
  pkgs,
  lib,
  user,
  ...
}: {
  xdg.configFile.wezterm = {
    source = ../../config/home/.config/wezterm;
    recursive = true;
  };
  xdg.configFile."wezterm/deps.lua".text = let
    chissoku = import ../cli/chissoku.nix {inherit pkgs;};
  in ''
    return {
      chissoku = "${chissoku}/bin/chissoku",
      fish = "/etc/profiles/per-user/${user}/bin/fish",
    }
  '';
  programs.wezterm.enable = true;
  home.activation.installWeztermProfile = lib.hm.dag.entryAfter ["writeBoundary"] ''
    declare TEMPFILE=$(mktemp)
    ${pkgs.curl}/bin/curl \
      --cacert /etc/ssl/certs/ca-certificates.crt \
      -o $TEMPFILE \
      -s https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo
    tic -x -o ~/.terminfo $TEMPFILE
    rm $TEMPFILE
  '';

  home.packages = with pkgs; [
    monitorcontrol
    udev-gothic-nf
  ];
}
