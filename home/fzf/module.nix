args@{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

let
  cfg = config.programs.fzf;

  variablesToDisableKeyBindings =
    let
      ctrl-t = lib.optional (cfg.fileWidgetCommand == "") "FZF_CTRL_T_COMMAND=";
      alt-c = lib.optional (cfg.changeDirWidgetCommand == "") "FZF_ALT_C_COMMAND=";
    in
    builtins.concatStringsSep " " (ctrl-t ++ alt-c);

  defaultModule = "${modulesPath}/programs/fzf.nix";
in

lib.recursiveUpdate (import defaultModule args) {
  disabledModules = [ defaultModule ];

  options.programs.fzf.package.default = pkgs.fzf.overrideAttrs {
    # Prevent shell integrations from installing automatically
    postInstall = ''
      installManPage man/man1/fzf.1
    '';
  };

  # https://github.com/junegunn/fzf/blob/master/README.md#setting-up-shell-integration
  config.content.programs.fish.interactiveShellInit.content = ''
    ${lib.getExe cfg.package} --fish | ${variablesToDisableKeyBindings} source
  '';
}
