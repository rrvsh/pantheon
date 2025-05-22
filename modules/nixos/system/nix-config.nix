{ config, inputs, ... }:
{
  config = {
    nixpkgs.config.allowUnfree = true;
      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

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
