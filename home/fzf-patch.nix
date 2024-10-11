args@{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}:

let
  inherit (lib) optional concatStringsSep getExe;
  cfg = config.programs.fzf;

  variablesToDisableKeyBindings =
    let
      ctrl-t = optional (cfg.fileWidgetCommand == "") "FZF_CTRL_T_COMMAND=";
      alt-c = optional (cfg.changeDirWidgetCommand == "") "FZF_ALT_C_COMMAND=";
    in
    concatStringsSep " " (ctrl-t ++ alt-c);

  prev = import (inputs.home-manager + "/modules/programs/fzf.nix") args;
in

lib.attrsets.recursiveUpdate prev {
  disabledModules = [ "${modulesPath}/programs/fzf.nix" ];

  options.programs.fzf.package.default = pkgs.fzf.overrideAttrs {
    # Prevent shell integrations from installing automatically
    postInstall = ''
      installManPage man/man1/fzf.1
    '';
  };

  config.content.programs.fish.interactiveShellInit.content = ''
    ${getExe cfg.package} --fish | ${variablesToDisableKeyBindings} source
  '';
}
