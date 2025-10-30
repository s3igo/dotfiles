{
  lib,
  stdenv,
  runCommand,
  makeBinaryWrapper,
  neovim-nightly-overlay,
  system,

  # https://github.com/nvim-treesitter/nvim-treesitter/tree/main#requirements
  gnutar,
  curl,
  tree-sitter,
  nodejs-slim_24,

  lua-language-server,
  stylua,
}:

runCommand "neovim-0_12"
  {
    nativeBuildInputs = [ makeBinaryWrapper ];
    meta.mainProgram = "nvim12";
  }
  ''
    mkdir -p $out/bin
    makeBinaryWrapper ${lib.getExe neovim-nightly-overlay.packages.${system}.default} $out/bin/nvim12 \
      --inherit-argv0 \
      --set NVIM_APPNAME nvim-0.12 \
      --prefix PATH : ${
        lib.makeBinPath [
          gnutar
          curl
          tree-sitter
          stdenv.cc
          nodejs-slim_24
        ]
      } \
      --suffix PATH : ${
        lib.makeBinPath [
          lua-language-server
          stylua
        ]
      }
  ''
