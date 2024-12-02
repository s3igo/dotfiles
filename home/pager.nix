{ pkgs, lib, ... }:

let
  deltaCommand = lib.getExe pkgs.delta;
  ovCommand = lib.getExe pkgs.ov;
in

{
  programs = {
    git.extraConfig = {
      # NOTE: `--quit-if-one-screen` sometimes doesn't work correctly
      # The conditions that trigger this issue are unclear
      # Ref: https://github.com/dandavison/delta/issues/1684
      core.pager = "${deltaCommand} --pager '${ovCommand} --quit-if-one-screen'";
      pager = {
        diff = "${deltaCommand} --features ov-diff";
        log = "${deltaCommand} --features ov-log";
      };
      delta = {
        navigate = true;
        side-by-side = true;
        ov-diff.pager = builtins.concatStringsSep " " [
          ovCommand
          "--quit-if-one-screen"
          "--section-delimiter '^(commit|added:|removed:|renamed:|Δ)'"
          "--section-header"
          "--pattern '•'"
        ];
        ov-log.pager = builtins.concatStringsSep " " [
          ovCommand
          "--quit-if-one-screen"
          "--section-delimiter '^commit'"
          "--section-header-num 3"
        ];
      };
    };
    # Override the builtin `__fish_anypager` function to customize the behavior
    # of `__fish_paginate`
    fish.functions.__fish_anypager = ''
      echo ${pkgs.ov.meta.mainProgram}
    '';
  };

  home = {
    sessionVariables = {
      PAGER = ovCommand;
      MANPAGER = "${ovCommand} --section-delimiter '^[^\\s]' --section-header";
      BAT_PAGER = "${ovCommand} --quit-if-one-screen --header 3";
    };
    packages = with pkgs; [
      delta
      ov
    ];
  };

  # TODO: Configure ov keybindings
}
