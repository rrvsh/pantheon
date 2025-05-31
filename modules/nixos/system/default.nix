{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./boot.nix
    ./users.nix
    ./localisation.nix
    ./nix-config.nix
    ./secrets.nix
  ];

  options.system = {
    hostname = lib.pantheon.mkStrOption;
    mainUser.name = lib.pantheon.mkStrOption;
    mainUser.publicKey = lib.pantheon.mkStrOption;
    bootloader = lib.pantheon.mkStrOption;
  };

  config = {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-cave.yaml";
    };
    system.stateVersion = "25.05"; # Did you read the comment?
  };
}
