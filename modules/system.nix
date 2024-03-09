{ config, ... }:
{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      extra-platforms = "x86_64-darwin aarch64-darwin";
      use-xdg-base-directories = true;
    };
    extraOptions = ''
      !include ${config.age.secrets.github-nix-token.path}
    '';
  };

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  programs.fish.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
}
