_: {
  imports = [ ./plugins ];

  config = {
    filetype.extension.typ = "typst";

    globals = {
      mapleader = " ";
    };

    highlight = {
      NormalFloat.bg = "none";
    };

    options = import ./options.nix;
    autoCmd = import ./autocmd.nix;
    keymaps = import ./keymaps.nix;
  };
}
