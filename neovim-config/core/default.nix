{
  imports = [
    ./plugins
    ./keymaps
    ./autocmd.nix
    ./input-method.nix
    ./options.nix
  ];

  enableMan = false;
  highlight = {
    NormalFloat.bg = "none";
    StatusLine.bg = "none";
  };
}
