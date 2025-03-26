{ config, specialArgs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = specialArgs;
  };

  users.mutableUsers = false; # Always reset users on system activation

  time.timeZone = "Asia/Singapore";
  i18n.defaultLocale = "en_SG.UTF-8";

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
