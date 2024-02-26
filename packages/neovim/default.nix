_: {
  imports = [
    ./plugins
    ./config/keymaps
    ./modules/nix.nix
  ];

  config = {
    filetype.extension.typ = "typst";

    highlight = {
      NormalFloat.bg = "none";
      NonText.link = "NightflyPickleBlue";
      Whitespace.link = "NightflyPickleBlue";
      SpecialKey.link = "NightflyPickleBlue";
      Indent.link = "NightflyGreyBlue";
    };

    options = import ./options.nix;
    autoCmd = import ./autocmd.nix;
  };
}
