{ config, ... }:
{
  time.timeZone = "Asia/Singapore";
  i18n.defaultLocale = "en_SG.UTF-8";

  users = {
    mutableUsers = false; # Always reset users on system activation

    groups.users = {
      gid = 100;
      members = [ "rafiq" ];
    };

    users.rafiq = {
      isNormalUser = true;
      description = "rafiq";
      hashedPasswordFile = config.sops.secrets."rafiq/password".path;
      uid = 1000;
      linger = true; # keep user services running
      extraGroups = [
        "networkmanager"
        "wheel"
        "audio" # Pipewire
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n"
      ];
    };
  };
}
