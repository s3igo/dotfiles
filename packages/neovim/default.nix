_: {
  imports = [
    ./config
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
      TrailingSpace.link = "NightflyPurpleMode";
    };
  };
}
