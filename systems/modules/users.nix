{ config, ... }:
{
  home-manager.users.rafiq.imports = [ ../../users/rafiq.nix ];
  users.users.rafiq = {
    isNormalUser = true;
    description = "rafiq";
    hashedPasswordFile = config.sops.secrets.password.path;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n"
    ];
  };
}
