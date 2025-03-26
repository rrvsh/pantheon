{
  inputs,
  config,
  specialArgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = specialArgs;
  };

  time.timeZone = "Asia/Singapore";
  i18n.defaultLocale = "en_SG.UTF-8";

  users.mutableUsers = false; # Always reset users on system activation

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

  home-manager.users.rafiq.home = {
    username = "rafiq";
    homeDirectory = "/home/rafiq";
    stateVersion = "25.05";
  };

}
