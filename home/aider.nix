{
  pkgs,
  lib,
  osConfig,
  ...
}:

let
  playwright =
    let
      pred = drv: drv.pname == "playwright";
      drv = lib.findSingle pred "none" "multiple" pkgs.aider-chat.optional-dependencies.playwright;
    in
    assert drv != "none" && drv != "multiple";
    drv;
  package = pkgs.aider-chat.withPlaywright.overrideAttrs (oldAttrs: {
    makeWrapperArgs = (oldAttrs.makeWrapperArgs or [ ]) ++ [
      # Ref: https://nixos.wiki/wiki/Playwright
      # Related: https://github.com/Aider-AI/aider/issues/2192
      ''--set PLAYWRIGHT_BROWSERS_PATH "${playwright.driver.browsers}"''
      "--set PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS true"
      # Use `--add-flags` instead of `--set` to configure API key at runtime
      "--add-flags '--anthropic-api-key $(cat ${osConfig.age.secrets.aider-anthropic.path})'"
    ];
  });
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
    packages = [ package ] ++ package.optional-dependencies.playwright;
    file.".aider.conf.yml".source = yamlFormat.generate "aider-conf" settings;
  };
  programs.git.ignores = [ ".aider*" ];
}
