{ config, lib, pkgs, ... }:
{
  config = lib.mkMerge [
    {
      users.users."${config.system.mainUser}" = {
        isNormalUser = true;
        initialPassword = "1";
        extraGroups = [ "wheel" ];
      };
      services.getty.autologinUser = config.system.mainUser;
    }
  ];
}
