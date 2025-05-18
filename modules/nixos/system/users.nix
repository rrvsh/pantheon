{ config, lib, pkgs, ... }:
{
  config = lib.mkMerge [
    {
    users.mutableUsers = false;
    users.groups.users = {
	gid = 100;
      members = [ "${config.system.mainUser}" ];
    };
      users.users."${config.system.mainUser}" = {
      linger = true;
      uid = 1000;
        isNormalUser = true;
        initialPassword = "1";
        extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n"
      ];
      };
      services.getty.autologinUser = config.system.mainUser;
    }
  ];
}
