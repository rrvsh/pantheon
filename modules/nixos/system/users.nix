{
  config,
  lib,
  ...
}:
{
  config = lib.mkMerge [
    {
      users.mutableUsers = false;
      users.groups.users = {
        gid = 100;
        members = [ "${config.system.mainUser.name}" ];
      };
      users.users."${config.system.mainUser.name}" = {
        linger = true;
        uid = 1000;
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets."${config.system.mainUser.name}/hashedPassword".path;
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [ config.system.mainUser.publicKey ];
      };
      services.getty.autologinUser = config.system.mainUser.name;
      security.sudo.wheelNeedsPassword = false;
    }
  ];
}
