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

  biome,
  codebook,
  copilot-language-server,
  lua-language-server,
  nil,
  nixd,
  nixfmt,
  selene,
  statix,
  stylua,
  taplo,
  typescript-language-server,
  typos-lsp,
  vscode-langservers-extracted,
  yaml-language-server,
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
      --suffix PATH : ${
        lib.makeBinPath [
          # Tree-sitter
          gnutar
          curl
          tree-sitter
          stdenv.cc

          biome
          codebook
          copilot-language-server
          lua-language-server
          nil
          nixd
          nixfmt
          selene
          statix
          stylua
          taplo
          typescript-language-server
          typos-lsp
          vscode-langservers-extracted
          yaml-language-server
        ]
      }
  ''
