{ pkgs, lib, ... }:

let
  deltaCommand = lib.getExe pkgs.delta;
  ovCommand = lib.getExe pkgs.ov;
in

{
  programs = {
    # https://noborus.github.io/ov/delta/index.html
    # Manually configuring instead of using `programs.git.delta` to integrate
    # delta and ov.
    git.extraConfig = {
      core.pager = "${deltaCommand} --pager '${ovCommand} --quit-if-one-screen'";
      interactive.diffFilter = "${deltaCommand} --color-only";
      pager = {
        show = "${deltaCommand} --pager '${ovCommand} --quit-if-one-screen --header 3'";
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
    fish.functions.__fish_anypager = "echo ${pkgs.ov.meta.mainProgram}";
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
