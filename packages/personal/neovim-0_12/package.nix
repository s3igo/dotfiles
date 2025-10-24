{
  lib,
  runCommandNoCC,
  makeBinaryWrapper,
  neovim-nightly-overlay,
  system,

  lua-language-server,
  stylua,
}:

runCommandNoCC "neovim-0_12"
  {
    nativeBuildInputs = [ makeBinaryWrapper ];
    meta.mainProgram = "nvim12";
  }
  ''
    mkdir -p $out/bin
    makeBinaryWrapper ${lib.getExe neovim-nightly-overlay.packages.${system}.default} $out/bin/nvim12 \
      --inherit-argv0 \
      --set NVIM_APPNAME nvim-0.12 \
      --suffix PATH : ${
        lib.makeBinPath [
          lua-language-server
          stylua
        ]
      }
  ''
