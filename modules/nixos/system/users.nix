{ config, lib, pkgs, ... }:
{
  config = lib.mkMerge [
    {
      users.defaultUserShell = pkgs.zsh;
      users.users."${config.system.mainUser}" = {
        isNormalUser = true;
        initialPassword = "1";
        extraGroups = [ "wheel" ];
      };
      services.getty.autologinUser = config.system.mainUser;
    }
  ];
}
