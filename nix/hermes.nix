{ lib, inputs, config, ... }:
{
  flake.images.hermes = config.flake.nixosConfigurations.hermes.config.system.build.sdImage;
  flake.nixosConfigurations.hermes = lib.nixosSystem {
    modules = [
      "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
      {
        nixpkgs.hostPlatform.system = "aarch64-linux";
        system.stateVersion = "25.11";
        users.users.root.openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n rafiq"
        ];
      }
    ];
  };
}
