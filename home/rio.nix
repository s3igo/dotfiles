{ pkgs, ... }:

{
  programs.rio = {
    enable = true;
    settings = {
      theme = "iceberg-dark";
      padding-x = 10;
      fonts.family = "UDEV Gothic NFLG";
      navigation.mode = "Plain";
      shell = {
        program = "/etc/profiles/per-user/s3igo/bin/zellij";
        args = [
          "attach"
          "--create"
          "primary"
        ];
      };
      window.opacity = 0.7;
    };
  };

  # https://raphamorim.io/rio/docs/config/theme
  xdg.configFile."rio/themes".source =
    (pkgs.callPackage ../packages/rio-themes.nix { }) + "/share/themes";
}
