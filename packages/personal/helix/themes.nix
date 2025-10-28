let
  mkTransparentTheme = name: {
    inherits = name;
    "ui.background" = "none";
  };
  themes = [
    "jetbrains_dark"
    "catppuccin_mocha"
    "iceberg-dark"
  ];
  transparentThemes = builtins.listToAttrs (
    map (theme: {
      name = "${theme}_transparent";
      value = mkTransparentTheme theme;
    }) themes
  );
in

transparentThemes
// {
  iceberg-custom = transparentThemes.iceberg-dark_transparent // {
    "ui.gutter" = {
      fg = "linenr_fg";
      bg = "none";
    };
    "ui.linenr" = {
      bg = "none";
    };
    "ui.linenr.selected" = {
      fg = "linenr_fg";
      bg = "none";
    };
  };
  catppuccin-custom = transparentThemes.catppuccin_mocha_transparent // {
    "ui.linenr" = "overlay2";
  };
}
