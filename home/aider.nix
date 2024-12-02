{ pkgs, osConfig, ... }:

let
  package = pkgs.aider-chat.overrideAttrs {
    makeWrapperArgs = [
      "--add-flags '--anthropic-api-key $(cat ${osConfig.age.secrets.aider-anthropic.path})'"
    ];
  };
  yamlFormat = pkgs.formats.yaml { };
  settings = {
    attribute-author = false;
    attribute-committer = false;
    auto-commits = false;
    cache-prompts = true;
    chat-language = "Japanese";
    check-update = false;
    dark-mode = true;
    # Required due to prompt caching limitations
    # Ref: https://aider.chat/docs/usage/caching.html#usage
    stream = false;
  };
in

{
  home = {
    packages = [ package ] ++ package.optional-dependencies.playwright;
    # see: https://nixos.wiki/wiki/Playwright
    sessionVariables.PLAYWRIGHT_BROWSERS_PATH = pkgs.playwright-driver.browsers;
    file.".aider.conf.yml".source = yamlFormat.generate "aider-conf" settings;
  };
  programs.git.ignores = [ ".aider*" ];
}
