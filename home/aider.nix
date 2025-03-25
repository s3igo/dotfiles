{
  pkgs,
  lib,
  osConfig,
  ...
}:

let
  package =
    let
      aider-chat = pkgs.aider-chat.withPlaywright;
    in
    pkgs.runCommand "${aider-chat.name}-wrapped" { nativeBuildInputs = [ pkgs.makeWrapper ]; }
      # --add-flags: Used instead of `--set` to specify API key at runtime
      ''
        mkdir -p $out/bin
        makeWrapper ${lib.getExe aider-chat} $out/bin/${aider-chat.meta.mainProgram} \
          --add-flags '--anthropic-api-key $(cat ${osConfig.age.secrets.aider-anthropic.path})'
      '';
  yamlFormat = pkgs.formats.yaml { };
  settings = {
    attribute-author = false;
    attribute-committer = false;
    auto-commits = false;
    cache-prompts = true;
    cache-keepalive-pings = 12;
    chat-language = "Japanese";
    dark-mode = true;
    # Required due to prompt caching limitations
    # Ref: https://aider.chat/docs/usage/caching.html#usage
    stream = false;
  };
in

{
  home = {
    packages = [ package ];
    file.".aider.conf.yml".source = yamlFormat.generate "aider-conf" settings;
  };
  programs.git.ignores = [ ".aider*" ];
}
