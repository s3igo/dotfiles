{ pkgs, osConfig, ... }:

let
  package = pkgs.aider-chat.overrideAttrs rec {
    version = "0.60.0";
    src = pkgs.fetchFromGitHub {
      owner = "Aider-AI";
      repo = "aider";
      rev = "v${version}";
      hash = "sha256-0jAdUcGGJzxvTKY/56an0oLEghZHz6fdNLg8cPer1Qc=";
    };
    makeWrapperArgs = [
      "--add-flags '--anthropic-api-key $(cat ${osConfig.age.secrets.aider-anthropic.path})'"
    ];
  };
  yamlFormat = pkgs.formats.yaml { };
  settings = {
    auto-commits = false;
    attribute-author = false;
    attribute-committer = false;
    check-update = false;
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
