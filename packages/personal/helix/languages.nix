{
  lib,
  efm-langserver,
  nixfmt,
}:

{
  language-server = {
    # https://biomejs.dev/guides/editors/third-party-extensions/#helix
    biome = {
      command = "biome";
      args = [ "lsp-proxy" ];
    };
    # https://github.com/blopker/codebook#helix
    codebook = {
      command = "codebook-lsp";
      args = [ "serve" ];
    };
    # WIP: なんか動かない
    efm-nix = {
      command = lib.getExe efm-langserver;
      # args = [
      #   "-logfile"
      #   "/Users/s3igo/.dotfiles/efm.local.log"
      # ];
      # config = {
      #   efm-langserver.languages.nix = [
      #     {
      #       lintCommand = "${lib.getExe statix} check --stdin --format errfmt";
      #       # lintCommand = "${lib.getExe statix} check --format errfmt";
      #       # lintWorkspace = true;
      #       lintIgnoreExitCode = true;
      #       # lintStdin = false;
      #       # rootMarkers = [ "flake.nix" ];
      #       # https://vimhelp.org/quickfix.txt.html#errorformat
      #       # https://github.com/oppiliappan/statix/blob/v0.5.8/vim-plugin/ftplugin/nix.vim#L2
      #       lintFormats = [ "%f>%l:%c:%t:%n:%m" ];
      #     }
      #   ];
      # };
    };
    stylua = {
      command = "stylua";
      args = [ "--lsp" ];
    };
    tailwindcss-ls.config.tailwindCSS.classAttributes =
      let
        default = [
          "class"
          "className"
          "ngClass"
          "class:list"
        ];
      in
      default ++ [ ".*Classes" ];
    taplo.config.formatter = {
      alignComments = false;
      arrayAutoExpand = false;
      arrayAutoCollapse = false;
    };
    # https://github.com/tekumara/typos-lsp/blob/main/docs/helix-config.md
    typos.command = "typos-lsp";
  };
  language = [
    {
      name = "astro";
      language-servers = [
        "astro-ls"
        "typos"
      ];
    }
    {
      name = "json";
      language-servers = [
        "vscode-json-language-server"
        "typos"
      ];
      # なぜかvscode-json-language-serverのformat機能はtrailing newlineを消してしまう
      # .editorconfigで`insert_final_newline = true`にしていても消える
      auto-format = false;
    }
    {
      name = "jsonc";
      language-servers = [
        "vscode-json-language-server"
        "typos"
      ];
      # なぜかvscode-json-language-serverのformat機能はtrailing newlineを消してしまう
      # .editorconfigで`insert_final_newline = true`にしていても消える
      auto-format = false;
    }
    {
      name = "lua";
      language-servers = [
        {
          name = "lua-language-server";
          except-features = [ "format" ];
        }
        "stylua"
        "codebook"
        "typos"
      ];
      auto-format = true;
    }
    {
      name = "markdown";
      language-servers = [ "typos" ];
    }
    {
      name = "nix";
      language-servers = [
        "efm-nix"
        # {
        #   name = "efm-nix";
        #   only-features = [ "diagnostics" ];
        # }
        "nil"
        "nixd"
        "typos"
      ];
      formatter.command = lib.getExe nixfmt;
      auto-format = true;
    }
    {
      name = "rust";
      language-servers = [
        "rust-analyzer"
        "codebook"
        "typos"
      ];
    }
    {
      name = "toml";
      language-servers = [
        "taplo"
        "codebook"
        "typos"
      ];
      auto-format = true;
    }
    {
      name = "yaml";
      language-servers = [
        "yaml-language-server"
        "typos"
      ];
    }
  ];
}
