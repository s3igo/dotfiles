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
      playwright =
        let
          pred = drv: drv.pname == "playwright";
          drv = lib.findSingle pred "none" "multiple" aider-chat.dependencies;
        in
        assert drv != "none" && drv != "multiple";
        drv;
    in
    pkgs.runCommand "${aider-chat.name}-wrapped"
      {
        nativeBuildInputs = [ pkgs.makeWrapper ];
      }
      # Ref: https://nixos.wiki/wiki/Playwright
      # PLAYWRIGHT_BROWSERS_PATH: Related to https://github.com/Aider-AI/aider/issues/2192
      # PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS: https://wiki.nixos.org/wiki/Playwright
      # --add-flags: Used instead of `--set` to specify API key at runtime
      ''
        mkdir -p $out/bin
        makeWrapper ${lib.getExe aider-chat} $out/bin/${aider-chat.meta.mainProgram} \
          --set PLAYWRIGHT_BROWSERS_PATH "${playwright.driver.browsers}" \
          --set PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS true \
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
