{
  pkgs,
  lib,
  config,
  ...
}:

let
  inherit (config.xdg) stateHome;
  inherit (config.home) homeDirectory;
in

{
  programs.fish = {
    enable = true;
    plugins =
      let
        use = name: {
          inherit name;
          inherit (pkgs.fishPlugins.${name}) src;
        };
      in
      [
        (use "autopair")
        (use "puffer")
        (use "sponge")
      ];
    functions = {
      # current date in ISO 8601 extended format
      __date = "echo (date '+%Y-%m-%d')";
      __ghq-fzf = ''
        set -l dest (ghq list --full-path \
          | fzf --preview "tree -C --gitignore -I 'node_modules|target|.git' {}" \
          | string escape)

        # is not selected
        if test -z $dest
          return
        end

        cd $dest
        commandline -f execute

        mkdir -p ${stateHome}/ghq
        echo $dest > ${stateHome}/ghq/lastdir
      '';
      gg = "__ghq-fzf";
    };
    shellAbbrs =
      let
        global = {
          position = "anywhere";
        };
        cursor = {
          setCursor = true;
        };
        function = name: { function = name; };
        text = str: { expansion = str; };
      in
      {
        ":cp" = global // text "| pbcopy";
        ":d" = global // function "__date";
        ":di" = global // text "(docker image ls | tail -n +2 | fzf | awk '{print $3}')";
        ":dp" = global // text "(docker ps | tail -n +2 | fzf | awk '{print $1}')";
        ":dpa" = global // text "(docker ps -a | tail -n +2 | fzf | awk '{print $1}')";
        ":f" = global // text "| fzf";
        ":g" = global // text "| rg";
        ":h" = global // text "--help";
        ":i" = global // text "install";
        ":icloud" = global // text "~/Library/Mobile\\ Documents/com~apple~CloudDocs";
        ":n" = global // text "nixpkgs";
        ":s" = global // text "search";
        ":v" = global // text "--version";
        arc = "open -a 'Arc.app'";
        b = "bun";
        c = "cd";
        ca = "cargo";
        cdg = "cd (cat ${stateHome}/ghq/lastdir | string escape)";
        cl = "clear";
        cp = "cp -iv";
        da = "direnv allow";
        db = "docker build";
        di = "docker image";
        do = "docker";
        dr = "docker run";
        ef = "exec fish";
        f = "fg";
        g = "git";
        ga = "git add";
        gb = "git branch";
        gc = "git commit";
        gd = "git diff";
        gl = "git log";
        gr = "git restore";
        gs = "git switch";
        hi = "history";
        mk = "mkdir";
        mv = "mv -iv";
        n = "nix";
        nb = cursor // text "nix build .#%";
        ne = cursor // text "nix eval .#%";
        nf = "nix flake";
        nl = "rm -rf .direnv; and direnv allow";
        nr = cursor // text "nix run .#% --";
        nrd = cursor // text "nix run $HOME/.dotfiles#% --";
        nrdr = cursor // text "nix run github:s3igo/dotfiles#% --";
        nrg = cursor // text "nix run github:% --";
        nrgm = cursor // text "nix run github:s3igo/% --";
        nrp = cursor // text "nix run nixpkgs#% --";
        nrv = "nix run .#neovim --";
        nrvd = "nix run $HOME/.dotfiles#neovim --";
        ns = cursor // text "nix shell nixpkgs#%";
        nv = "neovim";
        nvf = "neovim flake.nix";
        pst = "pbpaste";
        ql = cursor // text "qlmanage -p % &> /dev/null";
        rc = "rclone";
        rm = "rm -iv";
        st = "git status";
        ty = "typst";
        v = "nvim";
        vf = "nvim flake.nix";
        wh = "which";
        zj = "zellij";
      };
    loginShellInit = ''
      # PATH
      if test -d /opt/homebrew
        /opt/homebrew/bin/brew shellenv | source
      end
      if test -d ${homeDirectory}/.orbstack
        fish_add_path ${homeDirectory}/.orbstack/bin
      end
    '';
    interactiveShellInit = ''
      # disable greeting
      set fish_greeting

      # LS_COLORS
      set --export LS_COLORS "$(${lib.getExe pkgs.vivid} generate snazzy)"

      # # restricting abbrs
      # ## git
      # abbr add --command git s -- status

      # ## nix
      # abbr add --command nix --set-cursor b -- 'build .#% --'
      # abbr add --command nix f -- flake
      # abbr add --command nix --set-cursor r -- 'run .#% --'
      # abbr add --command nix --set-cursor rd -- 'run $HOME/.dotfiles#% --'
      # abbr add --command nix --set-cursor rdr -- 'run github:s3igo/dotfiles#% --'
      # abbr add --command nix --set-cursor rp -- 'run nixpkgs#% --'
      # abbr add --command nix v -- 'run .#neovim --'
      # abbr add --command nix vd -- 'run $HOME/.dotfiles#neovim --'
      # abbr add --command nix vdr -- 'run github:s3igo/dotfiles#neovim --'

      # keybindings
      ## disable exit with <C-d>
      bind \cd delete-char

      ## insert space without expanding abbrs with <A-space>
      bind \e\x20 'commandline -i " "'

      ## bigword
      bind \el forward-bigword
      bind \eh backward-bigword
      bind \ew backward-kill-bigword

      ## autosuggestions
      bind \cl accept-autosuggestion
      bind \cf forward-single-char

      ## history
      bind \ep history-token-search-backward
      bind \en history-token-search-forward
      ### <C-h> FIXME: `history-pager-delete` doesn't work
      bind \b history-pager-delete or backward-delete-char

      ## pager
      bind \co __fish_paginate

      ## functions
      # bind \cg __ghq-fzf
    '';
  };
}
