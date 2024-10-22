{ pkgs, osConfig, ... }:

let
  package = pkgs.aider-chat.overrideAttrs {
    makeWrapperArgs = [
      "--add-flags '--anthropic-api-key $(cat ${osConfig.age.secrets.aider-anthropic.path})'"
    ];
  };
  yamlFormat = pkgs.formats.yaml { };
  settings = {
    auto-commits = false;
    attribute-author = false;
    attribute-committer = false;
    dark-mode = true;
  };
in

{
  home = {
    packages = [ package ];
    file.".aider.conf.yml".source = yamlFormat.generate "aider-conf" settings;
  };
  programs.git.ignores = [ ".aider*" ];
}
