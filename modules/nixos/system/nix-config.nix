{ config, ... }:
{
  config = {
    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];

      trusted-users = [ "@wheel" ];
    };
  };
}
