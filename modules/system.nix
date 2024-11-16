{
  config,
  system,
  inputs,
  ...
}:

{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      extra-platforms = "x86_64-darwin aarch64-darwin";
      use-xdg-base-directories = true;
      substituters = [
        "https://nix-community.cachix.org?priority=41"
        "https://numtide.cachix.org?priority=42"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };
    optimise.automatic = true;
    extraOptions = ''
      !include ${config.age.secrets.github-nix-token.path}
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };

  # Match `NIX_PATH` with this flake.
  nix.channel.enable = false;
  # `nixpkgs` used in `nix run nixpkgs#hello` etc.
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  # `nixpkgs` used in `nix repl '<nixpkgs>'` etc.
  # environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nixpkgs = {
    hostPlatform = system;
    config.allowUnfree = true;
  };

  programs.fish.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
}
